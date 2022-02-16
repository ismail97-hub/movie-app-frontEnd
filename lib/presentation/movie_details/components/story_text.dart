import 'package:flutter/material.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:movieapp/presentation/ressources/strings_manager.dart';
import 'package:readmore/readmore.dart';

class StoryText extends StatelessWidget {
  final String story;
  const StoryText(this.story, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (story.isNotEmpty) {
      return ReadMoreText(
        story,
        style: Theme.of(context).textTheme.bodyText1,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.left,
        trimLines: 5,
        colorClickableText: ColorManager.white,
        trimMode: TrimMode.Line,
        trimCollapsedText: AppStrings.showMore,
        trimExpandedText: AppStrings.showLess,
        moreStyle: Theme.of(context).textTheme.bodyText1,
      );
    } else {
      return Text(AppStrings.noOverviewFound,style: Theme.of(context).textTheme.subtitle1,);
    }
  }
}
