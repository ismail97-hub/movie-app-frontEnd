import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/presentation/components/movie_image_item.dart';
import 'package:movieapp/presentation/ressources/routes_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';

class MovieSwiper extends StatelessWidget {
  final List<Movie> movies;
  final double width;
  final double height;
  final double itemHeight;
  final double itemWidth;
  const MovieSwiper(this.movies,{Key? key,
        double? width,
        double? height,
        double? itemHeight,
        double? itemWidth,
      }) :
      width = width ?? AppSize.s400,
      height = width ?? AppSize.s400,
      itemHeight = itemHeight ?? AppSize.s400,
      itemWidth = itemWidth ?? AppSize.s400,
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.only(bottom: 40),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return MovieImageItem(
            image: movies[index].image,
            width: width,
          );
        },
        onTap: (index) {
          Navigator.pushNamed(context, Routes.movieDetailsRoute,
              arguments: movies[index].id);
        },
        // autoplay: true,
        itemCount: movies.length,
        itemHeight: itemHeight,
        itemWidth: itemWidth,
        layout: SwiperLayout.TINDER,
      ),
    );
  }
}
