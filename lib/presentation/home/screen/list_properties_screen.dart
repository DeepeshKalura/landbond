import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';
import 'widget/list_property_card_widget.dart';

class ListPropertiesScreen extends StatelessWidget {
  const ListPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {},
      child: Scaffold(
        appBar: AppBar(
          title: const Text("List of Properties"),
        ),
        body: ListView.builder(
          itemCount: context.read<HomeBloc>().popularProperty!.length,
          itemBuilder: (context, index) {
            return ListPropertyCardWidget(
              property: context.read<HomeBloc>().popularProperty![index],
            );
          },
        ),
      ),
    );
  }
}
