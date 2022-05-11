import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';

class BannerAdWidget extends StatelessWidget {
  final AdWithView ad;
  const BannerAdWidget({ Key? key,required this.ad }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s60,
      width: AppSize.s350,
      child: AdWidget(ad: ad),
    );
  }
}