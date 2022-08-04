import 'dart:convert';
import 'dart:io';

import 'package:dart_date/dart_date.dart';
import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart' as O;
import 'package:fpdt/state_reader_task_either.dart' as SRTE;
import 'package:fpdt/task_either.dart' as TE;
import 'package:logging/logging.dart';
import 'package:share/share.dart';
import 'package:uuid/uuid.dart';
import 'package:vouchervault/app/app.dart';
import 'package:vouchervault/lib/lib.dart';
import 'package:vouchervault/vouchers/vouchers.dart';

final vouchersLogProvider = loggerProvider('vouchers/ops.dart');

class VouchersContext {
  const VouchersContext({
    required this.log,
    this.uuid = const Uuid(),
  });

  final Logger log;
  final Uuid uuid;
}

typedef VouchersOp<R>
    = StateReaderTaskEither<VouchersState, VouchersContext, String, R>;

VouchersOp<VouchersState> _get() => SRTE.get();
VouchersOp<VouchersContext> _ask() => SRTE.ask();
VouchersOp<void> _rightVoid() => SRTE.right(null);

VouchersOp<R> _logWarning<R>(VouchersOp<R> op) =>
    op.p(tapLeftC((c) => c.log.warning));

// == Remove expired vouchers
IList<Voucher> _removeExpired(IList<Voucher> vouchers) => vouchers.removeWhere(
      (v) => v.removeAt.p(O.filter((expires) => expires.isPast)).p(O.isSome),
    );

final VouchersOp<void> removeExpired = SRTE.modify(
  (value) => value.copyWith(vouchers: _removeExpired(value.vouchers)),
);

// == Add new voucher
VouchersOp<void> create(Voucher voucher) =>
    _ask().p(SRTE.flatMap((c) => SRTE.modify((value) => value.copyWith(
          vouchers: value.vouchers.add(voucher.copyWith(
            uuid: O.some(c.uuid.v4()),
          )),
        ))));

// == Update voucher
VouchersOp<void> update(Voucher voucher) =>
    SRTE.modify((value) => value.copyWith(
          vouchers: value.vouchers.updateById([voucher], (v) => v.uuid),
        ));

// == Update voucher balance from string
final _newBalance = (Voucher v) => (Option<String> s) => s
    .p(O.flatMap(millisFromString))
    .p(O.map2K(v.balanceOption, (amount, int balance) => balance - amount));

final maybeUpdateBalance = (Voucher v) => _newBalance(v).c(O.fold(
      _rightVoid,
      (balance) => update(v.copyWith(
        balanceMilliunits: O.some(balance),
      )),
    ));

// == Remove voucher
VouchersOp<void> remove(Voucher voucher) =>
    SRTE.modify((value) => value.copyWith(
          vouchers: value.vouchers.removeWhere((v) => v.uuid == voucher.uuid),
        ));

// == Import and replace vouchers
final _importFromFiles = pickFile()
    .p(TE.map((r) => String.fromCharCodes(r.second)))
    .p(TE.chainTryCatchK(
      jsonDecode,
      (err, s) => 'Could not parse import JSON: $err',
    ))
    .p(TE.chainNullableK(identity, (_) => 'Import was null'))
    .p(TE.chainTryCatchK(
      VouchersState.fromJson,
      (err, stack) => 'Could not convert json to VouchersState: $err',
    ));

final VouchersOp<Unit> import = _get()
    .p(SRTE.flatMapTaskEither((_) => _importFromFiles))
    .p(SRTE.flatMap(SRTE.put))
    .p(_logWarning);

// == Export vouchers to JSON file
final _writeStateToFile = (String fileName) => (VouchersState value) => TE
    .tryCatch(
      () => jsonEncode(value.toJson()),
      (err, stack) => 'encode json error: $err',
    )
    .p(TE.flatMap(writeStringToFile(fileName)));

final _shareFile = TE
    .tryCatchK(
      (File file) => Share.shareFiles(
        [file.path],
        subject: 'VoucherVault export',
      ),
      (err, stackTrace) => 'share files error: $err',
    )
    .c(TE.map((_) => unit));

final _writeAndShareState =
    (String fileName) => _writeStateToFile(fileName).c(TE.flatMap(_shareFile));

final VouchersOp<Unit> export = _get()
    .p(SRTE.flatMapTaskEither(_writeAndShareState('vouchervault.json')))
    .p(_logWarning);
