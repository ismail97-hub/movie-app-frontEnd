import 'package:flutter/material.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:movieapp/presentation/ressources/icon_manager.dart';
import 'package:movieapp/presentation/ressources/routes_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';

class WatchButton extends StatelessWidget {
  final EdgeInsets? margin;
  final Function onPressed;
  const WatchButton({Key? key,this.margin,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ElevatedButton(
        onPressed: (){onPressed.call();},
        child: Icon(
          IconManager.play,
          color: ColorManager.white,
          size: AppSize.s40,
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(AppPadding.p10),
          primary: ColorManager.secondary,
          onPrimary: ColorManager.black,
        ),
      ),
    );
  }
}
