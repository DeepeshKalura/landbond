import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import "package:landbond/locator/injector.dart" as di;

import '../../../service/firebase/authenticate_service.dart';
import '../data/model/message.dart';
import '../domain/repository/properties_repo_impl.dart';

@immutable
sealed class PropertyEvent {}

@immutable
sealed class PropertyState {}

// contact Agent Event

final class ContactAgentEvent extends PropertyEvent {}

final class ContactAgentSuccessState extends PropertyState {}

final class InitialPropteryState extends PropertyState {}

//  send event

final class SendMessageEvent extends PropertyEvent {
  final String message;

  SendMessageEvent({
    required this.message,
  });
}

// Load message Event

final class LoadConversationEvent extends PropertyEvent {
  final String producerId;
  final String consumerId;

  LoadConversationEvent({
    required this.producerId,
    required this.consumerId,
  });
}

// state
final class LoadingConversationState extends PropertyState {}

final class AuthenticationErrorState extends PropertyState {}

final class LoadingConversationErrorState extends PropertyState {
  final String errorMessage;

  LoadingConversationErrorState({
    required this.errorMessage,
  });
}

final class ChatMessageSentState extends PropertyState {}

class PropertyBloc extends Bloc<PropertyEvent, PropertyState> {
  String producerId = '';
  String consumerid = '';

  List<Message> messages = [];

  final propertiesRepoImpl = PropertiesRepoImpl(
    fs: di.injector.get<FirebaseService>(),
  );
  Stream<Message>? messageStream;

  PropertyBloc() : super(InitialPropteryState()) {
    on<ContactAgentEvent>(_contectAgent);

    on<SendMessageEvent>(_sendMessage);
    on<LoadConversationEvent>(_loadConversation);
  }

  void _loadConversation(
      LoadConversationEvent event, Emitter<PropertyState> emit) async {
    try {
      if (propertiesRepoImpl.fs.auth.currentUser == null) {
        emit(AuthenticationErrorState());
      } else {
        messages += await propertiesRepoImpl.loadMessages(
          propertiesRepoImpl.fs.auth.currentUser!.uid,
          event.producerId,
        );
        producerId = event.producerId;
      }

      emit(ChatMessageSentState());
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      emit(LoadingConversationErrorState(errorMessage: e.toString()));
    }
  }

  void _contectAgent(ContactAgentEvent event, Emitter<PropertyState> emit) {
    emit(ContactAgentSuccessState());
  }

  void _sendMessage(SendMessageEvent event, Emitter<PropertyState> emit) async {
    try {
      final message = Message(
        senderId: propertiesRepoImpl.fs.auth.currentUser!.uid,
        receiverId: producerId,
        text: event.message,
        timestamp: DateTime.now(),
        isAgent: false,
      );
      await propertiesRepoImpl.storeMessage(message);
      emit(ChatMessageSentState());
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
    }
  }
}
