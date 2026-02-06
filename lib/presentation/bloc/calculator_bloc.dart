import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../domain/usecases/calculate_usecase.dart';
import 'calculator_event.dart';
import 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  final CalculateUseCase calculateUseCase;

  CalculatorBloc({required this.calculateUseCase})
      : super(CalculatorInitial()) {
    on<CalculateEvent>(
      _onCalculate,
      transformer: debounceTime(const Duration(milliseconds: 500)),
    );
    on<ResetCalculatorEvent>(_onReset);
  }

  Future<void> _onCalculate(
      CalculateEvent event,
      Emitter<CalculatorState> emit,
      ) async {
    emit(CalculatorLoading());

    try {
      final result = await calculateUseCase(
        num1: event.num1,
        num2: event.num2,
        operator: event.operator,
      );

      emit(CalculatorSuccess(result: result));
    } catch (e) {
      emit(CalculatorError(message: e.toString()));
    }
  }

  void _onReset(
      ResetCalculatorEvent event,
      Emitter<CalculatorState> emit,
      ) {
    emit(CalculatorInitial());
  }

  // RxDart transformer برای debounce کردن event ها
  EventTransformer<T> debounceTime<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}