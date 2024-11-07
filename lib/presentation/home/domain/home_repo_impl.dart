import 'dart:developer';

import '../../../service/firebase/authenticate_service.dart';
import '../data/model/property.dart';
import '../data/model/types.dart';

class HomeRepoImpl {
  final FirebaseService _fs;

  HomeRepoImpl(this._fs);

  Future<List<Property>> searchProperty(String search, DealType type) async {
    try {
      var value = await _fs.database
          .collection('properties')
          .where('dealType', isEqualTo: type.toString())
          .where('name', isGreaterThanOrEqualTo: search)
          .where('name', isLessThan: '$search\uf8ff')
          .get();

      List<Property> properties = value.docs.map((doc) {
        return Property.fromJson(doc.data());
      }).toList();

      return properties;
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      rethrow;
    }
  }

  getProperties() {}

  localitiesProperties() {}
}
