import 'package:flutter/material.dart';
import 'package:verker_prof/features/authentication/views/welcome_view/widgets/slider_widget.dart';

List<Widget> welcomeViewSlides = [
  const SlideWidget(
    image: 'assets/slider_one.png',
    title: 'Filtrer og byd op dine favorit projekter',
    description:
        'Hvorfor spilde tiden på opgaver du ikke gider? Fuld kalenderen ud med opgaver du elsker!',
  ),
  const SlideWidget(
    image: 'assets/slider_two.png',
    title: 'Hold styr på alle dine tilbud og projekter',
    description:
        'Hav det komplette overblik over alle opgaver, undgå oversete sager.',
  ),
  const SlideWidget(
    image: 'assets/slider_three.png',
    title: 'Kommuniker 1 sted og hold styr på aftaler',
    description:
        'Hold alt kommunikation 1 sted, og vær sikker på kunden er sikker.',
  ),
];
