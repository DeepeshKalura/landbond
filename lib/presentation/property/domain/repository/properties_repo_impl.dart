import 'dart:developer';

import '../../../../service/firebase/authenticate_service.dart';
import '../../data/model/message.dart';

class PropertiesRepoImpl {
  final FirebaseService fs;

  PropertiesRepoImpl({
    required this.fs,
  });

  Future<void> storeMessage(Message message) async {
    try {
      await fs.database.collection('messages').add(message.toJson());
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      rethrow;
    }
  }

  Future<List<Message>> loadMessages(String userId1, String userId2) async {
    final querySnapshot = await fs.database
        .collection('messages')
        .where('senderId', whereIn: [userId1, userId2])
        .where('receiverId', whereIn: [userId1, userId2])
        .orderBy('timestamp', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => Message.fromJson(doc.data()))
        .toList();
  }

  Stream<List<Message>> getChatHistory({
    required String consumer,
    required String producer,
  }) {
    return fs.database
        .collection('messages')
        .where('senderId', isEqualTo: consumer)
        .where('receiverId', isEqualTo: producer)
        .orderBy('timestamp', descending: true)
        .limit(10)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Message.fromJson(doc.data())).toList(),
        );
  }
}
