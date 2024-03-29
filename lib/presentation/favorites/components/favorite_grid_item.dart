import 'package:flutter/material.dart';
import 'package:movieapp/data/local/model.dart';
import 'package:movieapp/data/mapper/mapper.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/presentation/components/movie_image_item.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:movieapp/presentation/ressources/font_manager.dart';
import 'package:movieapp/presentation/ressources/icon_manager.dart';
import 'package:movieapp/presentation/ressources/routes_manager.dart';
import 'package:movieapp/presentation/ressources/styles_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';

class FavoriteGridItem extends StatelessWidget {
  final Favorite favorite;
  final Function onTap;
  final Function unFavorite;
  const FavoriteGridItem(
    this.favorite, {
    required this.onTap, 
    required this.unFavorite,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print(width);
    return InkWell(
      onTap: () {
        onTap.call();
      },
      child: Padding(
        padding: EdgeInsets.only(top: AppPadding.p10),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                Expanded(
                  flex: 10,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width>AppSize.s550?AppSize.s20:AppSize.s10),
                    child: MovieImageItem(
                      image: favorite.image??EMPTY,
                      radius: AppSize.s8,
                      width: double.infinity,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.all(AppPadding.p5),
                    child: Column(
                      children: [
                        Text(favorite.title??EMPTY,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: getSemiBoldStyle(
                                fontSize: FontSize.s12, color: Colors.white)),
                        Text(favorite.year??EMPTY,
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
              left:  width>AppSize.s550?AppSize.s24:AppSize.s15,
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
      ),
    );
  }
}
