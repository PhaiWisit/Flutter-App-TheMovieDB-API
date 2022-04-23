import 'package:flutter/material.dart';
import 'package:flutter_moviedb_api/utils/constants.dart';
import 'package:flutter_moviedb_api/view_models/main_view_model.dart';
import 'package:flutter_moviedb_api/views/component/app_loading.dart';
import 'package:flutter_moviedb_api/views/component/loading_widget.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PopularMain extends StatelessWidget {
  const PopularMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainViewModel mainViewModel = context.watch<MainViewModel>();
    TextStyle textStyleWhite = TextStyle(color: Colors.white);

    return Container(
      height: 240,
      color: colorBlueDark,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular',
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
                      itemCount: mainViewModel.popularList.length,
                      itemBuilder: ((context, index) {
                        return _buileMovieCard(index, mainViewModel);
                        // Text(mainViewModel
                        // .popularList[index].originalTitle),
                      })),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buileMovieCard(int index, MainViewModel mainViewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
      child: Container(
        width: 130,
        // height: 100,
        decoration: BoxDecoration(
          // color: Colors.amber,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: CachedNetworkImage(
          imageUrl:
              VIEW_MOVIE_IMAGE + mainViewModel.popularList[index].posterPath,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              // shape: BoxShape.circle,
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
          placeholder: (context, url) => LoadingWidget(
            isImage: true,
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),

        // image: NetworkImage('https://image.tmdb.org/t/p/w500/' +
        //     mainViewModel.popularList[index].posterPath),
        // fit: BoxFit.fill),

        // child: Text(mainViewModel.popularList[index].originalTitle),
      ),
    );
  }
}
