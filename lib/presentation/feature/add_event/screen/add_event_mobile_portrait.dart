import 'dart:async';

import 'package:evntas/presentation/base/base_ui_state.dart';
import 'package:evntas/presentation/common/service/open_street_map_service.dart';
import 'package:evntas/presentation/feature/add_event/add_event_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AddEventMobilePortrait extends StatefulWidget {
  final AddEventViewModel viewModel;

  const AddEventMobilePortrait({required this.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => AddEventMobilePortraitState();
}

class AddEventMobilePortraitState extends BaseUiState<AddEventMobilePortrait> {
  static const LatLng _fallbackLocation = LatLng(23.0225, 72.5714);

  final OpenStreetMapService _openStreetMapService = OpenStreetMapService();
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();

  LatLng _selectedLocation = _fallbackLocation;
  String _selectedAddress = 'Fetching current address...';
  List<OpenStreetMapPlace> _searchResults = <OpenStreetMapPlace>[];
  bool _isFetchingAddress = false;
  bool _isSearching = false;
  bool _isMapReady = false;
  LatLng? _pendingCenter;

  @override
  void initState() {
    super.initState();
    unawaited(_setCurrentLocationAsDefault());
  }

  @override
  void dispose() {
    _searchController.dispose();
    _openStreetMapService.dispose();
    super.dispose();
  }

  Future<void> _setCurrentLocationAsDefault() async {
    try {
      final current = await _openStreetMapService.getCurrentLocation();
      if (!mounted) return;
      if (current == null) {
        setState(() {
          _selectedAddress = 'Location permission denied. Tap map to pick location.';
        });
        return;
      }
      setState(() {
        _selectedLocation = current;
      });
      _moveMap(current);
      await _reverseGeocode(current);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _selectedAddress = 'Unable to fetch current location. Tap map to pick location.';
      });
    }
  }

  void _moveMap(LatLng target) {
    if (!_isMapReady) {
      _pendingCenter = target;
      return;
    }
    _pendingCenter = null;
    _mapController.move(target, 15);
  }

  Future<void> _reverseGeocode(LatLng point) async {
    if (!mounted) return;
    setState(() {
      _isFetchingAddress = true;
    });

    try {
      final resolved = await _openStreetMapService.reverseGeocode(point);
      if (!mounted) return;
      setState(() {
        _selectedAddress = resolved;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _selectedAddress =
            '${point.latitude.toStringAsFixed(5)}, ${point.longitude.toStringAsFixed(5)}';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isFetchingAddress = false;
        });
      }
    }
  }

  Future<void> _searchPlaces() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    if (!mounted) return;
    setState(() {
      _isSearching = true;
      _searchResults = <OpenStreetMapPlace>[];
    });

    try {
      final results = await _openStreetMapService.searchPlaces(query, limit: 6);
      if (!mounted) return;
      setState(() {
        _searchResults = results;
      });
      if (results.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No result found')),
        );
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _searchResults = <OpenStreetMapPlace>[];
      });
    } finally {
      if (mounted) {
        setState(() {
          _isSearching = false;
        });
      }
    }
  }

  Future<void> _selectSearchResult(OpenStreetMapPlace result) async {
    final target = result.coordinates;
    if (!mounted) return;
    setState(() {
      _selectedLocation = target;
      _selectedAddress = result.displayName;
      _searchResults = <OpenStreetMapPlace>[];
      _searchController.text = result.displayName;
    });
    _moveMap(target);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: valueListenableBuilder(
          listenable: widget.viewModel.message,
          builder: (context, value) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(.08),
                    Theme.of(context).colorScheme.background,
                    Theme.of(context).colorScheme.secondary.withOpacity(.06),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),
                    const SizedBox(height: 24),
                    _buildPreviewCard(context, value),
                    const Spacer(),
                    _buildPrimaryButton(context),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create Event',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          'Set up your next event in seconds',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
        ),
      ],
    );
  }

  Widget _buildPreviewCard(BuildContext context, dynamic value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant.withOpacity(.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Event Status',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'AddEvent: $value',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 14),
          _buildSearchField(context),
          if (_searchResults.isNotEmpty) ...[
            const SizedBox(height: 8),
            _buildSearchResults(context),
          ],
          const SizedBox(height: 12),
          SizedBox(
            height: 240,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: _selectedLocation,
                  initialZoom: 14,
                  onMapReady: () {
                    _isMapReady = true;
                    _moveMap(_pendingCenter ?? _selectedLocation);
                  },
                  onTap: (_, latLng) async {
                    setState(() {
                      _selectedLocation = latLng;
                    });
                    await _reverseGeocode(latLng);
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.evntas.app',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: _selectedLocation,
                        width: 42,
                        height: 42,
                        child: const Icon(
                          Icons.location_pin,
                          color: Colors.redAccent,
                          size: 42,
                        ),
                      ),
                    ],
                  ),
                  const RichAttributionWidget(
                    attributions: [
                      TextSourceAttribution('OpenStreetMap contributors'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.place_outlined,
                size: 18,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _isFetchingAddress ? 'Resolving address...' : _selectedAddress,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return TextField(
      controller: _searchController,
      textInputAction: TextInputAction.search,
      onSubmitted: (_) => _searchPlaces(),
      decoration: InputDecoration(
        hintText: 'Search place or address',
        isDense: true,
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(.35),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          onPressed: _isSearching ? null : _searchPlaces,
          icon: _isSearching
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.search_rounded),
        ),
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 180),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant.withOpacity(.35),
        ),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final result = _searchResults[index];
          return ListTile(
            dense: true,
            leading: const Icon(Icons.location_on_outlined),
            title: Text(
              result.displayName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () => _selectSearchResult(result),
          );
        },
      ),
    );
  }

  Widget _buildPrimaryButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => widget.viewModel.onClick(),
        icon: const Icon(Icons.add_circle_outline_rounded),
        label: const Text('Continue'),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}
