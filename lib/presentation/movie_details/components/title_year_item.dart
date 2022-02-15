import 'package:flutter/material.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';

class TitleYearItem extends StatelessWidget {
  final String title;
  final String year;
  final double radius;
  final double width;
  final double height;
  const TitleYearItem({Key? key,
      required this.title,
      required this.year,
      Color? color,
      double? radius,
      double? width,
      double? height
      }) : 
      radius = radius ?? AppSize.s15,
      width = width ?? AppSize.s50,
      height= height ?? AppSize.s20,
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: title + " ",
          style: Theme.of(context).textTheme.headline1,
        ),
        WidgetSpan(
            child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Container(
            width: width,
            height: height,
            color: ColorManager.secondary,
            child: Center(
              child: Text(
                year,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
          ),
        ))
      ]),
    );
  }
}
