import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:missing_application/blocs/auth/auth_bloc.dart';
import 'package:missing_application/screens/landing/wigets/bookmark/bookmark_screen.dart';
import 'package:missing_application/screens/landing/wigets/home/home_screen.dart';
import 'package:missing_application/screens/landing/wigets/map/map_screen.dart';
import 'package:missing_application/screens/landing/wigets/profile/profile_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  static const List<Widget> _pages = [
    HomeScreen(),
    MapScreen(),
    BookmarkScreen(),
    ProfileScreen(),
  ];

  static const List<String> _title = [
    'Missing',
    'Map',
    'BookMark',
    'Profile',
  ];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _loginAuto();
    });
  }

  _loginAuto() async {
    BlocProvider.of<AuthBloc>(context).add(LoginAuto());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: _selectedIndex == 1 ? Size.zero : Size.fromHeight(40.0),
        child: AppBar(
          title: Text(_title[_selectedIndex]),
          centerTitle: false,
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.blueGrey,
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            activeIcon: Icon(Icons.map),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            activeIcon: Icon(Icons.bookmark),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            activeIcon: Icon(Icons.account_circle),
            label: '',
          ),
        ],
      ),
    );
  }
}
