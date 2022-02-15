import 'dart:async';
import 'dart:ffi';
import 'package:movieapp/data/local/model.dart';
import 'package:movieapp/data/local/repository/category_repository.dart';
import 'package:movieapp/data/local/repository/genre_repositry.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/domain/use_case/home_usecase.dart';
import 'package:movieapp/presentation/base/base_viewmodel.dart';
import 'package:movieapp/presentation/common/state_renderer/state_renderer.dart';
import 'package:movieapp/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  final _homeDataStreamController = BehaviorSubject<HomeData>();
  HomeUseCase _homeUseCase;
  CategoryRepository _categoryRepository;
  GenreRepository _genreRepository;
  HomeViewModel(
      this._homeUseCase, this._categoryRepository, this._genreRepository);

  @override
  void start() {
    _getHome();
  }

  _getHome() async {
    inputState.add(LoadingState());
    (await _homeUseCase.execute(Void)).fold((failure) {
      inputState.add(ErrorState(failure.message,StateRendererType.FULL_SCREEN_ERROR_STATE));
    }, (homeData) {
      inputState.add(ContentState());
      inputHomeData.add(homeData);
      _saveCategorytoLocal(homeData.categories);
      _saveGenretoLocal(homeData.genres);
    });
  }

  Future<void> _saveCategorytoLocal(List<Category?> categories) async {
    await _categoryRepository.deleteAll();
    for (var category in categories) {
      await _categoryRepository.saveToLocal(category);
    }
    int count = await _categoryRepository.getCount();
    print("category count : $count");
  }

  Future<void> _saveGenretoLocal(List<Genre?> genres) async {
    await _genreRepository.deleteAll();
    for (var genre in genres) {
      await _genreRepository.saveToLocal(genre);
    }
    int count = await _genreRepository.getCount();
    print("genre count : $count");
  }

  Future<List<LocalCategory>> getAllCategories()async{
    return await _categoryRepository.getAll();
  }
  
  
  Future<List<LocalGenre>> getAllGenres()async{
    return await _genreRepository.getAll();
  }

  @override
  void dispose() {
    _homeDataStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputHomeData => _homeDataStreamController.sink;

  @override
  Stream<HomeData> get outputHomeData =>
      _homeDataStreamController.stream.map((newMovie) => newMovie);
}

abstract class HomeViewModelInputs {
  Sink get inputHomeData;
}

abstract class HomeViewModelOutputs {
  Stream<HomeData> get outputHomeData;
}
