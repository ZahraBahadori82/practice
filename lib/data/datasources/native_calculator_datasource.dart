import 'package:flutter/services.dart';

abstract class NativeCalculatorDataSource {
  Future<double> performCalculation(double num1, double num2, String operator);
}

class NativeCalculatorDataSourceImpl implements NativeCalculatorDataSource {
  static const platform = MethodChannel('com.example.calculator/native');

  @override
  Future<double> performCalculation(
      double num1,
      double num2,
      String operator,
      ) async {
    try {
      final double result = await platform.invokeMethod('calculate', {
        'num1': num1,
        'num2': num2,
        'operator': operator,
      });
      return result;
    } on PlatformException catch (e) {
      throw Exception('خطا در محاسبه: ${e.message}');
    }
  }
}