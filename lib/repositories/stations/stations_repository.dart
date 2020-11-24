import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:setel_geofence/home/models/station/station.dart';

abstract class StationsRepository {
  Stream<List<Station>> getStations();

  Future<DocumentReference> addStation(Map<String, dynamic> formData);
}
