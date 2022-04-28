import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WebDemoView extends StatelessWidget {
  const WebDemoView({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: child,
      tablet: _screenIsWeb(child),
      desktop: _screenIsWeb(child),
    );
  }

  Widget _screenIsWeb(Widget child) {
    return ListView(
      children: [
        SizedBox(
          height: 50,
        ),
        Center(
          child: Text(
            'TheMovieDB API App Demo',
            style:
                TextStyle(decoration: TextDecoration.none, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Center(
          child: Container(
            height: 800,
            width: 400,
            foregroundDecoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/phone.png'),
                    fit: BoxFit.fill)),
            decoration: BoxDecoration(
                color: Color(0xFF101010),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 40, bottom: 30, left: 24, right: 24),
              child: child,
            ),
          ),
        ),
        SizedBox(
          height: 100,
        ),
      ],
    );
  }
}
