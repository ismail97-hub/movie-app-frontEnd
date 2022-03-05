import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieapp/app/constant.dart';
import 'package:movieapp/app/functions.dart';
import 'package:movieapp/presentation/ressources/assets_manager.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:movieapp/presentation/ressources/icon_manager.dart';
import 'package:movieapp/presentation/ressources/strings_manager.dart';
import 'package:movieapp/presentation/ressources/styles_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';

class AppDrawerHeader extends StatelessWidget {
  const AppDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      margin: EdgeInsets.all(0.0),
      padding: EdgeInsets.all(0.0),
      decoration: BoxDecoration(color: ColorManager.black),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Image(
                image: AssetImage(ImageAssets.splashLogo),
              )),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: AppPadding.p15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Constant.appName,
                      style: getBoldStyle(
                          color: ColorManager.secondary, fontSize: 20)),
                  Text("Version ${Constant.version}",
                      style: getLightStyle(
                          color: ColorManager.white.withOpacity(0.8),
                          fontSize: 10)),
                  _getWebsiteWidget(context),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    _getSocialMediaWidget(context, IconManager.facebook, () {
                      customLaunch(Constant.facebookUrl);
                    }),
                    SizedBox(width: AppSize.s15),
                    _getSocialMediaWidget(context, IconManager.twitter, () {
                      customLaunch(Constant.twitterUrl);
                    }),
                    SizedBox(width: AppSize.s15),
                    _getSocialMediaWidget(context, IconManager.instagram, () {
                      customLaunch(Constant.instagramUrl);
                    }),
                  ])
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getWebsiteWidget(BuildContext context) {
    return InkWell(
      onTap: () {
        customLaunch(Constant.site);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: AppPadding.p3),
            child: Icon(IconManager.link,
                size: AppSize.s12, color: ColorManager.white),
          ),
          SizedBox(width: AppSize.s3),
          Text(
            "www.movcima.com",
            style: Theme.of(context).textTheme.headline6,
          )
        ],
      ),
    );
  }

  Widget _getSocialMediaWidget(
      BuildContext context, IconData icon, Function onTap) {
    return CircleAvatar(
      radius: AppSize.s15,
      backgroundColor: ColorManager.white,
      child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            onTap.call();
          },
          icon: Icon(
            icon,
            color: ColorManager.primary,
            size: AppSize.s22,
          )),
    );
  }
}
