import 'package:evntas/presentation/base/base_ui_state.dart';
import 'package:evntas/presentation/common/extension/context_ext.dart';
import 'package:evntas/presentation/common/extension/event_type_ext.dart';
import 'package:evntas/presentation/common/service/open_street_map_service.dart';
import 'package:evntas/presentation/common/widget/primary_button.dart';
import 'package:evntas/presentation/feature/event_details/event_details_view_model.dart';
import 'package:evntas/presentation/theme/color/app_colors.dart';
import 'package:evntas/presentation/values/dimens.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class EventDetailsMobilePortrait extends StatefulWidget {
  final EventDetailsViewModel viewModel;
  final int eventId;

  const EventDetailsMobilePortrait({
    required this.viewModel,
    super.key,
    required this.eventId,
  });

  @override
  State<StatefulWidget> createState() => EventDetailsMobilePortraitState();
}

class EventDetailsMobilePortraitState
    extends BaseUiState<EventDetailsMobilePortrait> {
  static const LatLng _fallbackLocation = LatLng(23.0225, 72.5714);

  final OpenStreetMapService _openStreetMapService = OpenStreetMapService();
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();

  LatLng _selectedLocation = _fallbackLocation;
  String _selectedAddress = 'Fetching current address...';
  bool _isFetchingAddress = false;
  bool _isSearching = false;
  bool _isMapReady = false;
  bool _didResolveEventLocation = false;
  List<OpenStreetMapPlace> _searchResults = <OpenStreetMapPlace>[];
  LatLng? _pendingCenter;

  @override
  void initState() {
    super.initState();
    _setCurrentLocationAsDefault();
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

  Future<void> _resolveEventLocationIfNeeded(dynamic event) async {
    if (_didResolveEventLocation) return;
    final rawLocation = (event?.location ?? '').toString().trim();
    if (rawLocation.isEmpty) {
      _didResolveEventLocation = true;
      return;
    }
    _didResolveEventLocation = true;
    _searchController.text = rawLocation;
    try {
      final result = await _openStreetMapService.geocodeSingle(rawLocation);
      if (result != null) {
        await _selectSearchResult(result);
      }
    } catch (_) {}
  }

  DateTime _eventDateTime(dynamic event) {
    return DateTime(
      event.date.year,
      event.date.month,
      event.date.day,
      event.time.hour,
      event.time.minute,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.only(top: Dimens.dimen_10),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(Dimens.dimen_14),
              border: Border.all(
                color: colorScheme.outlineVariant.withOpacity(.4),
              ),
            ),
            child: IconButton(
              onPressed: () => widget.viewModel.onBackButtonPressed(),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.of(context).mainColor,
                size: Dimens.dimen_18,
              ),
            ),
          ),
          SizedBox(width: Dimens.dimen_12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Event Details',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColors.of(context).mainColor,
                        fontSize: 22,
                      ),
                ),
                SizedBox(height: Dimens.dimen_2),
                Text(
                  'Everything you need in one view',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.outline,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: Dimens.dimen_16,
          right: Dimens.dimen_16,
          bottom: Dimens.dimen_16,
        ),
        child: valueListenableBuilder(
          listenable: widget.viewModel.event,
          builder: (context, event) {
            _resolveEventLocationIfNeeded(event);
            return Column(
            children: [
              _buildAppBar(context),
              SizedBox(height: Dimens.dimen_16),
              Expanded(
                child: (event == null)
                    ? const SizedBox.shrink()
                    : ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          _buildHeroCard(context),
                          SizedBox(height: Dimens.dimen_16),
                          _buildHighlightsCard(context),
                          SizedBox(height: Dimens.dimen_16),
                          _buildDescriptionCard(context),
                          ValueListenableBuilder<List<String>>(
                            valueListenable: widget.viewModel.attendeeNames,
                            builder: (context, attendees, _) {
                              if (attendees.isEmpty) {
                                return const SizedBox.shrink();
                              }
                              return Column(
                                children: [
                                  SizedBox(height: Dimens.dimen_16),
                                  _buildAttendeesCard(context),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: Dimens.dimen_16),
                          _buildLocationCard(context),
                          SizedBox(height: Dimens.dimen_8),
                        ],
                      ),
              ),
              if (event != null) ...[
                SizedBox(height: Dimens.dimen_12),
                Container(
                  padding: EdgeInsets.fromLTRB(
                    Dimens.dimen_10,
                    Dimens.dimen_10,
                    Dimens.dimen_10,
                    Dimens.dimen_12,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(Dimens.dimen_16),
                    border: Border.all(
                      color: colorScheme.outlineVariant.withOpacity(.35),
                    ),
                  ),
                  child: _buildPrimaryButton(context),
                ),
              ],
            ],
          );
          },
        ),
      ),
    );
  }

  Widget _buildHeroCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return valueListenableBuilder(
      listenable: widget.viewModel.event,
      builder: (context, event) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(Dimens.dimen_18),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(Dimens.dimen_24),
            border: Border.all(
              color: colorScheme.outlineVariant.withOpacity(.35),
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withOpacity(.03),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimens.dimen_10,
                      vertical: Dimens.dimen_6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.of(context).mainColor.withOpacity(.10),
                      borderRadius: BorderRadius.circular(Dimens.dimen_20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          event?.eventType.getEventIcon(),
                          color: AppColors.of(context).mainColor,
                          size: Dimens.dimen_14,
                        ),
                        SizedBox(width: Dimens.dimen_6),
                        Text(
                          event?.eventType.getName().toUpperCase() ?? '',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: AppColors.of(context).mainColor,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.6,
                                fontSize: 11,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: Dimens.dimen_16),
              Text(
                event?.title ?? '',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                      fontSize: 24,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: Dimens.dimen_10),
              Text(
                'Plan, connect and make every moment count.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.outline,
                      height: 1.35,
                      fontSize: 14,
                    ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHighlightsCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return valueListenableBuilder(
      listenable: widget.viewModel.event,
      builder: (context, event) {
        final eventDate = event?.date ?? DateTime.now();
        final eventDateTime =
            event == null ? DateTime.now() : _eventDateTime(event);
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(Dimens.dimen_16),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(Dimens.dimen_20),
            border: Border.all(
              color: colorScheme.outlineVariant.withOpacity(.35),
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withOpacity(.03),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quick Highlights',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.of(context).mainColor,
                      fontSize: 15,
                    ),
              ),
              SizedBox(height: Dimens.dimen_4),
              Text(
                'Know the key timing details at a glance',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.outline,
                      fontSize: 12,
                    ),
              ),
              SizedBox(height: Dimens.dimen_12),
              Row(
                children: [
                  Expanded(
                    child: _buildHighlightItem(
                      context,
                      icon: Icons.today_rounded,
                      title: 'Day',
                      value: DateFormat('EEE').format(eventDate),
                    ),
                  ),
                  SizedBox(width: Dimens.dimen_10),
                  Expanded(
                    child: _buildHighlightItem(
                      context,
                      icon: Icons.calendar_month_rounded,
                      title: 'Date',
                      value: DateFormat('d MMM').format(eventDate),
                    ),
                  ),
                  SizedBox(width: Dimens.dimen_10),
                  Expanded(
                    child: _buildHighlightItem(
                      context,
                      icon: Icons.schedule_rounded,
                      title: 'Time',
                      value: DateFormat('hh:mm a').format(eventDateTime),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHighlightItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.dimen_10,
        vertical: Dimens.dimen_10,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(.26),
        borderRadius: BorderRadius.circular(Dimens.dimen_14),
        border: Border.all(
          color: colorScheme.outlineVariant.withOpacity(.22),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: Dimens.dimen_17, color: AppColors.of(context).mainColor),
          SizedBox(height: Dimens.dimen_8),
          Text(
            title,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: colorScheme.outline,
                  fontSize: 11,
                ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: Dimens.dimen_2),
          Text(
            value,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return valueListenableBuilder(
      listenable: widget.viewModel.event,
      builder: (context, event) => _buildSectionCard(
        context: context,
        title: 'About This Event',
        icon: Icons.description_outlined,
        child: Text(
          (event?.description ?? '').trim().isEmpty
              ? 'No description available for this event.'
              : event!.description!,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withOpacity(.78),
                height: 1.45,
                fontSize: 14,
              ),
        ),
      ),
    );
  }

  Widget _buildAttendeesCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return valueListenableBuilder(
      listenable: widget.viewModel.attendeeNames,
      builder: (context, attendees) {
        final attendeeNames = attendees;
        if (attendeeNames.isEmpty) {
          return const SizedBox.shrink();
        }
        final visibleCount = attendeeNames.length > 3 ? 3 : attendeeNames.length;
        final overflowCount =
            attendeeNames.length > 3 ? attendeeNames.length - 3 : 0;
        final stackWidth = (visibleCount * 24.0) + (overflowCount > 0 ? 40.0 : 16.0);

        return _buildSectionCard(
          context: context,
          title: 'Attendees',
          icon: Icons.people_outline_rounded,
          child: Row(
            children: [
              SizedBox(
                width: stackWidth,
                height: 44,
                child: Stack(
                  children: [
                    for (int i = 0; i < visibleCount; i++)
                      Positioned(
                        left: i * 24,
                        child: _buildAttendeeAvatar(
                          context,
                          _initials(attendeeNames[i]),
                        ),
                      ),
                    if (overflowCount > 0)
                      Positioned(
                        left: visibleCount * 24,
                        child: _buildAttendeeAvatar(context, '+$overflowCount'),
                      ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                '${attendeeNames.length} people are going',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface.withOpacity(.72),
                      fontSize: 15,
                    ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAttendeeAvatar(BuildContext context, String label) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 44,
      height: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.of(context).mainColor.withOpacity(.22),
        shape: BoxShape.circle,
        border: Border.all(
          color: colorScheme.outlineVariant.withOpacity(.45),
        ),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }

  String _initials(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '?';
    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }
    return (parts.first.substring(0, 1) + parts[1].substring(0, 1)).toUpperCase();
  }

  Widget _buildLocationCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return valueListenableBuilder(
      listenable: widget.viewModel.event,
      builder: (context, event) => _buildSectionCard(
        context: context,
        title: 'Location',
        icon: Icons.location_on_outlined,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _searchPlaces(),
              decoration: InputDecoration(
                hintText: 'Search place or address',
                isDense: true,
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest.withOpacity(.35),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimens.dimen_12),
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
            ),
            if (_searchResults.isNotEmpty) ...[
              SizedBox(height: Dimens.dimen_8),
              Container(
                constraints: const BoxConstraints(maxHeight: 180),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.dimen_12),
                  border: Border.all(
                    color: colorScheme.outlineVariant.withOpacity(.35),
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
              ),
            ],
            SizedBox(height: Dimens.dimen_10),
            SizedBox(
              height: 220,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.dimen_16),
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
            SizedBox(height: Dimens.dimen_10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.place_outlined,
                  size: Dimens.dimen_16,
                  color: AppColors.of(context).mainColor,
                ),
                SizedBox(width: Dimens.dimen_6),
                Expanded(
                  child: Text(
                    _isFetchingAddress ? 'Resolving address...' : _selectedAddress,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface.withOpacity(.82),
                          fontSize: 15,
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Dimens.dimen_16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(Dimens.dimen_20),
        border: Border.all(
          color: colorScheme.outlineVariant.withOpacity(.35),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(.03),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: AppColors.of(context).mainColor.withOpacity(.12),
                  borderRadius: BorderRadius.circular(Dimens.dimen_10),
                ),
                child: Icon(
                  icon,
                  size: Dimens.dimen_18,
                  color: AppColors.of(context).mainColor,
                ),
              ),
              SizedBox(width: Dimens.dimen_8),
              Text(
                title.toUpperCase(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.1,
                      color: AppColors.of(context).mainColor,
                      fontSize: 14,
                    ),
              ),
            ],
          ),
          SizedBox(height: Dimens.dimen_12),
          child,
        ],
      ),
    );
  }

  Widget _buildPrimaryButton(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.viewModel.isJoined,
      builder: (context, isJoined, _) => Opacity(
        opacity: isJoined ? .55 : 1,
        child: IgnorePointer(
          ignoring: isJoined,
          child: PrimaryButton(
            label: context.localizations.join_the_event,
            onPressed: () => widget.viewModel.onJoinButtonClicked(widget.eventId),
            minWidth: double.infinity,
            buttonColor: AppColors.of(context).mainColor,
          ),
        ),
      ),
    );
  }
}
