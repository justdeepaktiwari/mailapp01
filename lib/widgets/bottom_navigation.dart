import 'package:flutter/material.dart';
import 'package:mailapp01/utils/constants.dart';

// ignore: must_be_immutable
class BottomNavigationBarUtils extends StatelessWidget {
  int selectIndex;
  bool isLoggedIn;
  final void Function(int) onItemTapped;

  BottomNavigationBarUtils({
    super.key,
    required this.isLoggedIn,
    required this.onItemTapped,
    required this.selectIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoggedIn,
      child: BottomNavigationBar(
        backgroundColor: AppConstants.bottomNavigationColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications_active,
              size: 28,
            ),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_home,
              size: 28,
            ),
            label: 'Complexs',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 28,
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 28,
            ),
            label: 'Setting',
          ),
        ],
        unselectedIconTheme: const IconThemeData(color: AppConstants.white),
        currentIndex: selectIndex,
        selectedItemColor: AppConstants.bootomButtonColor,
        unselectedItemColor: AppConstants.white,
        type: BottomNavigationBarType.fixed,
        elevation: 50,
        onTap: onItemTapped,
      ),
    );
  }
}
