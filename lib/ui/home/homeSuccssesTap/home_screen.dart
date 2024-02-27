import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../../viewModel/ProivderViewModel/app_provider.dart';
import '../CategoriesTap/categoriesTap.dart';
import '../lovedTap/loved_tap.dart';
import '../myAccountTap/my_account.dart';
import 'home_tap.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'hometap';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late PersistentTabController _controller;
  @override
  void initState() {
    _controller=PersistentTabController(initialIndex: 0);

    super.initState();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


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
      const HomeTap(),
     const CategoriesTap(),
      const LovedTap(),
      const MyAccount(),
      //   const searchScreen(),
    ];
  }
  @override
  Widget build(BuildContext context) {
    AppProvider provider1 = Provider.of<AppProvider>(context);
    String productList=provider1.products_cartList?.length.toString()??"0";
    if(productList.length>=3){
      productList="99+";
    }
    return Scaffold(
      bottomNavigationBar: PersistentTabView(
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
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor: const Color(0xff183555),
        hideNavigationBarWhenKeyboardShows: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style6,
      ),
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
      body: _buildScreens()[_controller.index],
      );
  }
  @override
  void dispose() {
   // _pagingController.dispose();
    super.dispose();
  }
}
