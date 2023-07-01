import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_task_flutter/colors.dart';
import 'package:test_task_flutter/random_number_generator.dart';
import 'package:test_task_flutter/yellow_screen.dart';
import 'dart:math';


void main() {
  testWidgets(
      'Проверяем, что при тапе по кнопке число от 0 до 49 отображается синим цветом',
      (WidgetTester tester) async {


        // Создаем инстанс генератора случайных чисел
      final randomNumberGenerator = RandomNumberGenerator2();

      // Строим виджет желтого экрана
      await tester.pumpWidget(
        MaterialApp(
          home: YellowScreen(generator: randomNumberGenerator),
        ),
      );
      // Проверяем отображение кнопки "случайное число"
      expect(find.widgetWithText(ElevatedButton, 'Случайное число'), findsOneWidget);

      // Проверка фона экрана
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.backgroundColor, Colors.yellow.shade800);


      // Проверка отображения кнопки "назад"
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);

      // Нажатие на кнопку "случайное число"
      //await tester.tap(find.byType(ElevatedButton));
      await tester.tap(find.text('Случайное число'));
      await tester.pump(const Duration(seconds: 2));


      // Проверка отображения числа от 0 до 49 синим цветом
      expect(find.textContaining(RegExp(r'^[0-9]{1,2}$')), findsOneWidget);
      final numberWidget = tester.widget<Text>(find.textContaining(RegExp(r'^[0-9]{1,2}$')));
      expect(numberWidget.style!.color, equals(blueColor));


      }
  );
}


  class RandomNumberGenerator2 extends RandomNumberGenerator {
  @override
  final Random _random = Random();
  @override
  int generate() {
  return _random.nextInt(100);
  }
}



