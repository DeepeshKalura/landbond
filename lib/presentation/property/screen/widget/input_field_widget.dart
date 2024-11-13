import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/pallet.dart';
import '../../bloc/propterty_bloc.dart';

class InputFieldWidget extends StatefulWidget {
  const InputFieldWidget({super.key, required this.propteryId});
  final String propteryId;

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Type your message',
                hintStyle: const TextStyle(
                  color: Pallet.greyColor2,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
                filled: true,
                fillColor: Pallet.greyContainerColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          ElevatedButton(
            onPressed: () {
              final message = _textController.text.trim();
              if (message.isNotEmpty) {
                context.read<PropertyBloc>().add(
                      SendMessageEvent(
                        message: message,
                        propteryId: widget.propteryId,
                      ),
                    );
                _textController.clear();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Pallet.primaryColor,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(16.0),
            ),
            child: const Icon(
              Icons.send,
              color: Pallet.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
