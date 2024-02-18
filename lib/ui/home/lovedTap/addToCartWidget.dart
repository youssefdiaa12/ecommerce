import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/domain/model/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../viewModel/LovedTapViewModel/loved_tap_cubit.dart';
import '../../../viewModel/ProivderViewModel/app_provider.dart';

class addToCartWidget extends StatefulWidget {
  Product product;

  addToCartWidget(this.product);

  @override
  State<addToCartWidget> createState() => _addToCartWidgetState();
}

class _addToCartWidgetState extends State<addToCartWidget> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    var cubit = BlocProvider.of<LovedTapCubit>(context);

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
                Spacer(),
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
          InkWell(
              onTap: () async {
                await appProvider.removeFromFavorite(widget.product.id ?? "");
                // ignore: use_build_context_synchronously
                cubit.getLovedProductList(AppProvider.user?.token ?? "");
              },
              child: Image.asset("assets/icons/loved.png"))
        ],
      ),
    );
  }
}
