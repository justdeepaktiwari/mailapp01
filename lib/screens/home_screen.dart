import 'package:flutter/material.dart';
import 'package:mailapp01/providers/auth_provider.dart';
import 'package:mailapp01/screens/auth/forget_screen.dart';
import 'package:mailapp01/screens/auth/signin_screen.dart';
import 'package:mailapp01/screens/complex/complex_screen.dart';
import 'package:mailapp01/screens/notifications_screen.dart';
import 'package:mailapp01/screens/profile_screen.dart';
import 'package:mailapp01/screens/setting_screen.dart';
import 'package:mailapp01/utils/constants.dart';
import 'package:mailapp01/widgets/bottom_navigation.dart';
import 'package:mailapp01/widgets/button.dart';
import 'package:mailapp01/widgets/requestcard_complex.dart';
import 'package:mailapp01/widgets/text_diffrent_color.dart';
import 'package:mailapp01/widgets/text_field.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Complex Id
  TextEditingController complexId = TextEditingController();

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

    if (!auth.isLoggedIn) {
      return const SignInScreen();
    }

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
        body: _widgetOptions[_selectedIndex],
        bottomNavigationBar: BottomNavigationBarUtils(
          isLoggedIn: auth.isLoggedIn,
          onItemTapped: onItemTapped,
          selectIndex: _selectedIndex,
        ),
        backgroundColor: AppConstants.primaryColor,
        floatingActionButton: _selectedIndex == 1
            ? FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    useSafeArea: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: AppConstants.primaryColor,
                        content: SizedBox(
                          height: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFieldWidget(
                                labelText: "Complex Id",
                                editingController: complexId,
                                isPasswordType: false,
                                textInputType: TextInputType.text,
                              ),
                              const SizedBox(
                                height: 15,
                                width: double.infinity,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgetScreen(),
                                    ),
                                  );
                                },
                                child: const TextDiffrentColorWidget(
                                  startText: "Don’t See your Complex ID?",
                                  endText: " Click Here",
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                                width: double.infinity,
                              ),
                              ButtonWidget(
                                onPressed: () {},
                                buttonName: "Join",
                              ),
                              const SizedBox(
                                height: 20,
                                width: double.infinity,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    child: const Text(
                                      "Close",
                                      style: TextStyle(
                                        color: AppConstants.white,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Icon(Icons.add),
              )
            : null,
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
