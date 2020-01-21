import 'dart:async';
import 'dart:io';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';


void main() {
  group('startup_namer app', () {
    final savedSuggestionsIcon = find.byValueKey('saved_suggestions_icon');
    final suggestedList = find.byValueKey('suggested_list');
    final suggestion2 = find.byValueKey('suggestion2');
    final suggestion4 = find.byValueKey('suggestion4');
    final suggestion50 = find.byValueKey('suggestion50');
    final Duration dur = new Duration(hours:0, minutes:0, seconds:5);
    final saved0 = find.byValueKey('saved0');
    final saved1 = find.byValueKey('saved1');
    final saved2 = find.byValueKey('saved2');
    final savedList = find.byValueKey('savedList');
    var expectedSaved0, expectedSaved1, expectedSaved2;
    final heart2 = find.byValueKey('heart_index_2');


    FlutterDriver driver;

    setUpAll(() async {
//      final Map<String, String> envVars = Platform.environment;
//      final String adbPath = envVars['ANDROID_SDK_ROOT'] + '/platform-tools/adb';
//      await Process.run(adbPath , ['shell' ,'pm', 'grant', 'com.startup_namer', 'android.permission.READ_EXTERNAL_STORAGE']);
//      await Process.run(adbPath , ['shell' ,'pm', 'grant', 'com.startup_namer', 'android.permission.READ_PHONE_STATE']);
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    Future<void>saveSuggestedNames() async {

    }

    test('clicks on saved suggestion icon in home and verifies a empty saved list', () async {
      await driver.tap(savedSuggestionsIcon);
      await Future.delayed(Duration(seconds: 5));
      await driver.waitForAbsent(saved0);
      await driver.tap(find.byTooltip('Back'));
    });

    test('scroll down to a specific item', () async {
      await driver.scrollUntilVisible(suggestedList, suggestion50, dyScroll: -300.0);
      await driver.waitFor(suggestion50);
    });

//    test('clicks on the heart icon and saves suggested names', () async {
//
//    });
//
//    test('verifies saved names in saved item list', () async {
//
//    });



    test('saves 3rd and 4th & 51st suggested name and verifies if the saved names are found in saved list', () async {

      await driver.tap(suggestion2);
      await driver.tap(suggestion4);

      expectedSaved0 = await driver.getText(suggestion2);
      expectedSaved1 = await driver.getText(suggestion4);
      await Future.delayed(Duration(seconds: 3));
      await driver.scrollUntilVisible(suggestedList, suggestion50, dyScroll: -300.0);
      await driver.tap(suggestion50);

      expectedSaved2 = await driver.getText(suggestion50);
      await Future.delayed(Duration(seconds: 2));
      await driver.tap(savedSuggestionsIcon);
      final actualSaved0 = await driver.getText(saved0);
      final actualSaved1 = await driver.getText(saved1);
      final actualSaved2 = await driver.getText(saved2);
      await Future.delayed(Duration(seconds: 3));
      await driver.tap(find.byTooltip('Back'));




      expect(
          actualSaved0,
          expectedSaved0
      );
      expect(
        actualSaved1,
        expectedSaved1
      );
      expect(
          actualSaved2,
          expectedSaved2
      );

    });





  });
}