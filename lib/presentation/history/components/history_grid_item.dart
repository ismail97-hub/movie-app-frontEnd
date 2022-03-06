import 'package:flutter/material.dart';
import 'package:movieapp/data/local/model.dart';
import 'package:movieapp/data/mapper/mapper.dart';
import 'package:movieapp/presentation/components/movie_image_item.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:movieapp/presentation/ressources/font_manager.dart';
import 'package:movieapp/presentation/ressources/styles_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';

class HistoryGridItem extends StatelessWidget {
  final History history;
  final Function onTap;
  const HistoryGridItem(this.history, {Key? key, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        onTap.call();
      },
      child: Padding(
        padding: EdgeInsets.only(top:AppPadding.p10),
        child: Column(
          children: [
            Expanded(
                flex: 10,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width > AppSize.s550 ? AppSize.s20 : AppSize.s10),
                  child: MovieImageItem(
                    image: history.image ?? EMPTY,
                    radius: AppSize.s8,
                    width: double.infinity,
                  ),
                )),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(AppPadding.p5),
                child: Column(
                  children: [
                    Text(history.title ?? EMPTY,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: getSemiBoldStyle(
                            fontSize: FontSize.s12, color: Colors.white)),
                    Text(history.year ?? EMPTY,
                        style: getBoldStyle(
                            fontSize: FontSize.s12,
                            color: ColorManager.secondary)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
