import 'dart:io';

import 'package:emulators/emulators.dart' as emu;

Future<void> main() async {
  final config = await emu.buildConfig();

  // Shutdown all the running emulators
  await emu.shutdownAll(config);

  await emu.forEach(config)([
    'Nexus_5X',
  ])((device) async {
    final p = await emu.drive(config)(
      device,
      'test_driver/main.dart',
      args: ['--flavor', 'local'],
    );
    stderr.addStream(p.stderr);
    await stdout.addStream(p.stdout);
  });
}
