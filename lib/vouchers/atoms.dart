import 'package:flutter_nucleus/flutter_nucleus.dart';
import 'package:fpdt/fpdt.dart';
import 'package:vouchervault/lib/lib.dart';
import 'package:vouchervault/vouchers/vouchers.dart';

final createVoucherSM = ([VouchersState? initialState]) =>
    StateRTEMachine<VouchersState, VouchersContext, String>(
      initialState ?? VouchersState(IList()),
      const VouchersContext(),
    );

final vouchersState = smAtom<VouchersState, VouchersContext, String>(
  (get, initialValue) => createVoucherSM(initialValue)..run(removeExpired),
  key: 'pbs_VouchersBloc',
  fromJson: VouchersState.fromJson,
  toJson: (s) => s.toJson(),
).keepAlive();

final voucherAtom = atomFamily((Option<String> uuid) => vouchersState
    .select((s) => s.vouchers.firstWhereOption((v) => v.uuid == uuid)));
