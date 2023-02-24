import 'package:flutter_elemental/flutter_elemental.dart';
import 'package:vouchervault/app/index.dart';

final nucleusStorage = atom(
  (get) => get(runtimeAtom).runSyncOrThrow(storageLayer.access),
);

final appSettings = stateAtomWithStorage<VoucherVaultSettings>(
  const VoucherVaultSettings(),
  key: 'rp_persist_settingsProvider',
  storage: nucleusStorage,
  fromJson: VoucherVaultSettings.fromJson,
  toJson: (s) => s.toJson(),
);
