import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../nav_menu.dart';
import '../../utils/constants/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  int currentPage = 0;
  final PageController _pageController = PageController();

  void finishOnboarding() async {
    await secureStorage.write(key: 'onboardingCompleted', value: 'true');

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  NavigationMenu()),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> splashData = [
      {
        "title": "Welcome to SHOPA",
        "subtitle": "All in one ecommerce store",
        "image": "assets/images/splash1.png"
      },
      {
        "title": "Efficient & Fast",
        "subtitle": "Get your order in minutes",
        "image": "assets/images/splash2.png"
      },
      {
        "title": "Get Started Now",
        "subtitle": "Shop through different categories of products",
        "image": "assets/images/splash3.png"
      }
    ];

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemCount: splashData.length,
              itemBuilder: (context, index) => SplashContent(
                title: splashData[index]["title"]!,
                subtitle: splashData[index]["subtitle"]!,
                image: splashData[index]["image"]!,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              splashData.length,
              (index) => buildDot(index: index),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: currentPage == splashData.length - 1
                  ? finishOnboarding
                  : () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
              child: Text(currentPage == splashData.length - 1 ? "Get Started" : "Next"),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget buildDot({required int index}) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      width: currentPage == index ? 20 : 10,
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class SplashContent extends StatelessWidget {
  final String title, subtitle, image;

  const SplashContent({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, height: 250),
        const SizedBox(height: 20),
        Text(title, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 10),
        Text(subtitle, style: Theme.of(context).textTheme.labelMedium!.copyWith(color: TColors.primary)),
      ],
    );
  }
}
