

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:movieapp/app/ad_service.dart';
import 'package:movieapp/app/app_prefs.dart';
import 'package:movieapp/app/services.dart';
import 'package:movieapp/data/data_source/local_data_source.dart';
import 'package:movieapp/data/data_source/remote_data_source.dart';
import 'package:movieapp/data/local/repository/category_repository.dart';
import 'package:movieapp/data/local/repository/favorite_repository.dart';
import 'package:movieapp/data/local/repository/genre_repositry.dart';
import 'package:movieapp/data/local/repository/history_repository.dart';
import 'package:movieapp/data/network/app_api/app_api.dart';
import 'package:movieapp/data/network/dio_factory.dart';
import 'package:movieapp/data/network/network_info.dart';
import 'package:movieapp/data/repository/repository_impl.dart';
import 'package:movieapp/domain/repository/repository.dart';
import 'package:movieapp/domain/use_case/favorite_usecase.dart';
import 'package:movieapp/domain/use_case/history_usecase.dart';
import 'package:movieapp/domain/use_case/home_usecase.dart';
import 'package:movieapp/domain/use_case/movie_details_usecase.dart';
import 'package:movieapp/domain/use_case/movie_list_usecase.dart';
import 'package:movieapp/domain/use_case/splash_usecase.dart';
import 'package:movieapp/presentation/favorites/favorites_viewmodel.dart';
import 'package:movieapp/presentation/history/history_viewmodel.dart';
import 'package:movieapp/presentation/home/home_viewmodel.dart';
import 'package:movieapp/presentation/movie_details/movie_details_viewmodel.dart';
import 'package:movieapp/presentation/movie_list/movie_list_viewmodel.dart';
import 'package:movieapp/presentation/movie_player/movie_player_viewmodel.dart';
import 'package:movieapp/presentation/settings/settings_viewmodel.dart';
import 'package:movieapp/presentation/splashScreen/splash_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule()async{
  
  final sharedPreferences = await SharedPreferences.getInstance();
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  FirebaseInAppMessaging fiam = FirebaseInAppMessaging.instance;
  
  // shared Prefernces
  instance.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // app preferences
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
  
  // fireBase messaging
  instance.registerLazySingleton<FirebaseMessaging>(() => firebaseMessaging);

  // fireBase in-app messaging
  instance.registerLazySingleton<FirebaseInAppMessaging>(() => fiam);

  // fireBase dynamic links
  instance.registerLazySingleton<FirebaseDynamicLinks>(() => dynamicLinks);

  // network info
  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(DataConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  // app service client
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));
  
  // admob service
  instance.registerLazySingleton<AdService>(() => AdServicImpl());

  // dynamic link service
  instance.registerLazySingleton<DynamicLinksService>(() => DynamicLinksServiceImpl(instance()));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(instance()));
  
  // local data source
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  // repository
  instance.registerLazySingleton<Repository>(() => RepositoryImpl(instance(),instance(),instance()));

  // local favorite repository
  instance.registerLazySingleton<FavoriteRepository>(() => FavoriteRepositoryImpl());

  // local genre repository
  instance.registerLazySingleton<HistoryRepository>(() => HistoryRepositoryImpl());
  
  // local category repository
  instance.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl());

  // local genre repository
  instance.registerLazySingleton<GenreRepository>(() => GenreRepositoryImpl());
  
}

initHomeModule(){
  if(!GetIt.I.isRegistered<HomeUseCase>()){
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance(),instance(),instance()));
  }
}

initMovieDetailsModule(){
  if(!GetIt.I.isRegistered<MovieDetailsUseCase>()){
    instance.registerFactory<MovieDetailsUseCase>(() => MovieDetailsUseCase(instance(),instance(),instance()));
    instance.registerFactory<MovieDetailsViewModel>(() => MovieDetailsViewModel(instance(),instance()));
  }
}

initFavoritesModule(){
  if(!GetIt.I.isRegistered<FavoriteUseCase>()){
    instance.registerFactory<FavoriteUseCase>(() => FavoriteUseCase(instance()));
    instance.registerFactory<FavoriteViewModel>(() => FavoriteViewModel(instance()));
  }
}

initHistoryModule(){
  if(!GetIt.I.isRegistered<HistoryUseCase>()){
    instance.registerFactory<HistoryUseCase>(() => HistoryUseCase(instance()));
    instance.registerFactory<HistoryViewModel>(() => HistoryViewModel(instance()));
  }
}


initMovieListModule(){
  if(!GetIt.I.isRegistered<MovieListUseCase>()){
    instance.registerFactory<MovieListUseCase>(() => MovieListUseCase(instance()));
    instance.registerFactory<MovieListViewModel>(() => MovieListViewModel(instance()));
  }
}

initSplashModule(){
  if(!GetIt.I.isRegistered<SplashUseCase>()){
    instance.registerFactory<SplashUseCase>(() => SplashUseCase(instance(),instance()));
    instance.registerFactory<SplashViewModel>(() => SplashViewModel(instance(),instance(),instance()));
  }
}

initMoviePlayerModule(){
  if(!GetIt.I.isRegistered<MoviePlayerViewModel>()){
    instance.registerFactory<MoviePlayerViewModel>(() => MoviePlayerViewModel());
  }
}

initSettingsModule(){
  if(!GetIt.I.isRegistered<SettingsViewModel>()){
    instance.registerFactory<SettingsViewModel>(() => SettingsViewModel(instance(),instance()));
  }
}

resetModule(){
  instance.reset(dispose: false);
  initAppModule();
  initHomeModule();
  initMovieDetailsModule();
  initFavoritesModule();
  initHistoryModule();
  initMovieListModule();
  initSplashModule();
  initMoviePlayerModule();
}