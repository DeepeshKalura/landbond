import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/pallet.dart';
import '../bloc/home_bloc.dart';
import 'widget/list_property_card_widget.dart';

class PropertyScreen extends StatelessWidget {
  const PropertyScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {},
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Your search ${context.read<HomeBloc>().search}",
            style: GoogleFonts.quicksand(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Pallet.backgroundColor,
            ),
          ),
        ),
        body: context.read<HomeBloc>().searchProperty == null ||
                context.read<HomeBloc>().searchProperty!.isEmpty
            ? Center(
                child: Text(
                  "No property found",
                  style: GoogleFonts.quicksand(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Pallet.backgroundColor,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: context.read<HomeBloc>().searchProperty!.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  return ListPropertyCardWidget(
                    property: context.read<HomeBloc>().searchProperty![index],
                  );
                },
              ),
      ),
    );
  }
}
