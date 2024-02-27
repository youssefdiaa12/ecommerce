import 'package:flutter/material.dart';

class HomeCategoryLoadingWidget extends StatelessWidget {
const HomeCategoryLoadingWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            height: 65,
            width: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color(0xff06004F),width: 1)
            )
        )
      ],
    );
  }
}
