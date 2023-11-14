


import 'package:appgain/core/services/network/network_info.dart';
import 'package:appgain/data_layer/datasource/local/local_data_base.dart';
import 'package:appgain/data_layer/repository/questions_answer_repository_imp.dart';
import 'package:appgain/domain_layer/repository/question_repository.dart';
import 'package:appgain/domain_layer/use_cases/getAllQuestionUseCase.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'core/services/local/cache_consumer.dart';


import 'core/services/network/network_client.dart';
import 'core/utils/logger.dart';
import 'data_layer/datasource/remote/dio/dio_client.dart';
import 'data_layer/datasource/remote/dio/logging_interceptor.dart';
import 'presentation_layer/logic/questions_cubit.dart';



final getIt = GetIt.instance;

Future<void> init() async {
  log("Injector Init", "Get it hass been initialized");
  /*
  * >USECASES<
  *
  *
  * */
  getIt.registerLazySingleton(() => GetAllQuestionsUseCase(getIt())) ;


  // /*
  // * Cubits
  // * */
  getIt.registerLazySingleton(() => QuestionsCubit(getIt()));
  // // /// Core
  getIt.registerLazySingleton(() => DioClient("", getIt(), loggingInterceptor: getIt(), cacheConsumer: getIt()));

  /// External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => NetworkClient());


  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => DataBaseHandler());
  getIt.registerLazySingleton(() => LoggingInterceptor());

  getIt.registerLazySingleton(() => const FlutterSecureStorage());
  getIt.registerLazySingleton(() => AppPrefs(secureStorage: getIt(), sharedPreferences: getIt()));
  // getIt.registerLazySingleton(() => InternetConnectionChecker());
  // getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));
  /*
  * Repository */
    getIt.registerLazySingleton<QuestionAnswerRepository>(() => QuestionAnswerRepositoryImp( getIt() , getIt() ));
} 
