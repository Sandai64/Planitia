import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:reskolae/utils/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';


class InitScreen extends StatefulWidget
{
  const InitScreen({ super.key });

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen>
{
  bool hasError = false;
  String? errorMessage;

  @override
  Widget build(BuildContext context)
  {
    WidgetsBinding.instance.addPostFrameCallback(
      (_)
      {
        Logging.log(this, 'addPostFrameCallback()');

        // Choose initial route
        SharedPreferences.getInstance().then(
          (prefs)
          {
            bool? hasSeenOnboarding = prefs.getBool('hasSeenOnboarding');
            String route = '/onboarding';

            if (hasSeenOnboarding != null && hasSeenOnboarding == true)
            {
              route = '/home';
            }

            Logging.log(this, 'Redirecting to $route');
            context.go(route);
          }
        ).catchError(
          (err)
          {
            setState(
              ()
              {
                hasError = true;
                errorMessage = 'fatal: <Init> SharedPreferences.getInstance(): unexpected error.';
              }
            );
          }
        );
      }
    );

    return Scaffold(
      body: Center(
        child:
          hasError ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(LucideIcons.alertCircle, size: 32),
                    const SizedBox(width: 16),
                    Text('ReSkolae crashed.', style: Theme.of(context).textTheme.headlineMedium)
                  ],
                ),
                const SizedBox(height: 16),
                const Text('Error message:'),
                Text(errorMessage!, style: Theme.of(context).textTheme.labelSmall),
                const SizedBox(height: 16),
                const Text('What to do:'),
                Text('Please send an email to <contact@erwan.sh>, mentionning the error message above, your current device & how to recreate this scenario. We apologize for the inconvenience.', style: Theme.of(context).textTheme.labelSmall),
              ],
            )
          )
        : const CircularProgressIndicator()
      ),
    );
  }
}
