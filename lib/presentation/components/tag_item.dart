import 'package:flutter/material.dart';
import 'package:movieapp/app/constant.dart';
import 'package:movieapp/app/functions.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:movieapp/presentation/ressources/font_manager.dart';
import 'package:movieapp/presentation/ressources/language_manager.dart';
import 'package:movieapp/presentation/ressources/routes_manager.dart';
import 'package:movieapp/presentation/ressources/styles_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class TagItem extends StatelessWidget {
  final Genre genre;
  final double width;
  final double height;
  final double radius;
  final double padding;
  const TagItem(this.genre,{Key? key,double? width,double? height,double? radius,double? padding}) : 
    height = height ?? AppSize.s30,
    width = width ?? AppSize.s80,
    radius = radius ?? AppSize.s10,
    padding = padding ?? AppPadding.p8,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    String genreLabel = context.locale==ARABIC_LOCAL?genre.label:genre.labelEn;
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, Routes.movieListRoute,arguments: MovieListArgs("${Endpoints.genre}/${genre.id}",genreLabel));
      },
      child: Padding(
        padding: EdgeInsets.only(
          right:isArabic(context)?AppPadding.p0:padding,
          left: isArabic(context)?padding:AppPadding.p0),
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
              genreLabel,
              style: getRegularStyle(fontSize: FontSize.s12, color: ColorManager.white.withOpacity(0.8)),
            ),
          ),
        ),
      ),
    );
  }
}
