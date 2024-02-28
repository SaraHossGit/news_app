import 'package:flutter/material.dart';
import 'package:news_app/layouts/home_layout.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  bool isLast = false;
  List<Map<String, String>> boarding = [
    {
      "image": "assets/images/onboarding1.jpg",
      "title": "Never miss a beat",
      "description":
          "Get instant access to the latest news, complete with detailed insights to quench your thirst for knowledge",
    },
    {
      "image": "assets/images/onboarding2.jpeg",
      "title": "Spread the word",
      "description":
          "Share interesting articles with your friends and family, sparking conversations and keeping them informed too",
    },
    {
      "image": "assets/images/onboarding3.jpg",
      "title": "Bookmark for later",
      "description":
          "Save articles for later reading, ensuring you never miss out on important updates",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          physics: const BouncingScrollPhysics(),
          controller: boardController,
          onPageChanged: (int index) {
            if (index == boarding.length - 1) {
              setState(() {
                isLast = true;
              });
            } else {
              setState(() {
                isLast = false;
              });
            }
          },
          itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
          itemCount: boarding.length,
        ),
      ),
    );
  }

  Widget buildBoardingItem(Map<String, String> model) => Stack(
        fit: StackFit.expand,
        children: [
          // Image
          Align(
            alignment: Alignment.topCenter,
            child: Image(
              height: (MediaQuery.of(context).size.height / 2) + 50,
              width: MediaQuery.of(context).size.width,
              image: AssetImage('${model["image"]}'),
              fit: BoxFit.cover,
            ),
          ),
          // White Container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: (MediaQuery.of(context).size.height / 2) - 50,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model["title"].toString(),
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    model["description"].toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.black45),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: SmoothPageIndicator(
                        controller: boardController,
                        effect: const ExpandingDotsEffect(
                          dotColor: Colors.grey,
                          activeDotColor: Colors.black,
                          dotHeight: 12,
                          expansionFactor: 4,
                          dotWidth: 10,
                          spacing: 5.0,
                        ),
                        count: boarding.length,
                      ),
                    ),
                  ),
                  Center(
                    child: defaultButton(
                      buttonText: isLast ? "Here We Go!" : "Next",
                      changeSettingsFunc: () {
                        if (isLast) {
                          submit();
                        } else {
                          boardController.nextPage(
                            duration: const Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      );

  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeLayout()));
      }
    });
  }
}
