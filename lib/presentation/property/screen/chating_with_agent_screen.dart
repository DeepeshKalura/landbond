import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_url.dart';
import '../../../core/pallet.dart';
import '../bloc/propterty_bloc.dart';
import 'widget/chat_bubble_widget.dart';
import 'widget/input_field_widget.dart';

class ChatingWithAgentScreen extends StatefulWidget {
  const ChatingWithAgentScreen({super.key, required this.producerId});
  final String producerId;

  @override
  State<ChatingWithAgentScreen> createState() => _ChatingWithAgentScreenState();
}

class _ChatingWithAgentScreenState extends State<ChatingWithAgentScreen> {
  final ScrollController listScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<PropertyBloc>().add(
          LoadConversationEvent(
            consumerId: context
                .read<PropertyBloc>()
                .propertiesRepoImpl
                .fs
                .auth
                .currentUser!
                .uid,
            producerId: widget.producerId,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PropertyBloc, PropertyState>(
      listener: (context, state) {
        if (state is AuthenticationErrorState) {
          showErrorSnackbar(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Chatting with Agent',
            style: GoogleFonts.quicksand(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Pallet.whiteColor,
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: context
                      .read<PropertyBloc>()
                      .propertiesRepoImpl
                      .getChatHistory(
                        producer: widget.producerId,
                        consumer: context
                            .read<PropertyBloc>()
                            .propertiesRepoImpl
                            .fs
                            .auth
                            .currentUser!
                            .uid,
                      ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.connectionState == ConnectionState.none ||
                        snapshot.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return ListView.builder(
                      reverse: true,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 24.0,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ChatBubbleWidget(message: snapshot.data![index]);
                      },
                    );
                  }),
            ),
            const InputFieldWidget(),
          ],
        ),
      ),
    );
  }

  void showErrorSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Error: Please create an account",
              style: GoogleFonts.quicksand(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8.0),
            GestureDetector(
              onTap: () {
                context.pushReplacementNamed(AppUrl.signInScreen);
              },
              child: Text(
                "Create an account",
                style: GoogleFonts.quicksand(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Pallet.primaryColor,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Pallet.whiteColor,
      ),
    );
  }
}
