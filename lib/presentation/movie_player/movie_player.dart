import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movieapp/app/di.dart';
import 'package:movieapp/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:movieapp/presentation/movie_player/movie_player_viewmodel.dart';
import 'package:movieapp/presentation/ressources/assets_manager.dart';
import 'package:movieapp/presentation/ressources/color_manager.dart';
import 'package:movieapp/presentation/ressources/values_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MoviePlayer extends StatefulWidget {
  final String url;
  const MoviePlayer({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  _MoviePlayerState createState() => _MoviePlayerState();
}

class _MoviePlayerState extends State<MoviePlayer> {
  MoviePlayerViewModel _viewModel = instance<MoviePlayerViewModel>();

  @override
  void initState() {
    _viewModel.start();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return _viewModel.onWillPop();
      },
      child: StreamBuilder<bool>(
          stream: _viewModel.outputIsPageFinished,
          builder: (context, snapshot) {
            bool isPageFinished = snapshot.data ?? false;
            return Scaffold(
                    backgroundColor: ColorManager.black,
                    body: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Stack(
                        children: [
                          WebView(
                            backgroundColor: ColorManager.primary,
                            initialUrl: widget.url,
                            // allowsInlineMediaPlayback: true,
                            javascriptMode: JavascriptMode.unrestricted,
                            navigationDelegate: (NavigationRequest request) {
                              return NavigationDecision.prevent;
                            },
                            onPageFinished: (finish) {
                              print(finish);
                              _viewModel.inputIsPageFinished.add(true);
                            },
                            gestureNavigationEnabled: true,
                            zoomEnabled: false,
                          ),
                          isPageFinished==false?_getAnimatedImage():Stack(),
                        ],
                      ),
                    ),
                  );
          }),
    );
  }

  Widget _getAnimatedImage() {
    return Center(
      child: SizedBox(
        height: AppSize.s180,
        width: AppSize.s250,
        child: Lottie.asset(JsonAssets.loading),
      ),
    );
  }
}
