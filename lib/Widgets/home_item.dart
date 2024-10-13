import 'package:flutter/material.dart';

class HomeItem extends StatelessWidget {
  final String title;
  var navigateFunction;

  HomeItem(this.title, this.navigateFunction);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: navigateFunction,
      child: Container(
        width: 30,
        height: 50,
        child: Text(
          title,
          style: TextStyle(
             color: Colors.white,
             fontSize: 18,
           ),
          textAlign: TextAlign.center,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).primaryColor,
        ),
        alignment: Alignment.center,
      ),
    );
  }
}
