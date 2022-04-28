import 'package:flutter/material.dart';
import 'package:flutter_moviedb_api/models/movie_popular_model.dart' as Popular;
import 'package:flutter_moviedb_api/models/movie_trailer_model.dart' as Trailer;
import 'package:flutter_moviedb_api/models/movie_trend_model.dart' as Trend;
import 'package:flutter_moviedb_api/utils/constants.dart';
import 'package:flutter_moviedb_api/view_models/main_view_model.dart';
import 'package:flutter_moviedb_api/views/component/loading_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

/** 
 selectedModel Can Use.

  bool adult
  String backdropPath
  int id
  String originalTitle
  String overview
  double popularity
  String posterPath
  DateTime releaseDate
  String title
  bool video
  double voteAverage
  int voteCount

*/

class DetailWidget extends StatefulWidget {
  const DetailWidget({Key? key, required this.movieType}) : super(key: key);

  final String movieType;

  @override
  State<DetailWidget> createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  bool isMoreTapped = false;
  bool isFavoritTapped = false;
  @override
  Widget build(BuildContext context) {
    MainViewModel mainViewModel =
        Provider.of<MainViewModel>(context, listen: false);
    var textWhite = TextStyle(color: Colors.white);

    return Container(
        height: 240,
        color: colorBackgroundDark,
        child: Padding(
          padding: EdgeInsets.only(left: 8, bottom: 18, top: 18, right: 8),
          child: Container(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buileMovieCard(context, mainViewModel),
              SizedBox(
                width: 8,
              ),
              Expanded(child: _buildTextDetail(context, mainViewModel)),
            ],
          )),
        ));
  }

  Widget _buileMovieCard(BuildContext context, MainViewModel mainViewModel) {
    return SizedBox(
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
            imageUrl: VIEW_MOVIE_IMAGE + mainViewModel.selectedModel.posterPath,
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
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildTextDetail(BuildContext context, MainViewModel mainViewModel) {
    var textWhite = TextStyle(color: Colors.white);

    return Container(
      // color: Colors.amber,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                Text(
                  mainViewModel.selectedModel.originalTitle == ''
                      ? mainViewModel.selectedModel.originalName
                      : mainViewModel.selectedModel.originalTitle,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  mainViewModel.selectedModel.releaseDate != null
                      ? DateFormat.yMMMMd('en_US')
                          .format(mainViewModel.selectedModel.releaseDate)
                      : DateFormat.yMMMMd('en_US')
                          .format(mainViewModel.selectedModel.firstAirDate),
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                SizedBox(
                  height: 10,
                ),
                isMoreTapped
                    ? Text(
                        mainViewModel.selectedModel.overview,
                        style: textWhite,
                      )
                    : Text(
                        mainViewModel.selectedModel.overview,
                        style: textWhite,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                isMoreTapped
                    ? SizedBox(
                        height: 10,
                      )
                    : InkWell(
                        onTap: () {
                          setState(() {
                            isMoreTapped = true;
                            print(isMoreTapped);
                          });
                        },
                        child: Text(
                          'more',
                          style: TextStyle(color: Colors.blue.shade800),
                        ),
                      )
              ],
            ),
          ),
          Container(
            height: 50,
            // color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Score : ' +
                      mainViewModel.selectedModel.voteAverage.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),

                InkWell(
                  onTap: () {
                    setState(() {
                      if (isFavoritTapped) {
                        isFavoritTapped = false;
                      } else {
                        isFavoritTapped = true;
                      }
                    });
                  },
                  child: isFavoritTapped
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 40,
                        )
                      : Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 40,
                        ),
                )

                // Text(
                //   'data',
                //   style: textWhite,
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}
