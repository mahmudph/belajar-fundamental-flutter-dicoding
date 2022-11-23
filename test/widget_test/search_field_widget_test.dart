/*
 * Created by mahmud on Wed Nov 23 2022
 * Email mahmud120398@gmail.com
 * Copyright (c) 2022 mahmud
 * Description
 */

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mahmud_flutter_restauran/ui/widgets/search_field_widget.dart';

import '../utils/utils.dart';

void main() {
  group('Test search field widget', () {
    late MaterialApp materialApp;
    const Color fillColor = Color.fromARGB(0, 30, 195, 195);
    const String hint = "Seach Restaurant";

    setUp(() {
      materialApp = createMaterialAppWithWidget(
        SearchFieldWidget(
          hint: hint,
          fillColor: fillColor,
          enableClearButton: false,
          onTapSearchPannel: () {},
        ),
      );
    });

    testWidgets(
      'should have accessor / property',
      (widgetTester) async {
        await widgetTester.pumpWidget(materialApp);
        await widgetTester.pumpAndSettle();

        var formField = widgetTester.widget<TextField>(
          find.byType(TextField),
        );

        expect(formField.controller, isNotNull);
        expect(formField.enabled, true);
        expect(formField.maxLines, 1);
        expect(formField.onTap, isNotNull);
        expect(formField.autofocus, false);
        expect(formField.decoration?.hintText, hint);
        expect(formField.decoration?.fillColor, fillColor);
        expect(formField.decoration?.suffixIcon, isNull);
      },
    );
  });
}
