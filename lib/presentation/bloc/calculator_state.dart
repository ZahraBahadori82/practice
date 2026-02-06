import 'package:equatable/equatable.dart';

abstract class CalculatorState extends Equatable {
  const CalculatorState();

  @override
  List<Object?> get props => [];
}

class CalculatorInitial extends CalculatorState {}

class CalculatorLoading extends CalculatorState {}

class CalculatorSuccess extends CalculatorState {
  final double result;

  const CalculatorSuccess({required this.result});

  @override
  List<Object?> get props => [result];
}

class CalculatorError extends CalculatorState {
  final String message;

  const CalculatorError({required this.message});

  @override
  List<Object?> get props => [message];
}