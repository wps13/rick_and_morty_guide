import 'package:get_it/get_it.dart';
import '../data/services/api_client.dart';
import '../data/repositories/characters_remote_repository.dart';
import '../data/repositories/characters_repository.dart';
import '../ui/core/theme_controller.dart';
import '../ui/home/view_models/home_viewmodel.dart';
import '../ui/detail/view_models/detail_viewmodel.dart';
import 'package:flutter/material.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Services
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());

  // Repositories
  getIt.registerLazySingleton<CharactersRepository>(
    () => CharactersRemoteRepository(apiClient: getIt<ApiClient>()),
  );

  // State / ViewModels
  getIt.registerLazySingleton<ThemeController>(
    () => ThemeController(ThemeMode.dark),
  );

  // Registered as LazySingleton to preserve state as per original AppRouter implementation
  getIt.registerLazySingleton<HomeViewModel>(
    () => HomeViewModel(charactersRepository: getIt<CharactersRepository>()),
  );

  // Registered as Factory because it is screen-specific and transient
  getIt.registerFactory<DetailViewModel>(
    () => DetailViewModel(charactersRepository: getIt<CharactersRepository>()),
  );
}
