import 'package:get_it/get_it.dart';
import 'data/datasources/native_calculator_datasource.dart';
import 'data/repositories/calculator_repository_impl.dart';
import 'domain/repositories/calculator_repository.dart';
import 'domain/usecases/calculate_usecase.dart';
import 'presentation/bloc/calculator_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
        () => CalculatorBloc(calculateUseCase: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => CalculateUseCase(sl()));

  // Repository
  sl.registerLazySingleton<CalculatorRepository>(
        () => CalculatorRepositoryImpl(nativeDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<NativeCalculatorDataSource>(
        () => NativeCalculatorDataSourceImpl(),
  );
}