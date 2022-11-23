/*
 * Created by mahmud on Tue Nov 22 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mahmud_flutter_restauran/ui/widgets/button_widget.dart';

import '../utils/utils.dart';

void main() {
  group('test of the button widget', () {
    late MaterialApp materialApp;
    const buttonName = "Mulai";

    setUp(
      () async {
        materialApp = createMaterialAppWithWidget(
          ButtonWidget(onPress: () {}, buttonName: buttonName),
        );
      },
    );

    testWidgets(
      'button should have valid button name',
      (WidgetTester tester) async {
        await tester.pumpWidget(materialApp);
        await tester.pumpAndSettle();

        // expected padding
        var expectedPaddingButtonTextWidet = const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 12,
        );

        final expectedButtonName = tester.widget<Text>(
          find.byType(Text),
        );

        var paddingWidget = tester.firstWidget<Padding>(find.byType(Padding));

        expect(expectedButtonName.data, buttonName);
        expect(
          paddingWidget,
          isA<Padding>().having(
            (p0) => p0.padding,
            'padding',
            expectedPaddingButtonTextWidet,
          ),
        );
      },
    );

    testWidgets("should have textAlign as center", (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(materialApp);
      await tester.pumpAndSettle();

      /// find that the butoonshould have text with name of $text variabel
      expect(find.text(buttonName), findsOneWidget);

      expect(
        tester.widget(find.byType(Text)),
        isA<Text>().having(
          (t) => t.textAlign,
          'textAlign',
          TextAlign.center,
        ),
      );
    });
  });
}
