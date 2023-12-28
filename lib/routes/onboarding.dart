
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class OnBoardingScreen extends StatelessWidget
{
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      onFinish: () => { context.go('/login') },
      headerBackgroundColor: Theme.of(context).colorScheme.background,
      finishButtonText: 'Login with MyGES',
      finishButtonStyle: FinishButtonStyle(
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))
      ),
      skipTextButton: const Text('Skip'),
      background: const [
        SizedBox.shrink(),
        SizedBox.shrink(),
      ],
      totalPage: 2,
      speed: 1,
      pageBodies: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children : [
                  const Icon(LucideIcons.graduationCap, size: 32),
                  const SizedBox(width: 8),
                  Text('ReSkolae', style: Theme.of(context).textTheme.headlineLarge),
                ]
              ),
              const SizedBox(height: 32),
              const Text('A better alternative to Skolae.')
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Simple & Efficient', style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 32),
              const Text('Because your time is valuable. You deserve better from the ESGI.', textAlign: TextAlign.center)
            ],
          ),
        ),
      ],
    );
  }
}
