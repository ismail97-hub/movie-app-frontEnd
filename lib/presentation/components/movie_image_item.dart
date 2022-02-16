import 'package:flutter/material.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieImageItem extends StatelessWidget {
  final String image;
  final double radius;
  final double width; 
  const MovieImageItem({Key? key,required this.image,double? radius,double? width}) : 
      radius = radius ?? AppSize.s4,
      width = width ?? AppSize.s160,
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl:image,
        fit: BoxFit.fill,
        width: width,
      ),
    );
  }
}
