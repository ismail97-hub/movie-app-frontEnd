import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/app/ad_service.dart';
import 'package:movieapp/app/di.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/presentation/components/movie_image_item.dart';
import 'package:movieapp/presentation/ressources/routes_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';

class MovieCarousel extends StatelessWidget {
  final List<Movie> movies;
  final double width;
  final double height;
  final double viewportFraction;
  const MovieCarousel(this.movies,
      {Key? key, double? width, double? height, double? viewportFraction})
      : height = height ?? AppSize.s210,
        width = width ?? AppSize.s210,
        viewportFraction = viewportFraction ?? AppSize.s0_5,
        super(key: key);

   
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: movies
            .map((movie) => SizedBox(
                  width: width,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.movieDetailsRoute,
                          arguments: movie.id);
                    },
                    child: MovieImageItem(
                      image: movie.image,
                      width: width,
                    ),
                  ),
                ))
            .toList(),
        options: CarouselOptions(
            autoPlay: true,
            height: height,
            enableInfiniteScroll: true,
            // disableCenter: true,
            viewportFraction: viewportFraction,
            enlargeCenterPage: true));
  }
}
