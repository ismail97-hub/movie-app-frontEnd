import 'package:flutter/material.dart';
import 'package:movieapp/app/constant.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:movieapp/presentation/ressources/font_manager.dart';
import 'package:movieapp/presentation/ressources/routes_manager.dart';
import 'package:movieapp/presentation/ressources/styles_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';

class TagItem extends StatelessWidget {
  final Genre genre;
  final double width;
  final double height;
  final double radius;
  final EdgeInsets padding;
  const TagItem(this.genre,{Key? key,double? width,double? height,double? radius,EdgeInsets? padding}) : 
    height = height ?? AppSize.s30,
    width = width ?? AppSize.s80,
    radius = radius ?? AppSize.s10,
    padding = padding ?? const EdgeInsets.only(right: AppPadding.p8),
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, Routes.movieListRoute,arguments: MovieListArgs("${Endpoints.genre}/${genre.id}",genre.label));
      },
      child: Padding(
        padding: padding,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: ColorManager.secondary,width: AppSize.s0_5)
          ),
          width: width,
          height: height,
          // color: ColorManager.white.withOpacity(0.1),
          child: Center(
            child: Text(
              genre.label,
              style: getRegularStyle(fontSize: FontSize.s12, color: ColorManager.white.withOpacity(0.8)),
            ),
          ),
        ),
      ),
    );
  }
}
