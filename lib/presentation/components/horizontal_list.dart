import 'package:flutter/material.dart';
import 'package:movieapp/presentation/components/horizontal_list_item.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';

class HorizontalList extends StatelessWidget {
  final List list;
  final double aroundSpace;
  const HorizontalList(this.list,{Key? key,double? aroundSpace}) : 
    aroundSpace = aroundSpace ?? AppSize.s2,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s250,
      child: ListView.separated(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: list.length + 2,
        itemBuilder: (contet, index) {
          if (index == 0 || index == list.length + 1) {
            return  SizedBox(width: aroundSpace,);
          }
          return HorizontalListmovie(list[index - 1]);
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: AppSize.s10);
        },
      ),
    );
  }
}
