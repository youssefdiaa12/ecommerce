import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../CategoriesTap/categoriesTap.dart';
import '../lovedTap/lovedTap.dart';
import '../myAccountTap/myAccount.dart';
import 'homeTap.dart';

class hometap extends StatefulWidget {
  static const routeName = 'hometap';
  const hometap({Key? key}) : super(key: key);

  @override
  State<hometap> createState() => _hometapState();
}

class _hometapState extends State<hometap> {

  late PersistentTabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon:Image.asset("assets/icons/selectedIcons/home.png"),
          inactiveIcon:Image.asset("assets/icons/unselectedIcons/home.png"),
          activeColorPrimary: Color(Theme.of(context).primaryColor.value),
          activeColorSecondary: Color(Theme.of(context).primaryColor.value),
          inactiveColorPrimary: Colors.white,
          inactiveColorSecondary: Colors.white,
        ),
        PersistentBottomNavBarItem(
          icon:Image.asset("assets/icons/selectedIcons/cat.png"),
          inactiveIcon:Image.asset("assets/icons/unselectedIcons/cat.png"),
          activeColorPrimary: Color(Theme.of(context).primaryColor.value),
          activeColorSecondary: Color(Theme.of(context).primaryColor.value),
          inactiveColorPrimary: Colors.white,
          inactiveColorSecondary: Colors.white,
        ),
        PersistentBottomNavBarItem(
            icon:Image.asset("assets/icons/selectedIcons/love.png"),
            inactiveIcon:Image.asset("assets/icons/unselectedIcons/love.png"),
            activeColorPrimary: Color(Theme.of(context).primaryColor.value),
            activeColorSecondary: Color(Theme.of(context).primaryColor.value),
            inactiveColorPrimary: Colors.white,
            inactiveColorSecondary: Colors.white,),
        PersistentBottomNavBarItem(
            icon:Image.asset("assets/icons/selectedIcons/acc.png"),
            inactiveIcon:Image.asset("assets/icons/unselectedIcons/acc.png"),
            activeColorPrimary: Color(Theme.of(context).primaryColor.value),
            activeColorSecondary: Color(Theme.of(context).primaryColor.value),
            inactiveColorPrimary: Colors.white,
            inactiveColorSecondary: Colors.white,),

      ];
    }
    List<Widget> _buildScreens() {
      return [
        const homeTap(),
         categoriesTap(),
        const lovedTap(),
        const MyAccount(),
      ];
    }
    return Scaffold(
        resizeToAvoidBottomInset: true, // Set this to false
        appBar: AppBar(
        toolbarHeight: 110.h,
        backgroundColor: Colors.white30,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/route.png", width: 44.w, height: 44.h),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 12.h),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                          color: Color(0xff004182),
                        )
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                          color: Color(0xff004182),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                          color: Color(0xff004182),
                        ),
                      ),
                      hintText: "What do you search for?",
                      hintStyle: TextStyle(color: Color(0xff004182)),
                      prefixIcon: Icon(Icons.search_sharp, size: 28.sp, color: Color(0xff004182)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 1.0,left: 6),
                  child: Image.asset("assets/icons/cart.png", width: 25.w, height: 25.h),
                ),
              ],
            ),
          ],
        ),
      ),

      body:PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        onItemSelected: (index) {
          setState(() {
            _controller.index = index;
          });
        },
        stateManagement: false,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(12.0),),
        confineInSafeArea: true,
        backgroundColor: Color(0xff183555),
        // Default is Colors.white.
        handleAndroidBackButtonPress: true,
        // Default is true.
        resizeToAvoidBottomInset: true,  // Set this to false

        hideNavigationBarWhenKeyboardShows: true,
        // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        popAllScreensOnTapOfSelectedTab: true,
        popAllScreensOnTapAnyTabs: false,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle
            .style6, // Choose the nav bar style with this property.
      )
      );
  }
  @override
  void dispose() {
   // _pagingController.dispose();
    super.dispose();
  }
}
