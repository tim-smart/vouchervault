import 'dart:io';

import 'package:emulators/emulators.dart';

Future<void> main() async {
  final emu = await Emulators.build();

  // Shutdown all the running emulators
  await emu.shutdownAll();

  await emu.forEach(['Pixel_3'])((device) async {
    final p = await emu.drive(
      device,
      'test_driver/main.dart',
    );
    stderr.addStream(p.stderr);
    await stdout.addStream(p.stdout);
  });
}
