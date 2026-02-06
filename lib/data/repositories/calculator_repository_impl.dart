import '../../domain/repositories/calculator_repository.dart';
import '../datasources/native_calculator_datasource.dart';

class CalculatorRepositoryImpl implements CalculatorRepository {
  final NativeCalculatorDataSource nativeDataSource;

  CalculatorRepositoryImpl({required this.nativeDataSource});

  @override
  Future<double> calculate(double num1, double num2, String operator) async {
    return await nativeDataSource.performCalculation(num1, num2, operator);
  }
}