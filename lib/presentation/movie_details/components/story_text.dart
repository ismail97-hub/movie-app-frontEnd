import 'package:flutter/material.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:readmore/readmore.dart';

class StoryText extends StatelessWidget {
  final String story;
  const StoryText(this.story,{ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      story,
      style: Theme.of(context).textTheme.bodyText1,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.left,
      trimLines: 5,
      colorClickableText: ColorManager.white,
      trimMode: TrimMode.Line,
      trimCollapsedText: 'Show more',
      trimExpandedText: 'Show less',
      moreStyle: Theme.of(context).textTheme.bodyText1,
    );
  }
}