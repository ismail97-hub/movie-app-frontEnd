import 'dart:async';
import 'dart:ffi';

import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/domain/use_case/history_usecase.dart';
import 'package:movieapp/presentation/base/base_viewmodel.dart';
import 'package:movieapp/presentation/common/state_renderer/state_renderer.dart';
import 'package:movieapp/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:movieapp/presentation/ressources/assets_manager.dart';
import 'package:movieapp/presentation/ressources/strings_manager.dart';
import 'package:rxdart/rxdart.dart';

class HistoryViewModel extends BaseViewModel
    with HistoryViewModelInput, HistoryViewModelOutput {
  StreamController _historyStreamController = BehaviorSubject<List<Movie>>();
  HistoryUseCase _useCase;
  HistoryViewModel(this._useCase);

  @override
  void start() {
    _getHistory();
  }

  _getHistory() async {
    inputState.add(LoadingState());
    (await _useCase.execute(Void)).fold((failure) {
      inputState.add(ErrorState(
          failure.message, StateRendererType.FULL_SCREEN_ERROR_STATE));
    }, (history) {
      if (history.isEmpty) {
        inputState.add(EmptyState(AppStrings.emptyHistory, JsonAssets.history));
      } else {
        inputHistory.add(history);
        inputState.add(ContentState());
      }
    });
  }

  @override
  void dispose() {
    _historyStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputHistory => _historyStreamController.sink;

  @override
  Stream<List<Movie>> get outputHistory =>
      _historyStreamController.stream.map((history) => history);
}

abstract class HistoryViewModelInput {
  Sink get inputHistory;
}

abstract class HistoryViewModelOutput {
  Stream<List<Movie>> get outputHistory;
}
