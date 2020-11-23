import 'package:setel_geofence/home/models/station/station.dart';

abstract class GeofencesRepository {
  Stream<List<Station>> getStations();
}
