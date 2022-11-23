/*
 * Created by mahmud on Wed Nov 23 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mahmud_flutter_restauran/ui/widgets/widgets.dart';

import '../utils/utils.dart';

void main() {
  group('test chip widget', () {
    late MaterialApp materialApp;
    const chipValue = "Test";

    setUp(() {
      materialApp = createMaterialAppWithWidget(const ChipWidget(
        value: chipValue,
      ));
    });

    testWidgets(
      'when ChipWidget value were provided then should use default child',
      (widgetTester) async {
        await widgetTester.pumpWidget(materialApp);
        await widgetTester.pumpAndSettle();

        final findText = widgetTester.widget<Text>(
          find.byType(Text),
        );

        expect(findText.data, chipValue);
        expect(findText.style?.color, Colors.black);
        expect(findText.style?.fontWeight, FontWeight.w600);
      },
    );

    testWidgets(
      'when ChipWidget value and child were not provided then should throw assert error',
      (widgetTester) async {
        expect(() => ChipWidget(), throwsAssertionError);
      },
    );

    testWidgets(
      'when ChipWidget can use child widget instead of default child',
      (widgetTester) async {
        var materialApp = createMaterialAppWithWidget(const ChipWidget(
          child: SizedBox(),
        ));

        await widgetTester.pumpWidget(materialApp);
        await widgetTester.pumpAndSettle();

        final findBox = widgetTester.widget<SizedBox>(
          find.byType(SizedBox),
        );

        expect(
          () => widgetTester.widget<Text>(find.byType(Text)),
          throwsStateError,
        );
        expect(findBox, isNotNull);
      },
    );
  });
}
