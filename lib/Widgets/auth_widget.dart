import 'package:expense_mangament_system/Providers/user_auth_provider.dart';
import 'package:expense_mangament_system/Screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Screens/forget_password_screen.dart';

class AuthWidget extends StatefulWidget {
  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  bool isloading = false;


  bool _passwordVisible = false;


  void submitForm() async {
    final userProvider =
         Provider.of<UserAuthProvider>(context, listen: false);
    try {
      setState(() {
        isloading = true;
      });

      //login the user
      await userProvider
          .login(_emailController.text, _passwordController.text.trim())
          .then(
              (value) => Navigator.pushNamed(context, SplashScreen.routeName));

      //Navigator.pushNamed(context, SplashScreen.routeName);
    } catch (error) {
      setState(() {
        isloading = false;
      });
      print(
        "Error : $error",
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          //backgroundColor: Colors.white,
          content: Text(
            error.toString(),
            // style: TextStyle(
            //   color: Theme.of(context).primaryColor,
            // ),
          ),
        ),
      );
    }
  }

  void trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      submitForm();
      //submitbtn(_userEmail, _userName, _password, _isLogin, context);
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwordController.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Welcome to Javeed Rasheed",
          style: TextStyle(
              fontSize: 26, color: Colors.white, fontWeight: FontWeight.w700),
        ),
        Card(
          margin: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 5,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: const ValueKey("email"),
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains("@")) {
                        return "Enter a valid Email Address";
                      } else {
                        return null;
                      }
                    },

                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        labelText: "Email Address",
                        hintText: "e.g example@gmail.com"),
                  ),
                  TextFormField(
                    key: const ValueKey("password"),
                    controller: _passwordController,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "****",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, ForgetPasswordScreen.routeName);
                      },
                      child: const Text(
                        "Forgot Password?",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  isloading
                      ? const CircularProgressIndicator()
                      : Column(
                          children: [
                            ElevatedButton(
                              onPressed: trySubmit,
                              child: Text("Login"),
                            ),
                          ],
                        ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// validator: (value) {
//   if (!_isLogin) {
//     String pattern =
//         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
//     RegExp regExp = new RegExp(pattern);
//     print("reg result :  ${regExp.hasMatch(value!)}");
//     if (!regExp.hasMatch(value!)) {
//       return "must have at least 1 Numeric,Capital and lower case letter";
//     } else {
//       if (value!.isEmpty || value.length < 7) {
//         return "Enter a password of at least length 7";
//       } else if (value!.isEmpty || value.length > 20) {
//         return "Enter a password of at least length 7 and less then 20 character";
//       } else {
//         null;
//       }
//     }
//   } else {
//     null;
//   }
// },
// onChanged: (value) => _password = value!.trim(),
// onSaved: (value) {
//   _password = value!.trim();
// },
