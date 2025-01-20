import 'package:findmyguide/constants/color_constants.dart';
import 'package:findmyguide/controllers/nav_controller.dart';
import 'package:findmyguide/views/booking/booking_view.dart';
import 'package:findmyguide/views/home/home_view.dart';
import 'package:findmyguide/views/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../views/wishlist/wishlist_view.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  final controller = Get.put(NavController());

  @override
  void initState() {
    super.initState();
  }

  _onItemTapped(int index) {
      controller.selectedIndex.value = index;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=>
        controller.selectedIndex.value == 0
          ? const HomeView()
          : controller.selectedIndex.value == 1
            ? const WishlistView()
            : controller.selectedIndex.value == 2
              ? const BookingView()
              : controller.selectedIndex.value == 3
                ? const ProfileView()
                : Container(),
      ),
      backgroundColor:Colors.black.withOpacity(0.1),
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Obx(() =>
        Container(
          height: 35.sp,
          margin: EdgeInsets.all(15.sp),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: blue.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(-5, 10)
              ),
              BoxShadow(
                color: torquise.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(5, -10)
              ),
            ]
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BottomNavigationBar(
              elevation: 15,
              type: BottomNavigationBarType.fixed,
              backgroundColor: white,
              selectedItemColor: blue,
              unselectedItemColor: greyblueDrk,
              currentIndex: controller.selectedIndex.value,
              onTap: _onItemTapped,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.space_dashboard_rounded),
                  label: 'Discover',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_rounded),
                  label: 'Wishlist',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.book_rounded),
                  label: 'Bookings',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_rounded),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
