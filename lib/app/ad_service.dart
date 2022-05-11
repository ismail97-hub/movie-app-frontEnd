import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:movieapp/app/constant.dart';

abstract class AdService {
  BannerAd? get getBannerAd;
  createBannerAd();
  createInnterstitialAd();
  showInnterstitialAd();
}

class AdServicImpl extends AdService {
  BannerAd? bannerAd;
  InterstitialAd? interstitialAd;
  AdRequest _adRequest = AdRequest(nonPersonalizedAds: false);

  @override
  BannerAd? get getBannerAd => bannerAd;

  @override
  createBannerAd() {
    var bannerListner = BannerAdListener(onAdClosed: (ad) {
      bannerAd?.load();
    }, onAdFailedToLoad: (ad, error) {
      bannerAd?.load();
    });

    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: Constant.bannerAdUnitId,
        listener: bannerListner,
        request: _adRequest);

    bannerAd?.load();
  }

  @override
  createInnterstitialAd() {
    var interstitialAdLoadCallback = InterstitialAdLoadCallback(
      onAdLoaded: (InterstitialAd ad) {
        interstitialAd = ad;
        interstitialAd!.setImmersiveMode(true);
      },
      onAdFailedToLoad: (LoadAdError error) {
        print('InterstitialAd failed to load: $error');
      },
    );

    InterstitialAd.load(
        adUnitId: Constant.interstitialAdUnitId,
        request: _adRequest,
        adLoadCallback: interstitialAdLoadCallback);
  }

  @override
  showInnterstitialAd() {
    interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        createInnterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
        createInnterstitialAd();
      },
    );
    interstitialAd?.show();
  }


}
