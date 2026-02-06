import '../repositories/calculator_repository.dart';

class CalculateUseCase {
  final CalculatorRepository repository;

  CalculateUseCase(this.repository);

  Future<double> call({
    required double num1,
    required double num2,
    required String operator,
  }) async {
    return await repository.calculate(num1, num2, operator);
  }
}