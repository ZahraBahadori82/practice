import 'package:equatable/equatable.dart';

abstract class CalculatorEvent extends Equatable {
  const CalculatorEvent();

  @override
  List<Object> get props => [];
}

class CalculateEvent extends CalculatorEvent {
  final double num1;
  final double num2;
  final String operator;

  const CalculateEvent({
    required this.num1,
    required this.num2,
    required this.operator,
  });

  @override
  List<Object> get props => [num1, num2, operator];
}

class ResetCalculatorEvent extends CalculatorEvent {}