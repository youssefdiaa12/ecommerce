import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/domain/model/Product.dart';
import 'package:flutter/material.dart';

class homeProuctLoadingWidget extends StatelessWidget {
  homeProuctLoadingWidget();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: const Color(0xff06004F),width: 1)
        ),
        child: Column
          (
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
           Container(
          height: 128,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
            shape: BoxShape.rectangle,
          ),
        ),

          Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white
                    ),
                    child:
                    const Icon(Icons.favorite_border,color: Colors.deepPurple,size: 25,),

                  ),
                ),

              ],
            ),
          ],
        )

        ,),
    );
  }
}
