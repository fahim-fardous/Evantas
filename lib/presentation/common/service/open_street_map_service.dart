import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class OpenStreetMapPlace {
  final String displayName;
  final double latitude;
  final double longitude;

  const OpenStreetMapPlace({
    required this.displayName,
    required this.latitude,
    required this.longitude,
  });

  LatLng get coordinates => LatLng(latitude, longitude);

  factory OpenStreetMapPlace.fromMap(Map<String, dynamic> json) {
    return OpenStreetMapPlace(
      displayName: (json['display_name'] as String?)?.trim() ?? '-',
      latitude: double.tryParse(json['lat']?.toString() ?? '') ?? 0,
      longitude: double.tryParse(json['lon']?.toString() ?? '') ?? 0,
    );
  }
}

class OpenStreetMapService {
  OpenStreetMapService() : _dio = Dio();

  final Dio _dio;

  Future<bool> ensureLocationPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return false;

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<LatLng?> getCurrentLocation() async {
    final hasPermission = await ensureLocationPermission();
    if (!hasPermission) return null;
    final position = await Geolocator.getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
  }

  Future<String> reverseGeocode(LatLng point) async {
    final placemarks = await placemarkFromCoordinates(
      point.latitude,
      point.longitude,
    );
    final place = placemarks.isNotEmpty ? placemarks.first : null;
    final resolved = <String?>[
      place?.name,
      place?.subLocality,
      place?.locality,
      place?.administrativeArea,
      place?.country,
    ].whereType<String>().where((part) => part.trim().isNotEmpty).join(', ');

    return resolved.isEmpty
        ? '${point.latitude.toStringAsFixed(5)}, ${point.longitude.toStringAsFixed(5)}'
        : resolved;
  }

  Future<List<OpenStreetMapPlace>> searchPlaces(
    String query, {
    int limit = 6,
  }) async {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) return <OpenStreetMapPlace>[];

    final response = await _dio.get<List<dynamic>>(
      'https://nominatim.openstreetmap.org/search',
      queryParameters: <String, dynamic>{
        'q': trimmedQuery,
        'format': 'jsonv2',
        'limit': limit,
        'addressdetails': 1,
      },
      options: Options(
        headers: <String, String>{
          'User-Agent': 'evntas-flutter-app/1.0',
        },
      ),
    );

    return (response.data ?? <dynamic>[])
        .whereType<Map<String, dynamic>>()
        .map(OpenStreetMapPlace.fromMap)
        .toList();
  }

  Future<OpenStreetMapPlace?> geocodeSingle(String query) async {
    final results = await searchPlaces(query, limit: 1);
    return results.isEmpty ? null : results.first;
  }

  void dispose() {
    _dio.close();
  }
}
