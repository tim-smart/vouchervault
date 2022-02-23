import 'package:fpdt/fpdt.dart';
import 'package:fpdt/riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vouchervault/lib/riverpod.dart';
import 'package:vouchervault/vouchers/model.dart';
import 'package:vouchervault/vouchers/ops.dart';

final createVouchersSMProvider = ([VouchersState? initialOverride]) =>
    persistedSMProvider<VouchersState, RefRead, String>(
      create: (ref, initial) => StateRTEMachine(
        initialOverride ?? initial ?? VouchersState(IList()),
        ref.read,
      )..evaluate(removeExpired),
      key: 'VouchersBloc',
      fromJson: VouchersState.fromJson,
      toJson: (s) => s.toJson(),
    );

final vouchersSMProvider = createVouchersSMProvider();

final vouchersProvider = Provider(
  (ref) => stateMachineStateProvider(ref, ref.watch(vouchersSMProvider)),
);

final voucherProvider = Provider.autoDispose.family(
  (ref, Option<String> uuid) => ref
      .watch(vouchersProvider)
      .vouchers
      .firstWhereOption((v) => v.uuid == uuid),
);
