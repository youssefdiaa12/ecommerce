import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../../viewModel/ProivderViewModel/app_provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import '../ui/home/CartList/CartListWidget.dart';
import '../ui/home/SearchScreen/search_screen.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  int? color1;
  CustomAppBar({Key? key, this.color1}) : super(key: key);
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();


  @override
  Size get preferredSize => const Size.fromHeight(120.0);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    final FocusNode _searchFocus = FocusNode();

    AppProvider provider1 = Provider.of<AppProvider>(context);
    String productList = provider1.products_cartList?.length.toString() ?? "0";

    if (productList.length >= 3) {
      productList = "99+";
    }

    return AppBar(
      leading:null,
      leadingWidth:0.w,
      toolbarHeight: double.infinity,
      backgroundColor: Color(widget.color1??0x4dffffff),
      elevation: 0,
      title: Form(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/route.png", width: 44.w, height: 44.h),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      focusNode: _searchFocus,
                      onTap: () {
                        _searchFocus.unfocus();
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: searchScreen(),
                          withNavBar: false,
                        );

                      },
                      onChanged: (value) {
                        if(value.isEmpty){

                        }
                      },
                      controller: provider1.searchController,
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                            color: Color(0xff004182),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                            color: Color(0xff004182),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                            color: Color(0xff004182),
                          ),
                        ),
                        hintText: "What do you search for?",
                        hintStyle: const TextStyle(color: Color(0xff004182)),
                        prefixIcon:
                        Icon(Icons.search_sharp, size: 28.sp, color: const Color(0xff004182)),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen:CartListWidget(),
                        withNavBar: false,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 1.0, left: 6),
                      child: badges.Badge(
                        badgeAnimation: const badges.BadgeAnimation.rotation(
                          animationDuration: Duration(seconds: 1),
                          colorChangeAnimationDuration: Duration(seconds: 1),
                          loopAnimation: false,
                          curve: Curves.fastOutSlowIn,
                          colorChangeAnimationCurve: Curves.easeInCubic,
                        ),
                        position: badges.BadgePosition.topEnd(top: -14, end: -14),
                        badgeStyle: const badges.BadgeStyle(badgeColor: Color(0xff004182)),
                        showBadge: true,
                        badgeContent: Text(
                          (productList),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                        child: Image.asset("assets/icons/cart.png", width: 25.w, height: 25.h),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


}
