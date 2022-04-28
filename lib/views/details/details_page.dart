import 'package:flutter/material.dart';
import 'package:flutter_moviedb_api/utils/constants.dart';
import 'package:flutter_moviedb_api/view_models/main_view_model.dart';
import 'package:flutter_moviedb_api/views/details/detail_widget.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.movieType}) : super(key: key);

  final String movieType;

  @override
  Widget build(BuildContext context) {
    MainViewModel mainViewModel = context.watch<MainViewModel>();
    var textWhite = TextStyle(color: Colors.white);
    return Scaffold(
      backgroundColor: colorBackgroundDark,
      appBar: AppBar(
        backgroundColor: colorBackgroundDark,
        title: Text(
          mainViewModel.selectedModel.originalTitle,
          style: textWhite,
        ),
      ),
      body: Container(
          color: Colors.white,
          child: RefreshIndicator(
            onRefresh: () async {
              // mainViewModel.main();
            },
            child: ListView(
              children: [
                Container(
                  height: 220,
                  color: Colors.amber.shade100,
                  child: Text('Video section'),
                ),
                DetailWidget(
                  movieType: movieType,
                ),
                Container(
                  height: 240,
                  color: Colors.amber.shade300,
                  child: Text('What is section?'),
                ),
                // PopularMain(),
                // PopularMain(),
                // PopularMain(),
              ],
            ),
          )),
    );
  }
}
