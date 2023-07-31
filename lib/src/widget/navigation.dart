import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../pages/screen/dasborad_page.dart';
import '../pages/screen/profile_page.dart';
import '../theme/simta_color.dart';
import 'custom_bottom_bar.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;

  final _inactiveColor = Colors.black;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: getBody(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar() {
    return CustomAnimatedBottomBar(
      containerHeight: 60,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: SvgPicture.asset(
            'assets/svg/House.svg',
            width: 30,
            height: 30,
            color: _currentIndex == 0 ? SimtaColor.birubar : _inactiveColor,
          ),
          title: Text(
            'Home',
            style: TextStyle(
              fontSize: 17,
              color: _currentIndex == 0 ? SimtaColor.birubar : _inactiveColor,
            ),
          ),
          activeColor: SimtaColor.birubar.withOpacity(0.4),
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: SvgPicture.asset(
            'assets/svg/account.svg',
            width: 30,
            height: 30,
            color: _currentIndex == 1 ? SimtaColor.birubar : _inactiveColor,
          ),
          title: Text(
            'Profile',
            style: TextStyle(
              fontSize: 17,
              color: _currentIndex == 1 ? SimtaColor.birubar : _inactiveColor,
            ),
          ),
          activeColor: SimtaColor.birubar,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      const DasboardPage(),
      const ProfilePage(),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }
}
