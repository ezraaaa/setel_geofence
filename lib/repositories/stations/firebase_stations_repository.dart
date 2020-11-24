import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:setel_geofence/home/models/station/station.dart';
import 'package:setel_geofence/repositories/stations/stations_repository.dart';

class FirebaseStationsRepository extends StationsRepository {
  final CollectionReference _stationsRef =
      FirebaseFirestore.instance.collection('stations');

  @override
  Stream<List<Station>> getStations() {
    return _stationsRef
        .orderBy('name')
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs.map((DocumentSnapshot data) {
        final Map<String, dynamic> dataWithID =
            Map<String, dynamic>.from(data.data()
              ..addEntries(
                <MapEntry<String, dynamic>>[
                  MapEntry<String, dynamic>('id', data.id),
                ],
              ));
        return Station.fromJson(dataWithID);
      }).toList();
    });
  }

  @override
  Future<void> addStation(Map<String, dynamic> formData) {
    return _stationsRef.add(formData);
  }
}
