import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:givt_app_kids_web/core/app/app_config.dart';
import 'package:givt_app_kids_web/core/network/network.dart';
import 'package:givt_app_kids_web/features/auth/repositories/auth_repository.dart';
import 'package:givt_app_kids_web/features/parental_approval/repositories/transaction_decision_repository.dart';
import 'package:givt_app_kids_web/features/profiles/repository/profiles_repository.dart';
import 'package:givt_app_kids_web/features/recommendation/organisations/repositories/organisations_repository.dart';
import 'package:givt_app_kids_web/features/recommendation/quiz/repositories/tags_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> init(AppConfig config) async {
  await _initCoreDependencies();
  _initAPIService(config.apiBaseUrl);
  _initRepositories();
}

void _initAPIService(String baseUrl) {
  getIt.allowReassignment = true;

  log('Using API URL: $baseUrl');
  getIt.registerLazySingleton<APIService>(
    () => APIService(baseUrl),
  );
}

Future<void> _initCoreDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
}

void _initRepositories() {
  getIt.allowReassignment = true;

  getIt
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        getIt(),
        getIt(),
      ),
    )
    ..registerLazySingleton<OrganisationsRepository>(
      () => OrganisationsRepositoryImpl(
        getIt(),
      ),
    )
    ..registerLazySingleton<TagsRepository>(
      () => TagsRepositoryImpl(
        getIt(),
      ),
    )
    ..registerLazySingleton<TransactionDecisionRepository>(
      () => TransactionDecisionRepositoryImpl(
        getIt(),
      ),
    )
    ..registerLazySingleton<ProfilesRepository>(
      () => ProfilesRepositoryImpl(
        getIt(),
      ),
    );
  //   ..registerLazySingleton<OrganisationDetailsRepository>(
  //     () => OrganisationDetailsRepositoryImpl(
  //       getIt(),
  //     ),
  //   )
  //   ..registerLazySingleton<RecommendationRepository>(
  //     () => RecommendationRepositoryImpl(
  //       getIt(),
  //     ),
  //   )
  //   ..registerLazySingleton<CreateTransactionRepository>(
  //     () => CreateTransactionRepositoryImpl(
  //       getIt(),
  //     ),
}
