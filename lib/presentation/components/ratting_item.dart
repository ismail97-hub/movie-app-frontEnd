import 'package:flutter/material.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:movieapp/presentation/ressources/icon_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';

class RatingItem extends StatelessWidget {
  final double rating;
  final double iconSize;
  final double padding;
  final TextStyle? style;
  const RatingItem(this.rating, {Key? key, double? iconSize, double? padding,this.style}) : 
    iconSize = iconSize ?? AppSize.s16,
    padding = padding ?? AppSize.s8,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          IconManager.star,
          color: ColorManager.yellow,
          size: iconSize,
        ),
        SizedBox(
          width: padding
        ),
        Text(
          rating.toString(),
          style: style?? Theme.of(context).textTheme.bodyText1,
        )
      ],
    );
  }
}
