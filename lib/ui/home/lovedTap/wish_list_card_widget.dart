import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/domain/model/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../../../Common/flash_bar.dart';
import '../../../viewModel/LovedTapViewModel/loved_tap_cubit.dart';
import '../../../viewModel/ProivderViewModel/app_provider.dart';
import '../CategoriesTap/productDetailsCartWidget.dart';

class WishListCardWidget extends StatefulWidget {
  final Product product;

  const WishListCardWidget(this.product, {super.key});

  @override
  State<WishListCardWidget> createState() => _WishListCardWidgetState();
}

class _WishListCardWidgetState extends State<WishListCardWidget> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    var cubit = BlocProvider.of<LovedTapCubit>(context);

    return InkWell(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(context, screen: productDetailsCartWidget(widget.product),
            withNavBar:false
        );
      },
      child: Padding(
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
                        onPressed: () async{
                        bool isSuccess = await appProvider.invoke_addToCart(widget.product.id ?? "",
                          AppProvider.user?.token ?? "",
                          1);
                        if(isSuccess){
                          showFlushBar("Added Successfully",context,isError:false);
                        }
                        else{
                          showFlushBar("Something went wrong",context,isError:true);
                        }

                        },
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
                await cubit.getLovedProductList(AppProvider.user?.token ?? "");
                },
                child: Image.asset("assets/icons/loved.png"))
          ],
        ),
      ),
    );
  }
}
