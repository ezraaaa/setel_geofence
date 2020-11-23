import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:setel_geofence/home/models/station/station.dart';
import 'package:setel_geofence/repositories/geofences/geofences_repository.dart';

class FirebaseGeofencesRepository extends GeofencesRepository {
  final CollectionReference _geofencesRef =
      FirebaseFirestore.instance.collection('geofences');

  @override
  Stream<List<Station>> getStations() {
    return _geofencesRef.snapshots().map((QuerySnapshot snapshot) {
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
}
