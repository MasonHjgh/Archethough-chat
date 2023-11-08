import 'package:flutter/material.dart';
import 'package:personal_village/utility/get_it_handler.dart';
import 'package:personal_village/values/routes.dart';
import 'package:carousel_slider/carousel_slider.dart';


class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int _currentIndex = 0;

  final List<String> _onboardingContent = [
    'Your safety, our priority:\n Welcome to Personal Village!',
    'Experience a safer and more connected lifestyle',
    'Access essential services effortlessly',
    'Simplify caregiving \n with the tap of a button.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: _currentIndex == _onboardingContent.length - 1
          ? FloatingActionButton(
        child: Icon(Icons.arrow_forward_rounded),
        onPressed: () {
          pvSettingsLogic.hasCompletedOnboarding.value = true;
          pvNavService.pushReplacementNamed(loginRoute);
        },
      )
          : null,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/LightLogo.png')
            )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CarouselSlider(
                items: _onboardingContent.map((item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item,
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10.0),
                            // You can add images or icons related to onboarding content here
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 100.0,
                  viewportFraction: 1.0,
                  onPageChanged: (index, _) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
              SizedBox(height: 120.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < _onboardingContent.length; i++) {
      indicators.add(_indicator(i == _currentIndex));
    }
    return indicators;
  }

  Widget _indicator(bool isActive) {
    return Container(
      height: 10.0,
      width: 10.0,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: isActive ? Colors.red: Colors.grey,
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }
}
