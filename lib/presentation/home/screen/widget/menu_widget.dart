import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/app_url.dart';
import '../../../../core/pallet.dart';
import '../../bloc/home_bloc.dart';

class MagicBrickMenu extends StatefulWidget {
  const MagicBrickMenu({super.key});

  @override
  State<MagicBrickMenu> createState() => _MagicBrickMenuState();
}

class _MagicBrickMenuState extends State<MagicBrickMenu> {
  var loadingState = false;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(MenuAuthenticationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is MenuLoginState) {
          context.pushReplacementNamed(AppUrl.signInScreen);
        }

        if (state is UserMenuErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Pallet.red,
            ),
          );
        }
      },
      child: Drawer(
        child: Container(
          color: Pallet.whiteColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Pallet.primaryColor,
                ),
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    loadingState = state is MenuLoginState;
                    if (state is GuestMenuState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () =>
                                context.read<HomeBloc>().add(MenuLoginEvent()),
                            child: const Center(
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Pallet.whiteColor,
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Pallet.primaryColor,
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            'Hello, Guest!',
                            style: TextStyle(
                              color: Pallet.whiteColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    }

                    if (state is UserMenuState) {
                      return loadingState
                          ? const SizedBox(
                              height: double.infinity,
                              width: double.infinity,
                              child: Center(
                                child: SizedBox(
                                  height: 45,
                                  width: 45,
                                  child: CircularProgressIndicator(
                                    color: Pallet.whiteColor,
                                  ),
                                ),
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Pallet.whiteColor,
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            state.user.profilePhotoUrl,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Hello, ${state.user.name}',
                                  style: const TextStyle(
                                    color: Pallet.whiteColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            );
                    }

                    return const SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Center(
                        child: SizedBox(
                          height: 45,
                          width: 45,
                          child: CircularProgressIndicator(
                            color: Pallet.whiteColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Main Menu Sections
              _buildMenuSection(
                'Home',
                Icons.home,
                context,
                () {},
              ),
              _buildMenuSection(
                'My Dashboard',
                Icons.dashboard,
                context,
                () {},
              ),
              _buildMenuSection(
                'Properties for Buy',
                Icons.shopping_cart,
                context,
                () {},
              ),
              _buildMenuSection(
                'Properties for Rent',
                Icons.key,
                context,
                () {},
              ),
              _buildMenuSection(
                'New Projects',
                Icons.business,
                context,
                () {},
              ),
              _buildMenuSection(
                'Explore Localities',
                Icons.location_city,
                context,
                () {},
              ),
              _buildMenuSection(
                'Property Advice',
                Icons.help_outline,
                context,
                () {},
              ),

              const Divider(
                color: Pallet.greyColor2,
              ),

              // Sell/Rent Your Property Section
              _buildMenuSection(
                'Sell/Rent your Property',
                Icons.store,
                context,
                () {},
              ),
              _buildSubMenuSection(
                'Post Property',
                Icons.add_box,
                context,
                () {},
              ),
              _buildSubMenuSection(
                'Advertise with Us',
                Icons.campaign,
                context,
                () {},
              ),

              const Divider(
                color: Pallet.backgroundColor,
              ),

              // Other Menu Sections
              _buildMenuSection(
                'Home Loans',
                Icons.account_balance_wallet,
                context,
                () {},
              ),
              _buildMenuSection(
                'Home Interiors',
                Icons.house_siding,
                context,
                () {},
              ),
              _buildSubMenuSection(
                'FREE Rent Agreement',
                Icons.article,
                context,
                () {},
              ),

              const Divider(
                color: Pallet.backgroundColor,
              ),

              // Tools & Advice Section
              _buildMenuSection(
                'Tools & Advice',
                Icons.tips_and_updates,
                context,
                () {},
              ),
              _buildSubMenuSection(
                'Propworth',
                Icons.monetization_on,
                context,
                () {},
              ),
              _buildSubMenuSection(
                'Rates & Trends',
                Icons.trending_up,
                context,
                () {},
              ),
              _buildSubMenuSection(
                'Propindex',
                Icons.book,
                context,
                () {},
              ),

              const Divider(
                color: Pallet.backgroundColor,
              ),

              // Blogs Section
              _buildMenuSection(
                'Blogs',
                Icons.rss_feed,
                context,
                () {},
              ),
              _buildSubMenuSection(
                'Lifestyle',
                Icons.style,
                context,
                () {},
              ),
              _buildSubMenuSection(
                'Policies',
                Icons.policy,
                context,
                () {},
              ),
              _buildSubMenuSection(
                'Finance & Legal',
                Icons.account_balance,
                context,
                () {},
              ),
              _buildSubMenuSection(
                'Research',
                Icons.search,
                context,
                () {},
              ),
              _buildSubMenuSection(
                'City News',
                Icons.newspaper,
                context,
                () {},
              ),

              const Divider(
                color: Pallet.greyColor2,
              ),

              // We Listen Section
              _buildMenuSection(
                'We Listen',
                Icons.headset,
                context,
                () {},
              ),
              _buildSubMenuSection(
                'Feedback',
                Icons.feedback,
                context,
                () {},
              ),
              _buildSubMenuSection(
                'Rate Us',
                Icons.star_rate,
                context,
                () {},
              ),
              _buildSubMenuSection(
                'Share',
                Icons.share,
                context,
                () {},
              ),
              _buildSubMenuSection(
                'Set Alerts',
                Icons.notifications,
                context,
                () {},
              ),
              _buildSubMenuSection(
                'Settings',
                Icons.settings,
                context,
                () {},
              ),
              _buildSubMenuSection(
                'Login',
                Icons.login,
                context,
                () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuSection(String title, IconData icon, BuildContext context,
      void Function() onTap) {
    return ListTile(
      leading: Icon(
        icon,
        color: Pallet.primaryColor,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Pallet.primaryColor,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildSubMenuSection(String title, IconData icon, BuildContext context,
      void Function() onTap) {
    return ListTile(
      leading: Icon(
        icon,
        color: Pallet.primaryColor,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Pallet.primaryColor,
        ),
      ),
      onTap: onTap,
    );
  }
}
