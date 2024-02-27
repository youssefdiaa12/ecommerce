// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/Common/dialogUtilities.dart';
import 'package:ecommerce/domain/model/Product.dart';
import 'package:ecommerce/ui/home/CategoriesTap/productDetailsCartWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../../../Common/flash_bar.dart';
import '../../../viewModel/ProivderViewModel/app_provider.dart';
import '../../../viewModel/productsViewModelForCategory/category_products_cubit.dart';

class CategoryProuctListWidget extends StatefulWidget {
  final Product product;

  CategoryProuctListWidget(this.product, {super.key});

  @override
  State<CategoryProuctListWidget> createState() => _CategoryProuctListWidgetState();
}

class _CategoryProuctListWidgetState extends State<CategoryProuctListWidget> {
  @override
  Widget build(BuildContext context) {
    AppProvider apiProvider = Provider.of<AppProvider>(context);
    var cubit1 = BlocProvider.of<CategoryProductsCubit>(context);

    return InkWell(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(context, screen: productDetailsCartWidget(widget.product),
        withNavBar:false
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: const Color(0xff06004F), width: 1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                CachedNetworkImage(
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: 200.h,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25)),
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            )),
                      );
                    },
                    imageUrl: widget.product.imageCover ?? ""),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.transparent),
                  child: apiProvider.isFavorite(widget.product.id ?? "")
                      ? InkWell(
                    onTap: () async {
                      String result = await apiProvider
                          .removeFromFavorite(widget.product.id ?? "");
                      if (result != "success") {
                        dialogUtilites.lottieError(
                            context, "some thing went wrong");
                      } else {
                        showFlushBar("Removed From Favorite",context,isError:true);
                      }
                    },
                    child: Image.asset(
                      "assets/icons/loved.png",
                      fit:BoxFit.contain,
                    ),
                  )
                      : InkWell(
                    onTap: () async {
                      bool isLogged1= await cubit1.checkAuthority();
                      if(!isLogged1){
                        return;
                      }
                      String result = await apiProvider
                          .addToFavorite(widget.product.id ?? "");
                      if (result != "success") {
                        dialogUtilites.lottieError(
                            context, "some thing went wrong");
                      } else {
                        showFlushBar("Added to favorites",context,isError:false);
                      }
                    },
                    child: Image.asset(
                      "assets/icons/unloved.png",
                      fit:BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 4.0.w),
              child: Text(
                widget.product.title ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xff06004F),
                  fontSize:20.sp,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 4.0.w),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(left: 2.0.w),
                      child: Text(widget.product.price.toString(),
                        style:TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 22.sp,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0.w,),
                    Text("EGP", style: TextStyle(color: Theme.of(context).primaryColor)),

              ]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Review(${widget.product.ratingsAverage ?? ""})",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                          color: const Color(0xff06004F),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                          (index) => Icon(
                        Icons.star,
                        color: (widget.product.ratingsAverage ?? 0) >= (index + 1)
                            ? Colors.amber
                            : Colors.grey,
                        size: 20.sp,
                        // You can adjust the size based on your preference
                      ),
                    ),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
