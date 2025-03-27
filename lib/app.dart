
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'screens/authentication/login.dart';
import 'screens/authentication/register.dart';
import 'utils/theme/theme.dart';

class App extends StatefulWidget {
   const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  PageController pageController = PageController();
  bool showSignin = true;

  void toggleScreen() {
    setState(() {
      showSignin = !showSignin;
      pageController.jumpToPage(showSignin ? 0 : 1);
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home:   
      Scaffold(
        body: PageView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: <Widget>[
            SigninScreen(toggleScreen: toggleScreen),
            SignupScreen(toggleScreen: toggleScreen),
          ],
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'screens/authentication/login.dart';
// import 'screens/authentication/register.dart';
// import 'screens/authentication/splash_screen.dart';
// import 'utils/theme/theme.dart';

// class App extends StatefulWidget {
//   const App({super.key});

//   @override
//   State<App> createState() => _AppState();
// }

// class _AppState extends State<App> {
//   final FlutterSecureStorage secureStorage = FlutterSecureStorage();
//   PageController pageController = PageController();
//   bool showSignin = true;
//   bool showSplash = true;

//   @override
//   void initState() {
//     super.initState();
//     checkIfOnboardingIsCompleted();
//   }

//   void checkIfOnboardingIsCompleted() async {
//     String? onboardingCompleted = await secureStorage.read(key: 'onboardingCompleted');
//     setState(() {
//       showSplash = onboardingCompleted == null;
//     });
//   }

//   void toggleScreen() {
//     setState(() {
//       showSignin = !showSignin;
//       pageController.jumpToPage(showSignin ? 0 : 1);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       themeMode: ThemeMode.system,
//       theme: TAppTheme.lightTheme,
//       darkTheme: TAppTheme.darkTheme,
//       home: showSplash
//           ? SplashScreen()
//           : Scaffold(
//         body: AnimatedSwitcher(
//           duration: const Duration(milliseconds: 300),
//           transitionBuilder: (widget, animation) {
//             return SlideTransition(
//               position: Tween<Offset>(
//                 begin: const Offset(1, 0), // Start from right
//                 end: Offset.zero, // Move to center
//               ).animate(animation),
//               child: widget,
//             );
//           },
//           child: showSignin
//               ? SigninScreen(toggleScreen: toggleScreen, key: ValueKey(1))
//               : SignupScreen(toggleScreen: toggleScreen, key: ValueKey(2)),
//         ),
//       ),
//     );
//   }
// }

