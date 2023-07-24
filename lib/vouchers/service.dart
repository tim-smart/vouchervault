import 'dart:convert';
import 'dart:io';

import 'package:dart_date/dart_date.dart';
import 'package:flutter_elemental/flutter_elemental.dart';
import 'package:share/share.dart';
import 'package:uuid/uuid.dart';
import 'package:vouchervault/lib/lib.dart';
import 'package:vouchervault/vouchers/index.dart';

final vouchersLayer = Layer.scoped(
  StorageRef.make<VouchersState>(
    VouchersState(IList()),
    key: 'pbs_VouchersBloc',
    fromJson: VouchersState.fromJson,
    toJson: (a) => a.toJson(),
  )
      .map((_) => VouchersService(ref: _))
      .tap((_) => _.removeExpired.lift())
      .orDie,
);

final vouchersState = zioRefAtomSync(vouchersLayer.accessWith((_) => _.ref));

final vouchersAtom = vouchersState.select((_) => _.sortedVouchers);

final voucherAtom = atomFamily(
  (Option<String> uuid) =>
      vouchersState.select((s) => s.vouchers.where((v) => v.uuid == uuid).head),
);

class VouchersService {
  const VouchersService({required this.ref});

  final Ref<VouchersState> ref;
  final uuid = const Uuid();

  IO<Unit> get removeExpired =>
      ref.update((_) => _.copyWith(vouchers: _removeExpired(_.vouchers)));

  IO<Unit> create(Voucher voucher) => ref.update((_) => _.copyWith(
        vouchers: _.vouchers.add(voucher.copyWith(
          uuid: some(uuid.v4()),
        )),
      ));

  IO<Unit> update(Voucher voucher) => ref.update((_) => _.copyWith(
        vouchers: _.vouchers.updateById([voucher], (v) => v.uuid),
      ));

  IO<Unit> remove(Voucher voucher) => ref.update((_) => _.copyWith(
        vouchers: _.vouchers.removeWhere((v) => v.uuid == voucher.uuid),
      ));

  IO<Unit> maybeUpdateBalance(Voucher voucher, String input) =>
      _newBalance(voucher, input).match(
        () => ZIO.unit(),
        (balance) => update(voucher.copyWith(
          balanceMilliunits: some(balance),
        )),
      );

  IO<Unit> get import => _importFromFiles.tap(ref.set).ignoreLogged;

  IO<Unit> get export => ref
      .get<NoEnv, String>()
      .flatMap((_) => _writeAndShareState('vouchervault.json', _))
      .ignoreLogged;
}

// === Helpers ===

IList<Voucher> _removeExpired(IList<Voucher> vouchers) => vouchers.removeWhere(
      (v) => v.removeAt.filter((expires) => expires.isPast).isSome(),
    );

Option<int> _newBalance(Voucher v, String s) => optionOfString(s)
    .flatMap(millisFromString)
    .map2(v.balanceOption, (amount, int balance) => balance - amount);

// == Import and replace vouchers
final _importFromFiles = pickFile()
    .map((r) => String.fromCharCodes(r.$2))
    .flatMapThrowable(
      jsonDecode,
      (err, s) => 'Could not parse import JSON: $err',
    )
    .flatMapNullableOrFail(identity, (_) => 'Import was null')
    .flatMapThrowable(
      VouchersState.fromJson,
      (err, stack) => 'Could not convert json to VouchersState: $err',
    );

// == Export vouchers to JSON file
final _writeStateToFile = (String fileName, VouchersState value) => EIO
    .tryCatch(
      () => jsonEncode(value.toJson()),
      (err, stack) => 'encode json error: $err',
    )
    .flatMap((_) => writeStringToFile(fileName, _));

EIO<String, Unit> _shareFile(File file) => EIO
    .tryCatch(
      () => Share.shareFiles(
        [file.path],
        subject: 'VoucherVault export',
      ),
      (err, stackTrace) => 'share files error: $err',
    )
    .asUnit;

EIO<String, Unit> _writeAndShareState(String fileName, VouchersState state) =>
    _writeStateToFile(fileName, state).flatMap(_shareFile);
