// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Station _$StationFromJson(Map<String, dynamic> json) {
  return Station(
    id: json['id'] as String,
    name: json['name'] as String,
    latitude: json['latitude'] as num,
    longitude: json['longitude'] as num,
    radius: json['radius'] as num,
    numberOfPumps: json['numberOfPumps'] as num,
    ssid: json['ssid'] as String,
  );
}

Map<String, dynamic> _$StationToJson(Station instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'radius': instance.radius,
      'numberOfPumps': instance.numberOfPumps,
      'ssid': instance.ssid,
    };
