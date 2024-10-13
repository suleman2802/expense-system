import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import '../Providers/home_provider.dart';
import '../Providers/vehicle_provider.dart';

import './home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/SplashScreen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void getNecessaryData() async {
    try {
      await Provider.of<HomeProvider>(context, listen: false)
          .fetch_data();
      await Provider.of<VehicleProvide>(context, listen: false).fetch_data();
      // .then((value) =>
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => HomeScreen()),
      // );

      // Navigator.of(context).pushNamed(HomeScreen.routeName);
      print("data fetched");
    } catch (error) {
      print("Error fetch "+error.toString());
      //Navigator.of(context).pushNamed(AuthScreen.routeName);
    }
    // );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNecessaryData();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.delayed(
          const Duration(seconds: 4),
        ),
        builder: (ctx, timer) => AnimatedSplashScreen(
          duration: 3500,
          splash: Image.asset(
            'assets/images/splash_logo.png',
          ),
          splashIconSize: 700,
          nextScreen: HomeScreen(),
          //splashTransition: SplashTransition.slideTransition,
        ),
      ),
    );
  }
}
