import 'package:emulators/emulators.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

Future<void> main() async {
  final driver = await FlutterDriver.connect();
  final emu = await Emulators.build();
  final screenshot = emu.screenshotHelper(
    androidPath:
        'android/fastlane/metadata/android/en-US/images/phoneScreenshots',
    iosPath: 'ios/fastlane/screenshots/en-AU',
  );

  setUpAll(() async {
    await driver.waitUntilFirstFrameRasterized();
    await screenshot.cleanStatusBar();
    await emu.toolchain.adb([
      "-s",
      screenshot.device!.state.id,
      "shell",
      "pm",
      "grant",
      "co.timsmart.vouchervault",
      "android.permission.CAMERA",
    ]).string();
  });

  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    await driver.close();
  });

  group('Screenshots', () {
    test('home screen', () async {
      await driver.waitFor(find.text('Vouchers'));
      await screenshot.capture('01');
    });

    test('walmart', () async {
      await driver.tap(find.ancestor(
        of: find.text('Walmart'),
        matching: find.byType('VoucherItem'),
      ));
      await driver.waitUntilNoTransientCallbacks();
      await screenshot.capture('02');
    });

    test('walmart spend', () async {
      await driver.tap(find.byValueKey('SpendIconButton'));
      await driver.waitUntilNoTransientCallbacks();
      await screenshot.capture('03');

      await driver.tap(find.text('Cancel'));
      await driver.waitUntilNoTransientCallbacks();

      await driver.tap(find.text('Close'));
      await driver.waitUntilNoTransientCallbacks();
    });

    final buttonFinder = find.byType('FloatingActionButton');
    test('form', () async {
      await driver.tap(buttonFinder);
      await driver.waitUntilNoTransientCallbacks();
      await driver.tap(find.text('Cancel'));
      await driver.waitUntilNoTransientCallbacks();
      await screenshot.capture('04');
    });
  });
}
