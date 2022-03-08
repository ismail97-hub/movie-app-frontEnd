import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/app/constant.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/presentation/ressources/routes_manager.dart';

abstract class DynamicLinksService {
  Future<void> initDynamicLinks(BuildContext context);
  Future<void> dynamicLinksListner(BuildContext context);
  Future<Uri> getMovieDynamicLink(Movie movie);
}

class DynamicLinksServiceImpl extends DynamicLinksService {
  FirebaseDynamicLinks _dynamicLinks;
  DynamicLinksServiceImpl(this._dynamicLinks);

  @override
  Future<Uri> getMovieDynamicLink(Movie movie) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: Constant.dynamicLinkUrl,
        link: Uri.parse("${Constant.dynamicLinkUrl}/${movie.id}"),
        androidParameters: const AndroidParameters(
          packageName: Constant.androidId,
          minimumVersion: 1,
        ),
        socialMetaTagParameters: SocialMetaTagParameters(
            title: movie.title,
            description: movie.story,
            imageUrl: Uri.parse(movie.image)));

    final ShortDynamicLink shortDynamicLink = await _dynamicLinks.buildShortLink(parameters);
    final Uri uri = shortDynamicLink.shortUrl;
    return uri;
  }

  @override
  Future<void> initDynamicLinks(BuildContext context) async {
    // Get any initial links
    final PendingDynamicLinkData? initialLink = await _dynamicLinks.getInitialLink();
    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      print("link path: "+deepLink.path);
      int id = int.parse(deepLink.path.substring(1));
      Navigator.pushNamed(context, Routes.movieDetailsRoute,arguments: id);
    }
  }

  @override
  Future<void> dynamicLinksListner(BuildContext context) async{
    _dynamicLinks.onLink.listen((dynamicLinkData) {
      print("link path: "+dynamicLinkData.link.path);
      int id = int.parse(dynamicLinkData.link.path.substring(1));
      Navigator.pushNamed(context, Routes.movieDetailsRoute,arguments: id);
    }).onError((error) {
      // Handle errors
    });
  }
}
