import 'package:flutter/material.dart';
import 'package:flutter_moviedb_api/utils/constants.dart';
import 'package:flutter_moviedb_api/view_models/main_view_model.dart';
import 'package:flutter_moviedb_api/views/main/popular_widget.dart';
import 'package:flutter_moviedb_api/views/main/trailer_widget.dart';
import 'package:flutter_moviedb_api/views/main/trend_widget.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainViewModel mainViewModel = context.watch<MainViewModel>();

    // List<Image> image_popular ;
    // int popularLength = mainViewModel.popularList.length;

    // if (!mainViewModel.loading) {
    //   for (int i = 0; i < popularLength; i++) {
    //     image_popular.add(Image.network(
    //         VIEW_MOVIE_IMAGE + mainViewModel.popularList[i].posterPath));
    //   }
    // }

    if (mainViewModel.error) {
      return Container(
          color: Colors.white,
          child: ListView(children: [Text(mainViewModel.movieError.massage)]));
    } else {
      return Container(
          color: Colors.white,
          child: RefreshIndicator(
            onRefresh: () async {
              mainViewModel.main();
            },
            child: ListView(
              children: [
                TrailerMain(),

                PopularMain(),
                TrendMain(),
                Container(
                  height: 240,
                  color: colorBackgroundDark,
                  child: Text(''),
                ),
                Container(
                  height: 240,
                  color: colorBackgroundDark,
                  child: Text(''),
                ),
                // PopularMain(),
                // PopularMain(),
                // PopularMain(),
              ],
            ),
          ));
    }
  }
}
