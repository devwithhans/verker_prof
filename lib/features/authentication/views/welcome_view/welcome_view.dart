import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:verker_prof/features/authentication/views/login_view/login_view.dart';
import 'package:verker_prof/features/authentication/views/welcome_view/widgets/carousel_slider.dart';
import 'package:verker_prof/features/authentication/views/welcome_view/widgets/slider_list.dart';
import 'package:verker_prof/utils/theme/widgets/buttons.dart';

class WelcomeView extends StatelessWidget {
  WelcomeView({Key? key}) : super(key: key);

  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    int currentSlide = 0;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/VerkerLogo.png',
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                  CarouselWithIndicatorDemo(welcomeViewSlides),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: StandardButton(
                    text: 'Kom igang',
                    onPressed: () {
                      Navigator.pushNamed(context, LoginView.name);
                    }),
              )
            ],
          ),
        ));
  }
}
