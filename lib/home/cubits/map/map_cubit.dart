import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());

  void initMapController(GoogleMapController googleMapController) {
    emit(MapControllerInitiated(googleMapController));
  }

  void animateToLocation(LatLng latLng) {
    final GoogleMapController controller =
        (state as MapControllerInitiated).googleMapController;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latLng,
          zoom: 18.0,
        ),
      ),
    );
  }
}
