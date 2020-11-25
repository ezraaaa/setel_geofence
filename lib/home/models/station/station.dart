import 'package:json_annotation/json_annotation.dart';

part 'station.g.dart';

@JsonSerializable()
class Station {
  const Station({
    this.id,
    this.name,
    this.latitude,
    this.longitude,
    this.radius,
    this.numberOfPumps,
    this.ssid,
  });

  factory Station.fromJson(Map<String, dynamic> json) =>
      _$StationFromJson(json);
  Map<String, dynamic> toJson() => _$StationToJson(this);

  final String id;
  final String name;
  final num latitude;
  final num longitude;
  final num radius;
  final num numberOfPumps;
  final String ssid;
}
