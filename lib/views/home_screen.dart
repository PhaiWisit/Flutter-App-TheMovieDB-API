import 'package:flutter/material.dart';
import 'package:flutter_moviedb_api/utils/constants.dart';
import 'package:flutter_moviedb_api/utils/oval_right_clipper.dart';
import 'package:flutter_moviedb_api/views/main/main_page.dart';
import 'package:flutter_moviedb_api/views/search/search_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: colorBackgroundDark,
  );
  static const List<Widget> _widgetOptions = <Widget>[
    MainPage(),
    Text(
      'movie',
      style: optionStyle,
    ),
    Text(
      'series',
      style: optionStyle,
    ),
    Text(
      'favorite',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(),
      appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SearchPage())),
                icon: Icon(Icons.search))
          ],
          backgroundColor: colorBackgroundDark,
          title: const Text(
            'MovieDB API',
            style: TextStyle(color: Colors.white),
          )),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colorBackgroundDark,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'หน้าหลัก ',
              backgroundColor: colorBackgroundDark),
          BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: 'ภาพยนต์ ',
              backgroundColor: colorBackgroundDark),
          BottomNavigationBarItem(
              icon: Icon(Icons.live_tv_outlined),
              label: 'ซีรีส์ ',
              backgroundColor: colorBackgroundDark),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'รายการโปรด ',
              backgroundColor: colorBackgroundDark),
        ],
        unselectedItemColor: Colors.grey,
        // backgroundColor: Colors.black,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }

  _buildDrawer() {
    // final String image = images[0];
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
              color: Colors.grey.shade900,
              boxShadow: [BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 90,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [Colors.pink, Colors.deepPurple])),
                    child: CircleAvatar(
                      child: Icon(
                        Icons.photo_camera,
                        color: Colors.black,
                      ),
                      radius: 40,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(
                          'https://scontent.fbkk9-2.fna.fbcdn.net/v/t39.30808-6/275304229_4720826941362583_9132103829284324688_n.jpg?_nc_cat=109&ccb=1-5&_nc_sid=09cbfe&_nc_eui2=AeHDvwrA-BRpPDzUSWhKhTWx7LXOdSTxxPnstc51JPHE-VhPDvifO2G3ipRGSqosQUdvzfvjaIcWfYXqmiQldP4a&_nc_ohc=n1xAyOFEDcgAX8J96cQ&_nc_ht=scontent.fbkk9-2.fna&oh=00_AT9Jy7TfXRgwo-eyPeFVipkG3XBETZd2YizWtqjqeHcq9g&oe=6268EB0F'),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Wisit Yoosabai",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  Text(
                    "w.phai@hotmail.com",
                    style: TextStyle(color: Colors.blueGrey, fontSize: 16.0),
                  ),
                  SizedBox(height: 30.0),
                  _buildRow(Icons.home, "Home"),
                  _buildDivider(),
                  _buildRow(Icons.person_pin, "Your profile"),
                  _buildDivider(),
                  _buildRow(Icons.settings, "Settings"),
                  _buildDivider(),
                  _buildRow(Icons.info_outline, "About application"),
                  _buildDivider(),
                  _buildRow(Icons.power_settings_new, "Log out"),
                  _buildDivider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: Colors.blueGrey,
    );
  }

  Widget _buildRow(IconData icon, String title) {
    final TextStyle tStyle = TextStyle(color: Colors.blueGrey, fontSize: 16.0);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(children: [
        Icon(
          icon,
          color: Colors.blueGrey,
        ),
        SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
      ]),
    );
  }
}
