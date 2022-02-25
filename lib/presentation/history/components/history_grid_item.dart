import 'package:flutter/material.dart';
import 'package:movieapp/data/local/model.dart';
import 'package:movieapp/data/mapper/mapper.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/presentation/components/movie_image_item.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:movieapp/presentation/ressources/font_manager.dart';
import 'package:movieapp/presentation/ressources/routes_manager.dart';
import 'package:movieapp/presentation/ressources/styles_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';

class HistoryGridItem extends StatelessWidget {
  final History history;
  const HistoryGridItem(this.history,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, Routes.movieDetailsRoute,arguments: history.movieId);
      },
      child: Column(
        children: [
          Expanded(
              flex: 10,
              child: MovieImageItem(
                image: history.image??EMPTY,
                radius: AppSize.s8,
              )),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.all(AppPadding.p5),
              child: Column(
                children: [
                  Text(history.title??EMPTY,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: getSemiBoldStyle(
                          fontSize: FontSize.s12, color: Colors.white)),
                  Text(history.year??EMPTY,
                      style: getBoldStyle(
                          fontSize: FontSize.s12, color: ColorManager.secondary)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
