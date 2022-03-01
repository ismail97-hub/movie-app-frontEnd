import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/presentation/movie_details/movie_details_viewmodel.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:movieapp/presentation/ressources/icon_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';

AppBar detailsAppBar(
    {required BuildContext context,
    required MovieDetailsViewModel viewModel,
    required Movie movie}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    automaticallyImplyLeading: false,
    leadingWidth: AppSize.s46,
    leading: Padding(
      padding: EdgeInsets.only(left: AppPadding.p6),
      child: CircleAvatar(
        radius: AppSize.s40,
        backgroundColor: ColorManager.black.withOpacity(0.3),
        child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              IconManager.back,
              color: ColorManager.secondary,
            )),
      ),
    ),
    actions: [
      Padding(
        padding: EdgeInsets.only(right: AppPadding.p8),
        child: StreamBuilder<IconData>(
            stream: viewModel.outputFavoriteIcon,
            builder: (context, snapshot) {
              return SizedBox(
                width: AppSize.s40,
                child: CircleAvatar(
                  radius: AppSize.s40,
                  backgroundColor: ColorManager.black.withOpacity(0.3),
                  child: IconButton(
                      onPressed: () {
                        viewModel.onFavoriteClick(context,movie);
                      },
                      icon: Icon(
                        snapshot.data,
                        color: ColorManager.secondary,
                      )),
                ),
              );
            }),
      )
    ],
  );
}
