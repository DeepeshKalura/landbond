import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/app_url.dart';
import '../../../core/pallet.dart';
import '../bloc/home_bloc.dart';
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
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(
          LoadPopularPropertiesEvent(),
        );

    context.read<HomeBloc>().add(
          LoadLocalityEvent(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is NotificationButtonPressedState) {
          context.pushNamed(AppUrl.notificationScreen);
        }

        if (state is SearchSuccessState) {
          context.pushNamed(
            AppUrl.propertyScreen,
          );
        }

        if (state is LoadPopularErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage,
              ),
            ),
          );
        }

        if (state is LoadLocalityErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage,
              ),
            ),
          );
        }

        if (state is ShowMorePropertiesState) {
          context.pushNamed(AppUrl.listPropertiesScreen);
        }

        if (state is PropertySelectedState) {
          context.pushNamed(AppUrl.propertyDetailsScreen, extra: {
            'property': state.property,
          });
        }

        // if(state is ShowMoreLocalitiesState){
        //   context.pushNamed(AppUrl.localityListScreen);
        // }
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
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.65,
                          child: Text(
                            "Popluar Properties in India",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.quicksand(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Pallet.black,
                            ),
                          ),
                        ),
                        ShowMoreWidget(
                          onPressed: () {
                            context.read<HomeBloc>().add(
                                  ShowMorePropertiesEvent(),
                                );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        if (state is LoadPopularLoadingState) {
                          return Row(
                            children: [
                              Shimmer(
                                gradient: Pallet.shimmerGradient,
                                loop: 14,
                                child: Container(
                                  height: 210,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                    color: Pallet.greyColor2,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Shimmer(
                                loop: 14,
                                gradient: Pallet.shimmerGradient,
                                child: Container(
                                  height: 210,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Pallet.greyColor2,
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          if (context.read<HomeBloc>().popularProperty ==
                              null) {
                            return const SizedBox(
                              height: 210,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Pallet.primaryColor,
                                ),
                              ),
                            );
                          } else {
                            return SizedBox(
                              height: 320,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: context
                                    .read<HomeBloc>()
                                    .popularProperty!
                                    .length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      context.read<HomeBloc>().add(
                                            PropertySelectedEvent(
                                              property: context
                                                  .read<HomeBloc>()
                                                  .popularProperty![index],
                                            ),
                                          );
                                    },
                                    child: PeopertyCardWidget(
                                      property: context
                                          .read<HomeBloc>()
                                          .popularProperty![index],
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        }
                      },
                    ),
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
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.65,
                            child: Text(
                              "Localities to buy properties",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.quicksand(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Pallet.black,
                              ),
                            ),
                          ),
                          ShowMoreWidget(
                            onPressed: () {},
                          )
                        ],
                      ),
                      const SizedBox(width: 20),
                      BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          if (state is LoadLocalityLoadingState) {
                            return Row(
                              children: [
                                Shimmer(
                                  gradient: Pallet.shimmerGradient,
                                  loop: 14,
                                  child: Container(
                                    height: 300,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Pallet.whiteColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Shimmer(
                                  loop: 14,
                                  gradient: Pallet.shimmerGradient,
                                  child: Container(
                                    height: 300,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Pallet.whiteColor,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            if (context.read<HomeBloc>().locality == null ||
                                context.read<HomeBloc>().cities == null) {
                              return const SizedBox(
                                height: 300,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Pallet.primaryColor,
                                  ),
                                ),
                              );
                            } else {
                              return SizedBox(
                                height: 300,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      context.read<HomeBloc>().locality!.length,
                                  itemBuilder: (context, index) {
                                    return LocalityCardWidget(
                                      locality: context
                                          .read<HomeBloc>()
                                          .locality![index],
                                      city: context
                                          .read<HomeBloc>()
                                          .cities![index],
                                    );
                                  },
                                ),
                              );
                            }
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
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
