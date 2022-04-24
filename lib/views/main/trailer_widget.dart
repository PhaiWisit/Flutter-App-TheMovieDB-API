import 'package:flutter/material.dart';
import 'package:flutter_moviedb_api/utils/constants.dart';
import 'package:flutter_moviedb_api/view_models/main_view_model.dart';
import 'package:flutter_moviedb_api/views/component/app_loading.dart';
import 'package:flutter_moviedb_api/views/component/loading_widget.dart';
import 'package:flutter_moviedb_api/views/component/swiper_pagination.dart';
import 'package:provider/provider.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TrailerMain extends StatefulWidget {
  const TrailerMain({Key? key}) : super(key: key);

  @override
  State<TrailerMain> createState() => _TrailerMainState();
}

class _TrailerMainState extends State<TrailerMain> {
  final SwiperController _swiperController = SwiperController();
  final int _pageCount = 8;
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    MainViewModel mainViewModel = context.watch<MainViewModel>();
    TextStyle textStyleWhite = TextStyle(color: Colors.white);
    if (mainViewModel.loading) {
      return Container(
          color: colorBackgroundDark, height: 240, child: AppLoading());
    } else if (mainViewModel.error) {
      return Text(
        mainViewModel.movieError.massage,
        style: textStyleWhite,
      );
    } else {
      return Container(
        height: 240,
        color: colorBackgroundDark,
        child: Swiper(
          autoplay: true,
          autoplayDelay: 5000,
          autoplayDisableOnInteraction: true,
          duration: 1500,
          curve: Curves.decelerate,
          loop: true,
          index: _currentIndex,
          controller: _swiperController,
          itemCount: _pageCount,
          onIndexChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.all(8),
                child: _buildSlideShow(index, mainViewModel));
          },
          pagination: SwiperPagination(
            builder: CustomPaginationBuilder(
                activeSize: Size(10.0, 12.0),
                size: Size(10.0, 10.0),
                color: Colors.grey.shade600,
                activeColor: Colors.white),
          ),
        ),
      );
    }
  }

  Widget _buildSlideShow(int index, MainViewModel mainViewModel) {
    return Stack(children: <Widget>[
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: CachedNetworkImage(
          imageUrl:
              VIEW_MOVIE_IMAGE + mainViewModel.trailerList[index].backdropPath,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
          placeholder: (context, url) => LoadingWidget(
            isImage: true,
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
      Align(
        alignment: Alignment.topRight,
        child: Container(
          height: 30,
          width: 120,
          decoration: BoxDecoration(
            color: Color.fromARGB(129, 0, 0, 0),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          child: Center(
              child: Text(
            'Latest Trailers',
            style: TextStyle(color: Colors.red.shade800),
          )),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          color: Color.fromARGB(129, 0, 0, 0),
          child: ListTile(
            title: Text(
              mainViewModel.trailerList[index].originalTitle,
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              mainViewModel.trailerList[index].overview,
              style: TextStyle(color: Colors.grey),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
      Positioned.fill(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              //
            },
          ),
        ),
      ),
    ]);
  }
}
