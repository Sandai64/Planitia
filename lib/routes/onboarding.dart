
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingScreen extends StatelessWidget
{
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: IntroductionScreen(
        done: const Text('Login with MyGES'),
        next: const Text('Next'),
        onDone: () => { context.go('/login') },
        pages: [
          PageViewModel(
            decoration: const PageDecoration(
              bodyAlignment: Alignment.center
            ),
            titleWidget: Text('planitia', style: TextStyle(fontFamily: 'colorbasic', fontSize: Theme.of(context).textTheme.displayLarge?.fontSize)),
            body: 'An easier way into the MyGES network.'
          ),
          PageViewModel(
            decoration: const PageDecoration(
              bodyAlignment: Alignment.center
            ),
            titleWidget: Text('SIMPLE', style: TextStyle(fontFamily: 'EDD', fontSize: Theme.of(context).textTheme.displayMedium?.fontSize)),
            body: 'Guaranteed to be easy. See your grades & upcoming classes with a simple UI.'
          ),
          PageViewModel(
            decoration: const PageDecoration(
              bodyAlignment: Alignment.center
            ),
            titleWidget: Text('STABLE', style: TextStyle(fontFamily: 'EDD', fontSize: Theme.of(context).textTheme.displayMedium?.fontSize)),
            body: 'Tested and well-designed. Not something the MyGES devs really thought about.'
          ),
        ],
      )
    );
  }
}
