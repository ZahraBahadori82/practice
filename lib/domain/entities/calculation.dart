import 'package:equatable/equatable.dart';

class Calculation extends Equatable {
  final double num1;
  final double num2;
  final String operator;
  final double? result;

  const Calculation({
    required this.num1,
    required this.num2,
    required this.operator,
    this.result,
  });

  Calculation copyWith({
    double? num1,
    double? num2,
    String? operator,
    double? result,
  }) {
    return Calculation(
      num1: num1 ?? this.num1,
      num2: num2 ?? this.num2,
      operator: operator ?? this.operator,
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props => [num1, num2, operator, result];
}