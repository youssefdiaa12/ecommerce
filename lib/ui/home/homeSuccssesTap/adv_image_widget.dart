import 'package:flutter/material.dart';

class AdvImageWidget extends StatelessWidget {
  String results;
  AdvImageWidget(this.results, {super.key});
  @override
  Widget build(BuildContext context) {
    return Image.asset(results,height: 70,width: double.infinity,fit: BoxFit.cover,);

  }
}
