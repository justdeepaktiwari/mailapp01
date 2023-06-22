import 'package:flutter/material.dart';
import 'package:mailapp01/providers/auth_provider.dart';
import 'package:mailapp01/screens/complex/complex_screen.dart';
import 'package:mailapp01/screens/notifications_screen.dart';
import 'package:mailapp01/screens/profile_screen.dart';
import 'package:mailapp01/screens/setting_screen.dart';
import 'package:mailapp01/utils/constants.dart';
import 'package:mailapp01/utils/screens_manage_utils.dart';
import 'package:mailapp01/widgets/bottom_navigation.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Maintain Screen History
  List<int> screenHistory = [];

  // Bottom navigation bar indexs
  int _selectedIndex = 0;

  // List of widget showing on changing according to bottom button
  final List<Widget> _widgetOptions = [
    const NotificationsScreen(),
    const ComplexsScreen(),
    const ProfileScreen(),
    const SettingScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        // Handle the back button press
        if (screenHistory.isNotEmpty) {
          int previousPage = screenHistory.length - 1;
          setState(() {
            _selectedIndex = screenHistory[previousPage];
            screenHistory.removeLast();
          });
          // Prevent default back button behavior
          return false;
        }
        // Allow default back button behavior
        return true;
      },
      child: Scaffold(
        body: ScreenManageUtils(
          selectIndex: _selectedIndex,
          widgetOptions: _widgetOptions,
          isLogeddin: auth.isLoggedIn,
        ),
        bottomNavigationBar: BottomNavigationBarUtils(
          isLoggedIn: auth.isLoggedIn,
          onItemTapped: onItemTapped,
          selectIndex: _selectedIndex,
        ),
        backgroundColor: AppConstants.primaryColor,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      if (screenHistory.length > 4) {
        if (_selectedIndex != 0) {
          screenHistory = [0];
        } else {
          screenHistory.clear();
        }
      }
      screenHistory.add(_selectedIndex);
      _selectedIndex = index;
    });
  }
}
