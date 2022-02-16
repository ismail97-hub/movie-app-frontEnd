import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/presentation/components/ratting_item.dart';
import 'package:movieapp/presentation/ressources/routes_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';

class GridItem extends StatelessWidget {
  final Movie movie;
  const GridItem(this.movie, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.movieDetailsRoute,
            arguments: movie.id);
      },
      child: Container(
        margin: EdgeInsets.all(AppMargin.m0_5),
        child: Stack(
          children: [
            Positioned(
              bottom: AppSize.s0,
              left: AppSize.s0,
              right: AppSize.s0,
              top: AppSize.s0,
              child: CachedNetworkImage(
                imageUrl:movie.image,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              bottom: AppSize.s0,
              left: AppSize.s0,
              right: AppSize.s0,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.p3, vertical: AppSize.s3),
                decoration: BoxDecoration(
                    // ignore: prefer_const_literals_to_create_immutables
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset.zero,
                        blurRadius: AppSize.s8,
                        spreadRadius: AppSize.s0,
                      )
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RatingItem(
                      movie.rating,
                      padding: AppSize.s2,
                      iconSize: AppSize.s10,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Text(movie.year,
                        style: Theme.of(context).textTheme.bodyText2),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
