import 'package:setel_geofence/home/models/station/station.dart';

abstract class StationsRepository {
  Stream<List<Station>> getStations();

  Future<void> addStation(Map<String, dynamic> formData);
}
