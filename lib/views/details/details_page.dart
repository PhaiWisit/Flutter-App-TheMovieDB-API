import 'package:flutter/material.dart';
import 'package:flutter_moviedb_api/models/movie_video_model.dart';
import 'package:flutter_moviedb_api/utils/constants.dart';
import 'package:flutter_moviedb_api/utils/web_demo_view.dart';
import 'package:flutter_moviedb_api/view_models/detail_view_model.dart';
import 'package:flutter_moviedb_api/view_models/main_view_model.dart';
import 'package:flutter_moviedb_api/views/component/app_loading.dart';
import 'package:flutter_moviedb_api/views/details/detail_widget.dart';
import 'package:flutter_moviedb_api/views/details/video_widget.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key? key,
    required this.movieType,
  }) : super(key: key);

  final String movieType;
  // final dynamic selectModel;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  // late DetailViewModel detailViewModel;

  @override
  void initState() {
    super.initState();
    // MainViewModel mainViewModel = context.watch<MainViewModel>();

    // WidgetsBinding.instance.addPostFrameCallback((_) {

    //   Provider.of<DetailViewModel>(context, listen: false)
    //       .getMovieVideo(widget.selectModel.id);
    // });
  }

  @override
  Widget build(BuildContext context) {
    MainViewModel mainViewModel = context.watch<MainViewModel>();
    DetailViewModel detailViewModel = context.watch<DetailViewModel>();
    List<String> video_key = [];
    if (!detailViewModel.loading) {
      if (detailViewModel.movieVideoModel.results.length > 2) {
        video_key.add(detailViewModel.movieVideoModel.results[0].key);
        video_key.add(detailViewModel.movieVideoModel.results[1].key);
        video_key.add(detailViewModel.movieVideoModel.results[2].key);
      } else if (detailViewModel.movieVideoModel.results.length == 1) {
        video_key.add(detailViewModel.movieVideoModel.results[0].key);
      } else {
        video_key = [];
      }
    }
    // detailViewModel.getMovieVideo(mainViewModel.selectedModel.id);

    // detailViewModel.setMovieId(634649);

    // detailViewModel.getMovieVideo(634649);
    // DetailViewModel detailViewModel =
    //     Provider.of<DetailViewModel>(context, listen: false)
    //         .getMovieVideo(634649);

    var textWhite = TextStyle(color: Colors.white);

    return WebDemoView(
      child: WillPopScope(
        onWillPop: () {
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child: Scaffold(
          backgroundColor: colorBackgroundDark,
          appBar: AppBar(
            backgroundColor: colorBackgroundDark,
            title: Text(
              mainViewModel.selectedModel.originalTitle,
              style: textWhite,
            ),
          ),
          body: Container(
              child: ListView(
            children: [
              detailViewModel.loading
                  ? Container(
                      height: 220,
                      child: AppLoading(),
                    )
                  : VideoWidget(
                      video_key: video_key,
                    ),
              DetailWidget(
                movieType: widget.movieType,
              ),
              Container(
                height: 240,
                // color: Colors.amber.shade300,
                child: Text(''),
              ),
              // PopularMain(),
              // PopularMain(),
              // PopularMain(),
            ],
          )),
        ),
      ),
    );
  }
}
