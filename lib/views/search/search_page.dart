// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_moviedb_api/utils/constants.dart';
import 'package:flutter_moviedb_api/utils/web_demo_view.dart';
import 'package:flutter_moviedb_api/view_models/search_view_model.dart';
import 'package:flutter_moviedb_api/views/component/app_loading.dart';
import 'package:flutter_moviedb_api/views/component/loading_widget.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SearchViewModel searchViewModel = context.watch<SearchViewModel>();
    var textStyleWhite = TextStyle(color: Colors.white);

    return WebDemoView(
      child: WillPopScope(
        onWillPop: () {
          searchViewModel.clearSearchList();
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child: Scaffold(
            backgroundColor: colorBackgroundDark,
            appBar: AppBar(
                backgroundColor: colorBackgroundDark,
                title: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: TextField(
                      controller: searchController,
                      textInputAction: TextInputAction.search,
                      onChanged: (value) {
                        if (searchController.text.isEmpty) {
                          searchViewModel.clearSearchList();
                        }
                      },
                      onSubmitted: (value) {
                        if (searchController.text.isNotEmpty) {
                          searchViewModel.getSearch(searchController.text);
                        }
                      },
                      decoration: InputDecoration(
                          // prefixIcon: Icon(Icons.search),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              if (searchController.text.isNotEmpty) {
                                searchViewModel
                                    .getSearch(searchController.text);
                              }
                            },
                          ),
                          hintText: 'ค้นหา',
                          border: InputBorder.none),
                    ),
                  ),
                )),
            body: Builder(builder: (context) {
              if (searchViewModel.loading) {
                return AppLoading();
              } else if (searchViewModel.error) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      searchViewModel.movieError.massage,
                      style: textStyleWhite,
                    ),
                  ],
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: searchViewModel.searchList.length,
                    itemBuilder: ((context, index) {
                      if (searchViewModel.searchList[index].backdropPath ==
                          'null') {
                        return SizedBox(
                          height: 0,
                          // child: Text('null'),
                        );
                      } else {
                        return Container(
                          padding: EdgeInsets.only(left: 20),
                          height: 100,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buileMovieCard(index, searchViewModel),
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    searchViewModel
                                        .searchList[index].originalTitle,
                                    style: textStyleWhite,
                                  ),
                                  subtitle: SizedBox(
                                    height: 40,
                                    child: Text(
                                      searchViewModel
                                          .searchList[index].overview,
                                      style: TextStyle(color: Colors.grey),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    }),
                    // separatorBuilder: (BuildContext context, int index) {
                    //   return Divider();
                    // },
                  ),
                );
              }
            })),
      ),
    );
  }

  Widget _buileMovieCard(int index, SearchViewModel searchViewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
      child: SizedBox(
        width: 130,
        height: 100,
        child: Stack(children: <Widget>[
          Container(
            width: 130,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: CachedNetworkImage(
              imageUrl: VIEW_MOVIE_IMAGE +
                  searchViewModel.searchList[index].backdropPath,
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
                  //
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
