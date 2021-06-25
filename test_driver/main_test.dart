import 'package:emulators/emulators.dart' as emu;
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

Future<void> main() async {
  final driver = await FlutterDriver.connect();
  final config = await emu.buildConfig();
  final screenshot = emu.writeScreenshotFromEnv(config)(
    androidPath: 'fastlane/metadata/android/en-US/images/phoneScreenshots',
    iosPath: 'ios/fastlane/screenshots/en-AU',
  );

  setUpAll(() async {
    await driver.waitUntilFirstFrameRasterized();
    await emu.cleanStatusBarFromEnv(config);
  });

  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    await driver.close();
  });

  group('Screenshots', () {
    test('home screen', () async {
      await driver.waitFor(find.text('Vouchers'));
      await screenshot('01');
    });

    test('walmart', () async {
      await driver.tap(find.text('Walmart'));
      await driver.waitUntilNoTransientCallbacks();
      await screenshot('02');

      await driver.tap(find.text('Close'));
      await driver.waitUntilNoTransientCallbacks();
    });

    final buttonFinder = find.byType('FloatingActionButton');
    test('form', () async {
      await driver.tap(buttonFinder);
      await driver.waitUntilNoTransientCallbacks();
      await screenshot('03');
    });
  });
}
