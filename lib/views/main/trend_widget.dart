import 'package:flutter/material.dart';
import 'package:flutter_moviedb_api/utils/constants.dart';
import 'package:flutter_moviedb_api/view_models/detail_view_model.dart';
import 'package:flutter_moviedb_api/view_models/main_view_model.dart';
import 'package:flutter_moviedb_api/views/component/app_loading.dart';
import 'package:flutter_moviedb_api/views/component/loading_widget.dart';
import 'package:flutter_moviedb_api/views/details/details_page.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../models/movie_trend_model.dart';

class TrendMain extends StatelessWidget {
  const TrendMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainViewModel mainViewModel = context.watch<MainViewModel>();
    DetailViewModel detailViewModel = context.watch<DetailViewModel>();
    TextStyle textStyleWhite = TextStyle(color: Colors.white);
    return Container(
      height: 240,
      // color: colorBackgroundDark,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'มาแรงในสัปดาห์นี้',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          Builder(
            builder: (context) {
              if (mainViewModel.loading) {
                return AppLoading();
              } else if (mainViewModel.error) {
                return Text(
                  mainViewModel.movieError.massage,
                  style: textStyleWhite,
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: mainViewModel.trendList.length,
                      itemBuilder: ((context, index) {
                        return _buileMovieCard(
                            context, index, mainViewModel, detailViewModel);
                      })),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buileMovieCard(BuildContext context, int index,
      MainViewModel mainViewModel, DetailViewModel detailViewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
      child: SizedBox(
        width: 130,
        child: Stack(children: <Widget>[
          Container(
            width: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: CachedNetworkImage(
              imageUrl:
                  VIEW_MOVIE_IMAGE + mainViewModel.trendList[index].posterPath,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  // shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => LoadingWidget(
                isImage: true,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  mainViewModel.setSelectedModel(
                      trendModel: mainViewModel.trendList[index]);
                  Result select = mainViewModel.selectedModel;
                  detailViewModel.getMovieVideo(
                      select.id, select.mediaType.toString());
                  print(select.mediaType.toString());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPage(
                              movieType: 'trend',
                            )),
                  );
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
