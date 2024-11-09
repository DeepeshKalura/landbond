import 'dart:developer';

import '../../../service/firebase/authenticate_service.dart';
import '../data/model/cities.dart';
import '../data/model/locality.dart';
import '../data/model/property.dart';
import '../data/model/types.dart';

class HomeRepoImpl {
  final FirebaseService fs;

  HomeRepoImpl(this.fs);

  Future<List<Property>> searchProperty(String search, DealType type) async {
    try {
      var value = await fs.database
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

  Future<List<Property>> getProperties() async {
    try {
      return fs.database.collection('properties').get().then((value) {
        List<Property> properties = value.docs.map((doc) {
          return Property.fromJson(doc.data());
        }).toList();

        return properties;
      });
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      rethrow;
    }
  }

  Future<List<Locality>> getLocalitie() async {
    try {
      return fs.database.collection("localities").get().then((value) {
        List<Locality> localities = value.docs.map((doc) {
          return Locality.fromJson(doc.data());
        }).toList();

        log("locality$localities");
        return localities;
      });
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      rethrow;
    }
  }

  Future<List<Cities>> getCities() async {
    try {
      return fs.database.collection("cities").get().then((value) {
        List<Cities> cities = value.docs.map((doc) {
          return Cities.fromJson(doc.data());
        }).toList();

        log("cities $cities");

        return cities;
      });
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      rethrow;
    }
  }
}
