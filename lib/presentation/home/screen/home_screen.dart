import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_url.dart';
import '../../../core/pallet.dart';
import '../bloc/home_bloc.dart';
import '../data/model/types.dart';
import 'widget/feature_propteries_widget.dart';
import 'widget/menu_widget.dart';
import 'widget/search_widget.dart';
import 'widget/show_more_widget.dart';
import 'widget/top_qualities_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is NotificationButtonPressedState) {
          context.pushNamed(AppUrl.notificationScreen);
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const MagicBrickMenu(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Real Estate India',
                    style: GoogleFonts.quicksand(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      context.read<HomeBloc>().add(
                            NotificationButtonPressedEvent(),
                          );
                    },
                    child: const Icon(
                      Icons.inbox_rounded,
                      color: Pallet.primaryColor,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                  InkWell(
                    onTap: () {
                      if (_scaffoldKey.currentState!.isDrawerOpen) {
                        _scaffoldKey.currentState!.openEndDrawer();
                      } else {
                        _scaffoldKey.currentState!.openDrawer();
                      }
                    },
                    child: const Icon(
                      Icons.menu,
                      color: Pallet.primaryColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ],
          ),
          backgroundColor: Pallet.whiteColor,
          elevation: 1,
          shadowColor: Pallet.appBarBlack,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchWidget(),
              const SizedBox(
                height: 2,
              ),
              Container(
                height: 300,
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Popluar Properties in India",
                          style: GoogleFonts.quicksand(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Pallet.black,
                          ),
                        ),
                        ShowMoreWidget(
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // const PeopertyCard(
                    //   name: "3 BHK Builder Floor",
                    //   address: "Kalkaji, New Delhi",
                    //   status: PropertyStatus.readyToMove,
                    //   imageUrl:
                    //       "https://images.unsplash.com/photo-1488034976201-ffbaa99cbf5c",
                    //   rating: 4.5,
                    //   price: 25000,
                    // ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              // CityWidget(),
              Container(
                color: Pallet.greyContainerColor,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Localities to buy properties",
                            style: GoogleFonts.quicksand(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Pallet.black,
                            ),
                          ),
                          const SizedBox(width: 10),
                          ShowMoreWidget(
                            onPressed: () {},
                          )
                        ],
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        height: 290,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: const [
                            // LocalityCardWidget(),
                            // SizedBox(width: 12),
                            // LocalityCardWidget(),
                            // SizedBox(width: 12),
                            // LocalityCardWidget(),
                            // SizedBox(width: 12),
                            // LocalityCardWidget(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              )

              // TopConsumerWidget(),
            ],
          ),
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: 'Home',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.search),
        //       label: 'Search',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.favorite),
        //       label: 'Favourite',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.person),
        //       label: 'Profile',
        //     ),
        //   ],
        //   selectedItemColor: Colors.blue,
        //   unselectedItemColor: Colors.grey,
        //   showUnselectedLabels: true,
        // ),
      ),
    );
  }

  // Helper function to build type buttons
  Widget buildTypeButton(String title) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 47,
      decoration: BoxDecoration(
        color: const Color(0xFF234F68),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
