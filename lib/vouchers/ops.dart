import 'dart:convert';
import 'dart:io';

import 'package:dart_date/dart_date.dart';
import 'package:fpdt/fpdt.dart';
import 'package:fpdt/option.dart' as O;
import 'package:fpdt/reader_task_either.dart' as RTE;
import 'package:fpdt/state_reader_task_either.dart' as SRTE;
import 'package:fpdt/task_either.dart' as TE;
import 'package:share/share.dart';
import 'package:uuid/uuid.dart';
import 'package:vouchervault/app/providers.dart';
import 'package:vouchervault/lib/files.dart' as files;
import 'package:vouchervault/lib/milliunits.dart' as millis;
import 'package:vouchervault/lib/riverpod.dart';
import 'package:vouchervault/lib/srte.dart';
import 'package:vouchervault/models/voucher.dart';
import 'package:vouchervault/vouchers/model.dart';

final _log = loggerProvider('vouchers/ops.dart');

const _uuidgen = Uuid();

typedef VouchersOp<R>
    = StateReaderTaskEither<VouchersState, RefRead, String, R>;

VouchersOp<RefRead> ask() => SRTE.ask();
VouchersOp<void> askVoid() => SRTE.right(null);

// == Remove expired vouchers
IList<Voucher> _removeExpired(IList<Voucher> vouchers) => vouchers.removeWhere(
      (v) => v.removeAt.p(O.filter((expires) => expires.isPast)).p(O.isSome),
    );

final removeExpired = ask().p(SRTE.chainModify(
  (value) => value.copyWith(vouchers: _removeExpired(value.vouchers)),
));

// == Add new voucher
final create =
    (Voucher voucher) => ask().p(SRTE.chainModify((value) => value.copyWith(
          vouchers: value.vouchers.add(voucher.copyWith(
            uuid: O.some(_uuidgen.v4()),
          )),
        )));

// == Update voucher
final update =
    (Voucher voucher) => ask().p(SRTE.chainModify((value) => value.copyWith(
          vouchers: value.vouchers.updateById([voucher], (v) => v.uuid),
        )));

// == Update voucher balance from string
final _newBalance = (Voucher v) => (Option<String> s) => s
    .p(O.flatMap(millis.fromString))
    .p(O.map2K(v.balanceOption, (amount, int balance) => balance - amount));

final maybeUpdateBalance = (Voucher v) => _newBalance(v).c(O.fold(
      askVoid,
      (balance) => update(v.copyWith(
        balanceMilliunits: O.some(balance),
      )),
    ));

// == Remove voucher
final remove =
    (Voucher voucher) => ask().p(SRTE.chainModify((value) => value.copyWith(
          vouchers: value.vouchers.removeWhere((v) => v.uuid == voucher.uuid),
        )));

// == Import and replace voucher
final _importFromFiles = files
    .pick(['json'])
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

final import = ask()
    .p(SRTE.flatMapTaskEither((_) => _importFromFiles))
    .p(SRTE.flatMap(SRTE.put))
    .p(tapLeftC((read) => read(_log).warning));

// == Export vouchers to JSON file
final _writeStateToFile = (String fileName) => (VouchersState value) => TE
    .tryCatch(
      () => jsonEncode(value.toJson()),
      (err, stack) => 'encode json error: $err',
    )
    .p(TE.flatMap(files.writeString(fileName)));

final _shareFile = TE.tryCatchK(
  (File file) => Share.shareFiles(
    [file.path],
    subject: 'VoucherVault export',
  ),
  (err, stackTrace) => 'share files error: $err',
);

final export = ask()
    .p(SRTE.flatMapR(
      (_) => _writeStateToFile('vouchervault.json').c(RTE.fromTaskEither),
    ))
    .p(SRTE.flatMapTaskEither(_shareFile))
    .p(tapLeftC((read) => read(_log).warning));
