import 'package:flutter/material.dart';
import 'package:movieapp/app/di.dart';
import 'package:movieapp/domain/model/model.dart';
import 'package:movieapp/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:movieapp/presentation/favorites/components/favorite_grid_item.dart';
import 'package:movieapp/presentation/history/components/history_grid_item.dart';
import 'package:movieapp/presentation/history/history_viewmodel.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:movieapp/presentation/ressources/icon_manager.dart';
import 'package:movieapp/presentation/ressources/strings_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  HistoryViewModel _viewModel = instance<HistoryViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: AppBar(
        title: Text(AppStrings.history),
        elevation: AppSize.s4,
        actions: [IconButton(onPressed: () {}, icon: Icon(IconManager.info))],
      ),
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data
                    ?.getScreenWidget(context, _getContentScreen(), () {}) ??
                Container();
          }),
    );
  }

  Widget _getContentScreen() {
    return StreamBuilder<List<Movie>>(
        stream: _viewModel.outputHistory,
        builder: (context, snapshot) {
          return getListHistory(snapshot.data);
        });
  }

  Widget getListHistory(List<Movie>? histories) {
    if (histories != null) {
      return Padding(
        padding: EdgeInsets.only(
          right: AppPadding.p10,
          left: AppPadding.p10,
        ),
        child: GridView.count(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 4 / 7,
          children:
              histories.map((history) => HistoryGridItem(history)).toList(),
        ),
      );
    } else {
      return Container();
    }
  }
}