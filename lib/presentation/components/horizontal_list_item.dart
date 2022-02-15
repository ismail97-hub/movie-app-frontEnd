import 'package:flutter/material.dart';
import 'package:movieapp/app/functions.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/presentation/components/movie_image_item.dart';
import 'package:movieapp/presentation/ressources/routes_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';

class HorizontalListmovie extends StatelessWidget {
  final Movie movie;
  final double width;
  final EdgeInsets padding;
  const HorizontalListmovie(this.movie,{Key? key,double? width, EdgeInsets? padding}) : 
      width = width ?? AppSize.s150,
      padding = padding ?? const EdgeInsets.only(right: AppPadding.p10),
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, Routes.movieDetailsRoute,arguments: movie.id);
      },
      child: Container(
        padding: padding,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 7,
              child: MovieImageItem(image: movie.image),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      movie.quality,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      movie.year,
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                width: width,
                child: Text(movie.title,
                    maxLines: 2,textDirection: isRTL(movie.title) ? TextDirection.rtl : TextDirection.ltr,style: Theme.of(context).textTheme.headline5),
              ),
            )
          ],
        ),
      ),
    );
  }
}
