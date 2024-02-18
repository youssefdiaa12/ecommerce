import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'advImageWidget.dart';

class homeAdv extends StatefulWidget {
   homeAdv({Key? key}) : super(key: key);

  @override
  State<homeAdv> createState() => _homeAdvState();
}

class _homeAdvState extends State<homeAdv> {
  CarouselController buttonCarouselController = CarouselController();
  int currentPage = 0;

  List <String> results = [];
@override
  void initState() {
    super.initState();
    results.add("assets/images/adv/adv1.png");
    results.add("assets/images/adv/adv2.png");
    results.add("assets/images/adv/adv3.png");
  }
  @override
  Widget build(BuildContext context) {
               return Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
      children: [
        CarouselSlider.builder(
          itemCount: 3,
          carouselController: buttonCarouselController,
          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
              advImageWidget(results[itemIndex]),
          options: CarouselOptions(
              autoPlay: true,
              height: 180.h,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: false,
              pageSnapping: true,
              aspectRatio: 16 / 9,
              viewportFraction: 1.2,
              initialPage: 0,
              animateToClosest: true,
              enableInfiniteScroll: true,
              clipBehavior: Clip.hardEdge,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  currentPage = index;
                });
              }

          ),

        ),
        SizedBox(height: 10,),
        AnimatedSmoothIndicator(
          activeIndex: currentPage,
          count: 3,
          effect: ExpandingDotsEffect(dotColor: Colors.grey,activeDotColor: Theme.of(context).primaryColor,
            dotHeight: 10,
            dotWidth: 10,
          ),
        )
      ],
    ),
               );

  }
}
