import 'package:flutter/material.dart';

import '../../../../core/pallet.dart';
import '../../data/model/message.dart';

class ChatBubbleWidget extends StatelessWidget {
  final Message message;

  const ChatBubbleWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isAgent ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Pallet.primaryColor,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                message.text,
                style: const TextStyle(
                  color: Pallet.whiteColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
