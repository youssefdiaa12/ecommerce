import 'package:flutter/material.dart';


class HomeBrandLoadingWidget extends StatelessWidget {

  const HomeBrandLoadingWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color(0xff06004F),width: 1)
          )
        )
      ],
    );
  }
}
