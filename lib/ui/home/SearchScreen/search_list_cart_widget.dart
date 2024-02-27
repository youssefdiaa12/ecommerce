import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/Common/dialogUtilities.dart';
import 'package:ecommerce/domain/model/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../viewModel/ProivderViewModel/app_provider.dart';
import '../../../viewModel/SearchViewModel/search_view_model_cubit.dart';

class SearcListCardWidget extends StatefulWidget {
  final Product product;

  SearcListCardWidget(this.product);

  @override
  State<SearcListCardWidget> createState() => _SearcListCardWidgetState();
}

class _SearcListCardWidgetState extends State<SearcListCardWidget> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    var cubit = BlocProvider.of<SearchViewModelCubit>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            height: 120.h,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: const Color(0xffb2c5d9), width: 1)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: widget.product.imageCover ?? "",
                  fit: BoxFit.cover,
                  height: 120.h,
                  width: 113.w,
                  imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                        ),
                        borderRadius: BorderRadius.circular(25.r),
                        border:
                        Border.all(color: const Color(0xffb2c5d9), width: 1),
                      )),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 120.h,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0.h, top: 2.0.h),
                            child: SizedBox(
                              width: 150.w,
                              child: Text(
                                widget.product.title ?? "",
                                style: TextStyle(
                                  color: const Color(0xff252065),
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0.h),
                            child: Row(
                              children: [
                                Container(
                                  height: 15.h,
                                  width: 15.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text("Black Color",
                                    style: TextStyle(
                                      color: const Color(0xff252065),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "EGP ${widget.product.price}",
                                style: TextStyle(
                                  color: const Color(0xff252065),
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 6.0.w, bottom: 4.0.h),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff183555),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          )),
                      onPressed: () {},
                      child: Text("Add To Cart",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                            fontSize: 14.sp,
                          ))),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.transparent),
            child: appProvider.isFavorite(widget.product.id ?? "")
                ? InkWell(
              onTap: () async {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Theme.of(context).primaryColor,
                    content: Row(
                      children: [
                        Text("Loading ...",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontSize: 18.sp,
                            )),
                        const Spacer(),
                        Icon(
                          Icons.heart_broken_sharp,
                          color: Colors.white,
                          size: 20.sp,
                        )
                      ],
                    )));

                String result = await appProvider
                    .removeFromFavorite(widget.product.id ?? "");
                if (result != "success") {
                  dialogUtilites.lottieError(
                      context, "some thing went wrong");
                } else {

                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).primaryColor,
                      content: Row(
                        children: [
                          Text("Removed from favorites",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins",
                                fontSize: 18.sp,
                              )),
                          const Spacer(),
                          Icon(
                            Icons.heart_broken_sharp,
                            color: Colors.white,
                            size: 20.sp,
                          )
                        ],
                      ),
                    ),
                  );

                  if (mounted) {
                    setState(() {
                      // Your state update logic here
                    });
                  }
                }
              },
              child: Image.asset(
                "assets/icons/loved.png",
                fit: BoxFit.contain,
                width: 50.w,
                height: 50.h,
              ),
            )
                : InkWell(
              onTap: () async {
                bool isLogged= await cubit.checkUser();
                if(!isLogged){
                  return;
                }
                String result = await appProvider
                    .addToFavorite(widget.product.id ?? "");
                if (result != "success") {
                  dialogUtilites.lottieError(
                      context, "some thing went wrong");
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).primaryColor,
                      content: Row(
                        children: [
                          Text("Added to favorites",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins",
                                fontSize: 18.sp,
                              )),
                          const Spacer(),
                          Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 20.sp,
                          )
                        ],
                      ),
                    ),
                  );
                  if (mounted) {
                    setState(
                          () {
                        // Your state update logic here
                      },
                    );
                  }
                }
              },
              child: Image.asset(
                "assets/icons/unloved.png",
                fit: BoxFit.contain,
                height: 50.h,
                width: 50.w,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
