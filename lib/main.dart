import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reskolae/routes/init.dart';
import 'package:reskolae/routes/login.dart';
import 'package:reskolae/routes/onboarding.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ReSkolaeApp());
}

class ReSkolaeApp extends StatelessWidget
{
  ReSkolaeApp({super.key});

  final _router = GoRouter(routes: [
    GoRoute(path: '/', builder: (context, state) => const InitScreen()),
    GoRoute(path: '/onboarding', builder: (context, state) => const OnBoardingScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
  ]);

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp.router(
      title: 'ReSkolae',
      theme: ThemeData(useMaterial3: true),
      routerConfig: _router,
    );
  }
}
