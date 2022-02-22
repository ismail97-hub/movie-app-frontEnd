import 'package:flutter/material.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/presentation/components/movie_image_item.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:movieapp/presentation/ressources/font_manager.dart';
import 'package:movieapp/presentation/ressources/icon_manager.dart';
import 'package:movieapp/presentation/ressources/routes_manager.dart';
import 'package:movieapp/presentation/ressources/styles_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';

class FavoriteGridItem extends StatelessWidget {
  final Movie movie;
  final Function unFavorite;
  const FavoriteGridItem(
    this.movie, {
    required this.unFavorite,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.movieDetailsRoute,
            arguments: movie.id);
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              Expanded(
                flex: 10,
                child: MovieImageItem(
                  image: movie.image,
                  radius: AppSize.s8,
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.all(AppPadding.p5),
                  child: Column(
                    children: [
                      Text(movie.title,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: getSemiBoldStyle(
                              fontSize: FontSize.s12, color: Colors.white)),
                      Text(movie.year,
                          style: getBoldStyle(
                              fontSize: FontSize.s12,
                              color: ColorManager.secondary)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: AppSize.s5,
            left: AppSize.s10,
            height: AppSize.s35,
            width: AppSize.s35,
            child: CircleAvatar(
              radius: AppSize.s30,
              backgroundColor: ColorManager.black.withOpacity(0.3),
              child: IconButton(
                  onPressed: () {
                    unFavorite.call();
                  },
                  icon: Icon(
                    IconManager.favorite,
                    color: ColorManager.secondary,
                    size: FontSize.s20,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
