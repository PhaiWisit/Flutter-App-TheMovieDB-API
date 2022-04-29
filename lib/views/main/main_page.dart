import 'package:flutter/material.dart';
import 'package:flutter_moviedb_api/utils/constants.dart';
import 'package:flutter_moviedb_api/view_models/main_view_model.dart';
import 'package:flutter_moviedb_api/views/main/popular_widget.dart';
import 'package:flutter_moviedb_api/views/main/trailer_widget.dart';
import 'package:flutter_moviedb_api/views/main/trend_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainViewModel mainViewModel = context.watch<MainViewModel>();
    ScrollController controller = ScrollController();

    if (mainViewModel.error) {
      return Container(
          color: Colors.white,
          child: ListView(children: [Text(mainViewModel.movieError.massage)]));
    } else {
      return Container(
          color: colorBackgroundDark,
          child: RefreshIndicator(
            onRefresh: () async {
              mainViewModel.main();
            },
            child: WebSmoothScroll(
              controller: controller,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TrailerMain(),
                    PopularMain(),
                    TrendMain(),
                    // Container(
                    //   height: 240,
                    //   color: colorBackgroundDark,
                    //   child: Text(''),
                    // ),
                    // Container(
                    //   height: 240,
                    //   color: colorBackgroundDark,
                    //   child: Text(''),
                    // ),
                    // PopularMain(),
                    // PopularMain(),
                    // PopularMain(),
                  ],
                ),
              ),
            ),
          ));
    }
  }
}
