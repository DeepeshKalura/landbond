import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/pallet.dart';
import '../../bloc/home_bloc.dart';
import '../../data/model/cities.dart';
import '../../data/model/types.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key, this.cities});

  final Cities? cities;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final searchEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isBuy = false;
  bool isRent = false;
  bool isPlot = false;
  bool isloading = false;

  void _handleSearch() {
    final value = searchEditingController.text.trim();
    DealType dealType = DealType.sale;

    if (isRent) {
      dealType = DealType.rent;
    } else if (isPlot) {
      dealType = DealType.plot;
    }
    if (value.isNotEmpty) {
      context.read<HomeBloc>().add(
            SearchEvent(
              search: value,
              type: dealType,
            ),
          );
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(BuyEvent());
  }

  @override
  void dispose() {
    searchEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is SearchErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Pallet.red,
            ),
          );
        }
      },
      child: SizedBox(
        height: 270,
        width: double.infinity,
        child: Stack(
          children: [
            SizedBox(
              height: 270,
              width: double.infinity,
              child: Image.asset(
                'assets/images/home/hero.png',
                fit: BoxFit.fitWidth,
                color: const Color(0xAA000000),
                colorBlendMode: BlendMode.darken,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Explore ",
                          style: GoogleFonts.quicksand(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Property in ${widget.cities?.name ?? "India"}",
                          style: GoogleFonts.quicksand(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        isBuy = context.read<HomeBloc>().isBuy;
                        isRent = context.read<HomeBloc>().isRent;
                        isPlot = context.read<HomeBloc>().isPlot;
                        return Row(
                          children: [
                            buildTypeButton(
                              "Buy",
                              Icons.monetization_on_outlined,
                              onPressed: () {
                                if (isBuy) return;
                                context.read<HomeBloc>().add(BuyEvent());
                              },
                              isActive: isBuy,
                            ),
                            buildTypeButton(
                              "Plot",
                              Icons.landscape_outlined,
                              onPressed: () {
                                if (isPlot) return;
                                context.read<HomeBloc>().add(PlotEvent());
                              },
                              isActive: isPlot,
                            ),
                            buildTypeButton(
                              "Rent",
                              Icons.person_2_outlined,
                              onPressed: () {
                                if (isRent) return;
                                context.read<HomeBloc>().add(RentEvent());
                              },
                              isActive: isRent,
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 65,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          isloading = state is SearchLoadingState;
                          return isloading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Form(
                                  key: _formKey,
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.search_sharp,
                                        color: Pallet.primaryColor,
                                        size: 30,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: TextFormField(
                                          style: GoogleFonts.quicksand(
                                            fontSize: 18,
                                          ),
                                          controller: searchEditingController,
                                          decoration: InputDecoration(
                                            hintText:
                                                'Select locality for ${isPlot ? "plot" : isRent ? "rent" : "buy"}',
                                            hintStyle: GoogleFonts.quicksand(
                                              color: Pallet.greyColor3,
                                              fontSize: 18,
                                            ),
                                            border: InputBorder.none,
                                          ),
                                          onFieldSubmitted: (_) =>
                                              _handleSearch(),
                                          textInputAction:
                                              TextInputAction.search,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.filter_list_alt,
                                          color: Pallet.primaryColor,
                                          size: 30,
                                        ),
                                        onPressed: _handleSearch,
                                      ),
                                    ],
                                  ),
                                );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTypeButton(
    String title,
    IconData iconData, {
    required void Function()? onPressed,
    bool isActive = false,
  }) {
    final Color backgroundColor = isActive ? Pallet.primaryColor : Colors.white;
    final Color textColor = isActive ? Colors.white : Pallet.primaryColor;
    final Color iconColor = isActive ? Colors.white : Pallet.primaryColor;

    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 47,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Pallet.primaryColor,
            width: 1,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                iconData,
                color: iconColor,
              ),
              const SizedBox(width: 7),
              Text(
                title,
                style: GoogleFonts.quicksand(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
