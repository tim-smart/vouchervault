import 'dart:io';

import 'package:emulators/emulators.dart';

Future<void> main() async {
  final emu = await Emulators.build();

  // Shutdown all the running emulators
  await emu.shutdownAll();

  await emu.forEach(['Nexus_5X'])((device) async {
    final p = await emu.drive(
      device,
      'test_driver/main.dart',
      args: ['--flavor', 'local'],
    );
    stderr.addStream(p.stderr);
    await stdout.addStream(p.stdout);
  });
}
