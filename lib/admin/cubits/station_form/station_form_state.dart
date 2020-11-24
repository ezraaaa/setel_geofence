part of 'station_form_cubit.dart';

class StationFormState extends Equatable {
  const StationFormState({
    this.name = const Name.pure(),
    this.latitude = const Latitude.pure(),
    this.longitude = const Longitude.pure(),
    this.radius = const Radius.pure(),
    this.ssid = const SSID.pure(),
    this.status = FormzStatus.pure,
  });

  final Name name;
  final Latitude latitude;
  final Longitude longitude;
  final Radius radius;
  final SSID ssid;
  final FormzStatus status;

  @override
  List<Object> get props =>
      <dynamic>[name, latitude, longitude, radius, ssid, status];

  StationFormState copyWith({
    Name name,
    Latitude latitude,
    Longitude longitude,
    Radius radius,
    SSID ssid,
    FormzStatus status,
  }) {
    return StationFormState(
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      radius: radius ?? this.radius,
      ssid: ssid ?? this.ssid,
      status: status ?? this.status,
    );
  }
}
