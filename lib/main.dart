import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_moviedb_api/utils/web_demo_view.dart';
import 'package:flutter_moviedb_api/view_models/detail_view_model.dart';
import 'package:flutter_moviedb_api/view_models/main_view_model.dart';
import 'package:flutter_moviedb_api/view_models/search_view_model.dart';
import 'package:flutter_moviedb_api/views/details/details_page.dart';
import 'package:flutter_moviedb_api/views/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainViewModel()),
        ChangeNotifierProvider(create: (_) => SearchViewModel()),
        ChangeNotifierProvider(create: (_) => DetailViewModel())
      ],
      child: MaterialApp(
          scrollBehavior: AppScrollBehavior(),
          debugShowCheckedModeBanner: false,
          title: 'Flutter TMDB Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: WebDemoView(
            child: HomeScreen(),
          )
          // home: const DetailPage(
          //   id: 414906,
          //   mediatype: 'movie',
          // ),
          ),
    );
  }
}
