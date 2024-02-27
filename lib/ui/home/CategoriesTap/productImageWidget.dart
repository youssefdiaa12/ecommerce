import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecommerce/Common/dialogUtilities.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../viewModel/CartListViewModel/cart_list_view_model_cubit.dart';
import '../../../viewModel/ProivderViewModel/app_provider.dart';
import 'package:provider/provider.dart';

class ProductImageWidget extends StatefulWidget {
  String image,id;
 final int currentPage,length;
   ProductImageWidget(this.image, this.currentPage, this.length, this.id, {super.key});

  @override
  State<ProductImageWidget> createState() => _ProductImageWidgetState();
}

class _ProductImageWidgetState extends State<ProductImageWidget> {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<CartListViewModelCubit>(context);
    AppProvider apiProvider = Provider.of<AppProvider>(context);
    if(widget.image.startsWith("https://ecommerce.routemisr.com/Route-Academy-products/")==false){
      widget.image="https://ecommerce.routemisr.com/Route-Academy-products/"+widget.image;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 12),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white10,
                  border: Border.all(color: const Color(0xffabc0d3), width: 1),
                ),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                          widget.image,
                          width: 398.w,
                          height: 305.h,
                          fit: BoxFit.cover,
                            errorWidget: (context, url, error) => const Center(
                                child: Icon(Icons.error, color: Colors.grey)),
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              height: 398.h,
                              width: 300.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Image(image: imageProvider,)
                            );
                          }
                        ),
                        AnimatedSmoothIndicator(
                          activeIndex: widget.currentPage,
                          count: widget.length,
                          effect: const ExpandingDotsEffect(dotColor: Colors.grey,activeDotColor:Color(0xff06004F) ,
                            dotHeight: 10,
                            dotWidth: 10,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
          Container(
            decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      color: Colors.transparent),
      child: apiProvider.isFavorite(widget.id)?
             InkWell(
              onTap: () async {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: const Color(0xff06004F),
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

                String result = await apiProvider
                    .removeFromFavorite(widget.id);
                if (result != "success") {
                  // ignore: use_build_context_synchronously
                  dialogUtilites.lottieError(
                      context, "some thing went wrong");
                } else {
                  // widget.key!.;
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();

                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor:const Color(0xff06004F),
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
              ),
            )
              : InkWell(
            onTap: () async {
              bool isLogged= await cubit.checkAuthority();
              if(!isLogged){
                return;
              }

              String result = await apiProvider
                  .addToFavorite(widget.id );
              if (result != "success") {
                dialogUtilites.lottieError(
                    context, "some thing went wrong");
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: const Color(0xff06004F),
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
            ),
          ),
      )
        ],
      ),
    );
  }
}
