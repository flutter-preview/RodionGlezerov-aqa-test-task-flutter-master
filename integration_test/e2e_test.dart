import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_task_flutter/main.dart';

void main() {
  testWidgets(
    'E2E test',
    (WidgetTester tester) async {
      // Шаг 1: Тапнуть на "зеленый"
      await tester.pumpWidget(const MyApp());
      var greenBtn = find.widgetWithText(ElevatedButton, 'зеленый');
      var yellowBtn = find.widgetWithText(ElevatedButton, 'желтый');
      await tester.tap(greenBtn);
      await tester.pump(const Duration(seconds: 2));


      // Проверка: Открыт экран с белой надписью "зеленый экран" и зеленым фоном

      expect(
        find.byWidgetPredicate(
              (widget) =>
          widget is Text &&
              widget.data == 'Зеленый экран' &&
              widget.style?.color == Colors.white
        ),
        findsOneWidget,
      );

      expect(
        (tester.widgetList(find.byType(Container)).last as Container).color,
        equals(Colors.green),
      );

      // Шаг 2: Тапнуть кнопку назад
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pump(const Duration(seconds: 2));


      // Проверка: Попадаем на стартовый экран
      expect(find.text('зеленый'), findsOneWidget);
      expect(find.text('желтый'), findsOneWidget);

      // Шаг 3: Тапнуть на "желтый"
      await tester.tap(yellowBtn);
      await tester.pump(const Duration(seconds: 2));

      // Проверка: Открыт экран с кнопкой "случайное число", текст в центре экрана не отображается
      expect(find.widgetWithText(ElevatedButton, 'Случайное число'), findsOneWidget);

      expect(find.descendant(
        of: find.byType(Container),
        matching: find.text(''),
        matchRoot: true,
      ), findsNothing);

      expect(find.byWidgetPredicate((widget) => widget is Text && widget.data == ''), findsNothing);

      // Шаг 4: Тапнуть кнопку "случайное число"
      await tester.tap(find.text('Случайное число'));
      await tester.pump(const Duration(seconds: 2));

      // Проверка: Отображается надпись с числом от 0 до 99 в центре экрана
      expect(
        find.descendant(
          of: find.byType(Container),
          matching: find.textContaining(RegExp(r'^[0-9]{1,2}$')),
        ),
        findsOneWidget,
      );
      expect(find.byType(Center), findsOneWidget);

      // Шаг 5: Тапнуть кнопку назад
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pump(const Duration(seconds: 2));

      // Проверка: Попадаем на стартовый экран
      expect(find.text('зеленый'), findsOneWidget);
      expect(find.text('желтый'), findsOneWidget);

    },
  );


}
