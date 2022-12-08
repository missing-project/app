import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:missing_application/blocs/appinfo/appinfo_bloc.dart';
import 'package:missing_application/blocs/auth/auth_bloc.dart';
import 'package:missing_application/screens/landing/wigets/bookmark/bookmark_screen.dart';
import 'package:missing_application/screens/landing/wigets/home/home_screen.dart';
import 'package:missing_application/screens/landing/wigets/map/map_screen.dart';
import 'package:missing_application/screens/landing/wigets/profile/profile_screen.dart';
import 'package:url_launcher/url_launcher.dart';

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
    BlocProvider.of<AppinfoBloc>(context).add(GetAppinfo());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppinfoBloc, AppinfoState>(
      listenWhen: (previous, current) => ModalRoute.of(context)!.isCurrent,
      listener: (context, state) {
        if (state is AppinfoLoaded && state.info.version != '0.1.1') {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('업데이트 알림'),
                  content: Text('새로운 업데이트가 출시되었으니\n다운로드 부탁드립니다'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        if (Platform.isIOS &&
                            state.info.appstoreLink!.isNotEmpty) {
                          launchUrl(Uri.parse(state.info.appstoreLink!));
                        }

                        if (Platform.isAndroid &&
                            state.info.playstoreLink!.isNotEmpty) {
                          launchUrl(Uri.parse(state.info.playstoreLink!));
                        }
                      },
                      child: Text('확인'),
                    ),
                  ],
                );
              });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize:
                _selectedIndex == 1 ? Size.zero : Size.fromHeight(40.0),
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
      },
    );
  }
}
