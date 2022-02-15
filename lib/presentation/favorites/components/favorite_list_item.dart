import 'package:flutter/material.dart';
import 'package:movieapp/data/local/model.dart';
import 'package:movieapp/data/mapper/mapper.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/presentation/components/movie_image_item.dart';
import 'package:movieapp/presentation/components/ratting_item.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:movieapp/presentation/ressources/routes_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';

class FavoriteItem extends StatelessWidget {
  final Movie movie;
  final Function(DismissDirection)? onDissmissed;
  const FavoriteItem(this.movie, {Key? key, this.onDissmissed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: onDissmissed,
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, Routes.movieDetailsRoute,arguments: movie.id);
        },
        child: Container(
          height: AppSize.s160,
          margin: EdgeInsets.only(bottom: AppMargin.m15),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: AppMargin.m20),
                height: AppSize.s140,
                decoration: BoxDecoration(
                    color: ColorManager.red.withOpacity(0.57),
                    borderRadius: BorderRadius.circular(AppSize.s8)),
              ),
              Row(
                children: [
                  Expanded(flex: 2,
                    child: Container(
                        margin: EdgeInsets.only(left: AppMargin.m12,bottom: AppMargin.m10),
                        child: MovieImageItem(
                          radius: AppSize.s8,
                          image: movie.image,
                        )),
                  ),
                  Expanded(flex: 3,
                    child: Container(
                      margin: EdgeInsets.only(top: AppMargin.m20),
                      padding: EdgeInsets.symmetric(vertical: AppPadding.p15,horizontal: AppPadding.p12),
                      height: AppSize.s140,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Text(movie.title,style: Theme.of(context).textTheme.headline5),
                           RatingItem(movie.rating),
                           Text(movie.quality,style: Theme.of(context).textTheme.subtitle1,),
                           Text(movie.year,style: Theme.of(context).textTheme.subtitle1,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
