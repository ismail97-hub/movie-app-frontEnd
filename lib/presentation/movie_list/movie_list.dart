import 'package:flutter/material.dart';
import 'package:movieapp/app/di.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/presentation/common/state_appbar/state_appbar_impl.dart';
import 'package:movieapp/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:movieapp/presentation/movie_list/components/grid_item.dart';
import 'package:movieapp/presentation/movie_list/movie_list_viewmodel.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:movieapp/presentation/ressources/icon_manager.dart';
import 'package:movieapp/presentation/ressources/routes_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MovieListView extends StatefulWidget {
  final MovieListArgs args;
  const MovieListView({Key? key, required this.args}) : super(key: key);

  @override
  _TopMoviesState createState() => _TopMoviesState();
}

class _TopMoviesState extends State<MovieListView> {
  MovieListViewModel _viewModel = instance<MovieListViewModel>();
  

  _bind({AppBarState? appBarState}) {
    _viewModel.inputAppBarState.add(appBarState??widget.args.appBarState);
    _viewModel.getMovieList(widget.args.endPoint);
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: ColorManager.primary,
            extendBodyBehindAppBar: true,
            appBar: PreferredSize(
              preferredSize: const Size(double.infinity, kToolbarHeight),
              child: StreamBuilder<AppBarState>(
                  stream: _viewModel.outputAppBarState,
                  builder: (context, snapshot) {
                    AppBarState? appBarState = snapshot.data;
                    return StreamBuilder<String>(
                      stream: _viewModel.outputSearchValue,
                      builder: (context, snapshot) {
                        return appBarState?.getAppBar(
                              _getAppBarContent(),
                              onPressed: () {
                                _viewModel.search(snapshot.data??"");
                              },
                              onBack: () {
                                _bind(appBarState: NormalAppBarState());
                              },
                              onSubmitted: (text) {
                                _viewModel.search(text);
                              },
                              onChanged: (text) {
                                _viewModel.inputSearchValue.add(text);
                              },
                            ) ??
                            AppBar();
                      }
                    );
                  }),
            ),
            body: Container(
              child: StreamBuilder<FlowState>(
                  stream: _viewModel.outputState,
                  builder: (context, snapshot) {
                    return snapshot.data?.getScreenWidget(
                            context, _getContentWidget(), () {
                              _bind();
                            }) ??
                        Container();
                  }),
            ),
          );
  }

  AppBar _getAppBarContent() {
    return AppBar(title: Text(widget.args.titleAppBar), actions: [
      IconButton(
          onPressed: () {
            _viewModel.inputAppBarState.add(SearchAppBarState());
          },
          icon: Icon(IconManager.search))
    ]);
  }

  Widget _getContentWidget() {
    return StreamBuilder<List<Movie>>(
        stream: _viewModel.outputMovieList,
        builder: (context, snapshot) {
          return _getGridViewWidget(snapshot.data);
        });
  }

  Widget _getGridViewWidget(List<Movie>? movies) {
    if (movies != null) {
      return StreamBuilder<bool>(
        stream: _viewModel.outputEnablePullDown,
        builder: (context, snapshot) {
          return SmartRefresher(
            controller: _viewModel.refreshController,
            enablePullUp: snapshot.data??true,
            enablePullDown: false,
            footer: ClassicFooter(),
            onLoading: ()=> _viewModel.onloading(movies, widget.args.endPoint),
            child: Padding(
              padding: const EdgeInsets.only(top:0.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                crossAxisCount: 3,
                childAspectRatio: 2 / 3,
                children: movies
                    .map((movie) => GridItem(movie))
                    .toList(),
              ),
            ),
          );
        }
      );
    } else {
      return Container();
    }
  }
}
