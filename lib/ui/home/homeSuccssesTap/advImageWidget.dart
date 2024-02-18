import 'package:flutter/material.dart';

class advImageWidget extends StatelessWidget {
  String results;
  advImageWidget(this.results);
  @override
  Widget build(BuildContext context) {
    return Image.asset(results,height: 70,width: double.infinity,fit: BoxFit.cover,);

  }
}
