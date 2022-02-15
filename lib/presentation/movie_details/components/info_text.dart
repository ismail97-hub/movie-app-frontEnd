import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/data/mapper/mapper.dart';
import 'package:movieapp/presentation/ressources/strings_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';

class InfoText extends StatelessWidget {
  final String info1;
  final String info2;
  final Function()? onTap2;
  const InfoText(
      {Key? key, required this.info1, required this.info2, this.onTap2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle? infoStyle = Theme.of(context).textTheme.bodyText1;
    if (info1 == EMPTY && info2 == EMPTY) {
      return Container();
    } else {
      return Padding(
        padding: EdgeInsets.only(top:AppPadding.p10),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(
              text: info1,
              style: infoStyle,
            ),
            TextSpan(
              text: AppStrings.dot,
              style: infoStyle,
            ),
            TextSpan(
              text: info2,
              style: infoStyle,
              recognizer: TapGestureRecognizer()..onTap = onTap2,
            ),
          ]),
        ),
      );
    }
  }
}
