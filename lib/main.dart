import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Providers/user_auth_provider.dart';
import 'firebase_options.dart';

import '../Screens/forget_password_screen.dart';
import '../Screens/splash_screen.dart';
import '../Screens/login_screen.dart';
import '../Screens/view_home_expense.dart';
import '../Screens/add_home_expense.dart';
import '../Screens/add_vehicle_expense.dart';
import '../Screens/home_screen.dart';
import '../Screens/view_vehicle_expense.dart';
import '../Providers/home_provider.dart';
import '../Providers/vehicle_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => VehicleProvide(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => UserAuthProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Expense Management System',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
          useMaterial3: true,
          primaryColor: Colors.deepPurpleAccent,
          snackBarTheme: const SnackBarThemeData(
            backgroundColor: Colors.deepPurpleAccent,
            actionTextColor: Colors.white,
          ),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              color: Colors.black,
            ),
            titleLarge: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            // bodyLarge: TextStyle(
            //   color: Colors.white,
            //   fontSize: 18,
            // ),
            labelMedium:
                TextStyle(color: Colors.deepPurpleAccent, fontSize: 20),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.deepPurpleAccent,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          cardTheme: const CardTheme(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
          ),
        ),
        routes: {
          LoginScreen.routeName: (ctx) => LoginScreen(),
          SplashScreen.routeName: (context) => SplashScreen(),
          ForgetPasswordScreen.routeName: (context) => ForgetPasswordScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          AddHomeExpense.routeName: (ctx) => AddHomeExpense(),
          AddVehicleExpense.routeName: (ctx) => AddVehicleExpense(),
          ViewHomeExpense.routeName: (ctx) => ViewHomeExpense(),
          ViewVehicleExpense.routeName: (ctx) => ViewVehicleExpense(),
        },
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, userSnapShot) {
            if (userSnapShot.hasData) {
              // return HomeScreen();
              return SplashScreen();
            } else {
              //user is currently signed out or token is expired
              return LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
