import 'package:flutter/material.dart';
import 'package:flutter_moviedb_api/models/movie_model.dart';
import 'package:flutter_moviedb_api/utils/constants.dart';
import 'package:flutter_moviedb_api/view_models/main_view_model.dart';
import 'package:flutter_moviedb_api/views/main/popular_widget.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // MainViewModel mainViewModel = context.watch<MainViewModel>();
    return Container(
        color: Colors.white,
        child: ListView(
          children: [
            Container(
              height: 240,
              color: colorBlueDark,
              child: Text(''),
            ),
            PopularMain(),

            Container(
              height: 200,
              color: colorBlueDark,
              child: Text(''),
            ),
            Container(
              height: 200,
              color: colorBlueDark,
              child: Text(''),
            ),
            // PopularMain(),
            // PopularMain(),
            // PopularMain(),
          ],
        ));
  }
}
