import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/app/constant.dart';
import 'package:movieapp/app/di.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:movieapp/presentation/components/horizontal_list_item.dart';
import 'package:movieapp/presentation/components/movie_image_item.dart';
import 'package:movieapp/presentation/components/tag_item.dart';
import 'package:movieapp/presentation/movie_details/components/details_app_bar.dart';
import 'package:movieapp/presentation/movie_details/components/info_text.dart';
import 'package:movieapp/presentation/components/ratting_item.dart';
import 'package:movieapp/presentation/movie_details/components/story_text.dart';
import 'package:movieapp/presentation/movie_details/components/title_year_item.dart';
import 'package:movieapp/presentation/movie_details/components/watch_button.dart';
import 'package:movieapp/presentation/movie_details/movie_details_viewmodel.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:movieapp/presentation/ressources/font_manager.dart';
import 'package:movieapp/presentation/ressources/icon_manager.dart';
import 'package:movieapp/presentation/ressources/routes_manager.dart';
import 'package:movieapp/presentation/ressources/strings_manager.dart';
import 'package:movieapp/presentation/ressources/styles_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';

class MovieDetailsView extends StatefulWidget {
  final int id;
  const MovieDetailsView({Key? key, required this.id}) : super(key: key);

  @override
  _MovieDetailsViewState createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  MovieDetailsViewModel _viewModel = instance<MovieDetailsViewModel>();

  _bind() {
    _viewModel.start();
    _viewModel.getDetails(widget.id);
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
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder: (context, snapshot) {
              return snapshot.data
                      ?.getScreenWidget(context, _getcontentWidget(), () {
                    _bind();
                  }) ??
                  Container();
            }),
      ),
    );
  }

  Widget _getcontentWidget() {
    return StreamBuilder<MoviesDetailsData>(
        stream: _viewModel.outputDetails,
        builder: (context, snapshot) {
          MoviesDetailsData? detailsData = snapshot.data;
          if (detailsData != null) {
            return _getDetailsWidget(detailsData);
          } else {
            return Container();
          }
        });
  }

  Widget _getDetailsWidget(MoviesDetailsData detailsData) {
    Movie movie = detailsData.movie;
    return SingleChildScrollView(
      child: Stack(
        children: [
          SizedBox(
            height: AppSize.s350,
            child: CachedNetworkImage(
              imageUrl: movie.image,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          detailsAppBar(context: context, viewModel: _viewModel, movie: movie),
          Container(
            margin: EdgeInsets.only(top: AppSize.s160, left: AppPadding.p20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                          height: AppSize.s250,
                          child: MovieImageItem(image: movie.image)),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: WatchButton(
                            margin: EdgeInsets.only(
                              top: AppSize.s130,
                            ),
                            onPressed: () {
                              _viewModel.watch(context, movie);
                            }),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: AppPadding.p20,
                ),
                // whole details
                _getMetaSection(movie),
                SizedBox(
                  height: AppPadding.p20,
                ),
                // related movies
                _getRelatedMovies(detailsData.relatedMovies),
                SizedBox(
                  height: AppPadding.p20,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _getMetaSection(Movie movie) {
    return Container(
      padding: EdgeInsets.only(right: AppPadding.p20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //title an year item
          TitleYearItem(
              title: movie.title, year: movie.year, color: ColorManager.red),
          SizedBox(
            height: AppPadding.p10,
          ),
          // quality and category
          InfoText(
            info1: movie.quality,
            info2: movie.category.label,
            onTap2: () {
              Navigator.pushNamed(context, Routes.movieListRoute,
                  arguments: MovieListArgs(
                      "${Endpoints.category}/${movie.category.id}",
                      movie.category.label));
            },
          ),
          // language and country
          InfoText(info1: movie.language, info2: movie.country),
          SizedBox(
            height: AppPadding.p10,
          ),
          // rating item
          RatingItem(movie.rating),
          // genres list
          _geGenresTag(movie.genres),
          SizedBox(
            height: AppPadding.p20,
          ),
          // overview section title
          _getSection(AppStrings.overview),
          SizedBox(
            height: AppPadding.p8,
          ),
          // story
          StoryText(movie.story),
        ],
      ),
    );
  }

  Widget _getRelatedMovies(List<Movie> relatedMovies) {
    if (relatedMovies.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // related section title
          _getSection(AppStrings.related),
          SizedBox(
            height: AppPadding.p15,
          ),
          SizedBox(
            height: AppSize.s250,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: relatedMovies
                  .map((movie) => HorizontalListmovie(movie))
                  .toList(),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _getSection(String title) {
    return Text(
      title,
      style:
          getBoldStyle(fontSize: FontSize.s18, color: ColorManager.secondary),
    );
  }

  Widget _geGenresTag(List<Genre>? genres) {
    if (genres != null && genres.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: AppPadding.p15,
          ),
          SizedBox(
            height: AppSize.s30,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: genres
                  .map(
                    (genre) => TagItem(genre),
                  )
                  .toList(),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
