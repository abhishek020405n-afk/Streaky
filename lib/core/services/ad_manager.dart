import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  static const String bannerAdUnitId = 'ca-app-pub-3940256099942544/6300978111';

  static BannerAd? bannerAd;

  static Future<void> initialize() async {
    final initialization = await MobileAds.instance.initialize();
    if (initialization.adapterStatuses.isNotEmpty) {
      loadBannerAd();
    }
  }

  static void loadBannerAd() {
    bannerAd = BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {},
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          bannerAd = null;
        },
      ),
    );
    bannerAd?.load();
  }

  static Widget bannerAdWidget() {
    if (bannerAd == null) {
      loadBannerAd();
      return const SizedBox(height: 50);
    }
    return SizedBox(
      width: bannerAd!.size.width.toDouble(),
      height: bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: bannerAd!),
    );
  }
}
