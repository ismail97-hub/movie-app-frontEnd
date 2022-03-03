import 'package:flutter/material.dart';
import 'package:movieapp/app/functions.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:movieapp/presentation/ressources/language_manager.dart';
import 'package:movieapp/presentation/ressources/strings_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';
import 'package:readmore/readmore.dart';
import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';

class StoryText extends StatelessWidget {
  final String story;
  const StoryText(this.story, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (story.isNotEmpty) {
      return Padding(
        padding:EdgeInsets.only(
            right:isArabic(context)?AppPadding.p0:AppPadding.p10,
            left: isArabic(context)?AppPadding.p10:AppPadding.p0),
        child: ReadMoreText(
          story,
          style: Theme.of(context).textTheme.bodyText1,
          textDirection: ui.TextDirection.rtl,
          textAlign: context.locale==ARABIC_LOCAL?TextAlign.right:TextAlign.left,
          trimLines: 5,
          colorClickableText: ColorManager.white,
          trimMode: TrimMode.Line,
          trimCollapsedText: AppStrings.showMore.tr(),
          trimExpandedText: AppStrings.showLess.tr(),
          moreStyle: Theme.of(context).textTheme.bodyText1,
        ),
      );
    } else {
      return Text(AppStrings.noOverviewFound.tr(),style: Theme.of(context).textTheme.subtitle1,);
    }
  }
}
