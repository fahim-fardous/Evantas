import 'package:domain/model/event_type.dart';
import 'package:flutter/material.dart';
import 'package:evntas/presentation/base/base_ui_state.dart';
import 'package:evntas/presentation/common/service/open_street_map_service.dart';
import 'package:evntas/presentation/common/extension/context_ext.dart';
import 'package:evntas/presentation/common/extension/event_type_ext.dart';
import 'package:evntas/presentation/common/widget/primary_button.dart';
import 'package:evntas/presentation/feature/add_reminder/add_reminder_view_model.dart';
import 'package:evntas/presentation/values/dimens.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AddReminderMobilePortrait extends StatefulWidget {
  final AddReminderViewModel viewModel;

  const AddReminderMobilePortrait({required this.viewModel, super.key});

  @override
  State<StatefulWidget> createState() => AddReminderMobilePortraitState();
}

class AddReminderMobilePortraitState
    extends BaseUiState<AddReminderMobilePortrait> {
  static const LatLng _fallbackLocation = LatLng(23.0225, 72.5714);
  static const _eventTypes = [
    EventType.dinner,
    EventType.development,
    EventType.birthday,
    EventType.special,
  ];
  final FocusNode _dateFocusNode = FocusNode();
  final FocusNode _timeFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  final OpenStreetMapService _openStreetMapService = OpenStreetMapService();
  final MapController _mapController = MapController();

  LatLng _selectedLocation = _fallbackLocation;
  String _selectedAddress = 'Fetching current address...';
  bool _isFetchingAddress = false;
  bool _isSearching = false;
  bool _isMapReady = false;
  LatLng? _pendingCenter;
  List<OpenStreetMapPlace> _searchResults = <OpenStreetMapPlace>[];

  bool _isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  Color _accentColor(BuildContext context) => _isDark(context)
      ? const Color(0xFF57E7B2)
      : Theme.of(context).colorScheme.primary;

  Color _fieldBg(BuildContext context) => _isDark(context)
      ? const Color(0xFF111A2D)
      : Theme.of(context).colorScheme.surface;

  Color _fieldBorderColor(BuildContext context) => _isDark(context)
      ? const Color(0xFF283451)
      : Theme.of(context).colorScheme.outlineVariant;

  Color _hintColor(BuildContext context) => _isDark(context)
      ? const Color(0xFF838DB0)
      : Theme.of(context).colorScheme.outline;

  Future<void> _initializeLocation() async {
    final existingLocation = widget.viewModel.locationController.text.trim();
    if (existingLocation.isNotEmpty) {
      _searchController.text = existingLocation;
      final existingPlace = await _openStreetMapService.geocodeSingle(existingLocation);
      if (existingPlace != null && mounted) {
        await _selectSearchResult(existingPlace, syncController: false);
        return;
      }
    }

    try {
      final current = await _openStreetMapService.getCurrentLocation();
      if (!mounted) return;
      if (current == null) {
        setState(() {
          _selectedAddress = 'Location permission denied. Tap map to pick location.';
        });
        return;
      }
      setState(() => _selectedLocation = current);
      _moveMap(current);
      await _reverseGeocode(current, syncController: true);
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

  Future<void> _reverseGeocode(
    LatLng point, {
    required bool syncController,
  }) async {
    if (!mounted) return;
    setState(() => _isFetchingAddress = true);
    try {
      final resolved = await _openStreetMapService.reverseGeocode(point);
      if (!mounted) return;
      setState(() => _selectedAddress = resolved);
      if (syncController) {
        widget.viewModel.locationController.text = resolved;
        _searchController.text = resolved;
      }
    } catch (_) {
      if (!mounted) return;
      final fallback =
          '${point.latitude.toStringAsFixed(5)}, ${point.longitude.toStringAsFixed(5)}';
      setState(() => _selectedAddress = fallback);
      if (syncController) {
        widget.viewModel.locationController.text = fallback;
        _searchController.text = fallback;
      }
    } finally {
      if (mounted) {
        setState(() => _isFetchingAddress = false);
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
      setState(() => _searchResults = results);
      if (results.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No result found')),
        );
      }
    } catch (_) {
      if (!mounted) return;
      setState(() => _searchResults = <OpenStreetMapPlace>[]);
    } finally {
      if (mounted) {
        setState(() => _isSearching = false);
      }
    }
  }

  Future<void> _selectSearchResult(
    OpenStreetMapPlace result, {
    bool syncController = true,
  }) async {
    final target = result.coordinates;
    if (!mounted) return;
    setState(() {
      _selectedLocation = target;
      _selectedAddress = result.displayName;
      _searchResults = <OpenStreetMapPlace>[];
      _searchController.text = result.displayName;
    });
    if (syncController) {
      widget.viewModel.locationController.text = result.displayName;
    }
    _moveMap(target);
  }

  Future<void> _openMapPicker() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (context, modalSetState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * .85,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  Dimens.dimen_16,
                  Dimens.dimen_12,
                  Dimens.dimen_16,
                  Dimens.dimen_16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Select location',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close_rounded),
                        ),
                      ],
                    ),
                    TextField(
                      controller: _searchController,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (_) async {
                        await _searchPlaces();
                        modalSetState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: 'Search place or address',
                        filled: true,
                        fillColor: _fieldBg(context),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimens.dimen_14),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          onPressed: _isSearching
                              ? null
                              : () async {
                                  await _searchPlaces();
                                  modalSetState(() {});
                                },
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
                        constraints: const BoxConstraints(maxHeight: 160),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimens.dimen_12),
                          border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .outlineVariant
                                .withOpacity(.35),
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
                              onTap: () async {
                                await _selectSearchResult(result);
                                modalSetState(() {});
                              },
                            );
                          },
                        ),
                      ),
                    ],
                    SizedBox(height: Dimens.dimen_10),
                    Expanded(
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
                              setState(() => _selectedLocation = latLng);
                              await _reverseGeocode(latLng, syncController: true);
                              modalSetState(() {});
                            },
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
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
                    SizedBox(height: Dimens.dimen_8),
                    Text(
                      _isFetchingAddress ? 'Resolving address...' : _selectedAddress,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  @override
  void dispose() {
    _dateFocusNode.dispose();
    _timeFocusNode.dispose();
    _searchController.dispose();
    _openStreetMapService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = _isDark(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? const [
                      Color(0xFF050913),
                      Color(0xFF0A1326),
                      Color(0xFF070D1A),
                    ]
                  : [
                      Theme.of(context).colorScheme.surfaceContainerLowest,
                      Theme.of(context).colorScheme.surfaceContainerLowest,
                      Theme.of(context).colorScheme.background,
                    ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: Dimens.dimen_16),
            child: Column(
              children: [
                _buildAppBar(context),
                SizedBox(height: Dimens.dimen_18),
                _buildBody(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final isDark = _isDark(context);
    return ValueListenableBuilder<bool>(
      valueListenable: widget.viewModel.isEditMode,
      builder: (context, isEditMode, _) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.dimen_16,
          vertical: Dimens.dimen_8,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isDark
                    ? Theme.of(context).colorScheme.surface.withOpacity(.42)
                    : Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(Dimens.dimen_14),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant.withOpacity(
                        isDark ? .3 : .5,
                      ),
                ),
              ),
              child: IconButton(
                onPressed: () => widget.viewModel.onBackButtonPressed(),
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Theme.of(context).colorScheme.onSurface,
                  size: Dimens.dimen_20,
                ),
              ),
            ),
            SizedBox(width: Dimens.dimen_10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isEditMode ? 'Edit Event' : 'Add Reminder',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w800,
                          letterSpacing: .3,
                          fontSize: Dimens.dimen_22,
                        ),
                  ),
                  Text(
                    isEditMode
                        ? 'Update your event details'
                        : 'Fill in the details below',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: _hintColor(context),
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimens.dimen_12),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: _hintColor(context),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.1,
                  fontSize: Dimens.dimen_12,
                ),
          ),
          SizedBox(width: Dimens.dimen_10),
          Expanded(
            child: Divider(
              height: 1,
              color: Theme.of(context).colorScheme.outlineVariant.withOpacity(.35),
              thickness: .8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldGroup(BuildContext context, List<Widget> children) {
    final isDark = _isDark(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Dimens.dimen_8),
      decoration: BoxDecoration(
        color: isDark
            ? Theme.of(context).colorScheme.surface.withOpacity(.2)
            : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(Dimens.dimen_20),
        border: Border.all(
          color: _fieldBorderColor(context).withOpacity(isDark ? .65 : .5),
        ),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _verticalSpacing() => SizedBox(height: Dimens.dimen_12);

  Widget _buildDateTimeRow(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _buildDateField(context)),
        SizedBox(width: Dimens.dimen_12),
        Expanded(child: _buildTimeField(context)),
      ],
    );
  }

  Widget _buildEventTypeSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'EVENT TYPE'),
        _buildEventTypeChips(context),
      ],
    );
  }

  Widget _buildDetailSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'DETAILS'),
        _buildFieldGroup(
          context,
          [
            _buildEventTitleField(context),
            _verticalSpacing(),
            _buildEventDescriptionField(context),
            _verticalSpacing(),
            _buildDateTimeRow(context),
            _verticalSpacing(),
            _buildLocationField(context),
          ],
        ),
      ],
    );
  }

  Widget _buildActionSection(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Dimens.dimen_10),
        _buildSaveButton(context),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.dimen_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildEventTypeSection(context),
          SizedBox(height: Dimens.dimen_16),
          _buildDetailSection(context),
          SizedBox(height: Dimens.dimen_18),
          _buildActionSection(context),
          SizedBox(height: Dimens.dimen_24),
        ],
      ),
    );
  }

  Widget _buildEventTypeChips(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.viewModel.isEditable,
      builder: (context, isEditable, _) => ValueListenableBuilder<EventType?>(
        valueListenable: widget.viewModel.eventType,
        builder: (context, selectedType, _) {
          return Wrap(
            spacing: Dimens.dimen_10,
            runSpacing: Dimens.dimen_10,
            children: _eventTypes
                .map(
                  (eventType) => _buildEventTypeChip(
                    context,
                    eventType,
                    selectedType == eventType,
                    isEditable,
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }

  Widget _buildEventTypeChip(
    BuildContext context,
    EventType eventType,
    bool isSelected,
    bool isEditable,
  ) {
    final accent = _accentColor(context);
    final textColor = isSelected
        ? accent
        : Theme.of(context).colorScheme.onSurface.withOpacity(.82);
    final borderColor = isSelected ? accent : _fieldBorderColor(context);
    return InkWell(
      onTap: isEditable ? () => widget.viewModel.onEventTypeSelected(eventType) : null,
      borderRadius: BorderRadius.circular(Dimens.dimen_22),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.dimen_16,
          vertical: Dimens.dimen_10,
        ),
        decoration: BoxDecoration(
          color: _fieldBg(context),
          borderRadius: BorderRadius.circular(Dimens.dimen_22),
          border: Border.all(
            color: borderColor,
            width: isSelected ? Dimens.dimen_2 : Dimens.dimen_1,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: accent.withOpacity(.2),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(eventType.getEventIcon(), size: Dimens.dimen_18, color: textColor),
            SizedBox(width: Dimens.dimen_8),
            Text(
              eventType.getName(),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w700,
                    fontSize: Dimens.dimen_15,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventTitleField(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.viewModel.isEditable,
      builder: (context, isEditable, _) => _buildInputField(
        context: context,
        controller: widget.viewModel.titleController,
        hintText: context.localizations.event_title_hint_text,
        textInputAction: TextInputAction.next,
        enabled: isEditable,
      ),
    );
  }

  Widget _buildEventDescriptionField(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.viewModel.isEditable,
      builder: (context, isEditable, _) => _buildInputField(
        context: context,
        controller: widget.viewModel.descriptionController,
        hintText: context.localizations.event_description_hint_text,
        minLines: 4,
        maxLines: 4,
        textInputAction: TextInputAction.newline,
        enabled: isEditable,
      ),
    );
  }

  Widget _buildDateField(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.viewModel.isEditable,
      builder: (context, isEditable, _) => _buildInputField(
        context: context,
        controller: widget.viewModel.dateController,
        labelText: context.localizations.event_date_label.toUpperCase(),
        hintText: 'dd/mm/yyyy',
        readOnly: true,
        suffixIcon: Icons.calendar_month_rounded,
        focusNode: _dateFocusNode,
        highlightSuffixOnActive: true,
        enabled: isEditable,
        onTap: isEditable
            ? () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (selectedDate != null) {
                  widget.viewModel.onDateSelected(selectedDate);
                }
              }
            : null,
      ),
    );
  }

  Widget _buildTimeField(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.viewModel.isEditable,
      builder: (context, isEditable, _) => _buildInputField(
        context: context,
        controller: widget.viewModel.timeController,
        labelText: context.localizations.event_time_label.toUpperCase(),
        hintText: 'Select time',
        readOnly: true,
        suffixIcon: Icons.access_time_rounded,
        focusNode: _timeFocusNode,
        highlightSuffixOnActive: true,
        enabled: isEditable,
        onTap: isEditable
            ? () async {
                final selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (selectedTime != null) {
                  widget.viewModel.onTimeSelected(selectedTime);
                }
              }
            : null,
      ),
    );
  }

  Widget _buildLocationField(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.viewModel.isEditable,
      builder: (context, isEditable, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInputField(
            context: context,
            controller: widget.viewModel.locationController,
            hintText: context.localizations.event_location_hint_text,
            suffixIcon: Icons.location_on_outlined,
            readOnly: true,
            enabled: isEditable,
            onTap: isEditable ? _openMapPicker : null,
          ),
          SizedBox(height: Dimens.dimen_8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.place_outlined,
                size: Dimens.dimen_16,
                color: _accentColor(context),
              ),
              SizedBox(width: Dimens.dimen_6),
              Expanded(
                child: Text(
                  _isFetchingAddress ? 'Resolving address...' : _selectedAddress,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(.82),
                        fontSize: Dimens.dimen_13,
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.viewModel.isEditable,
      builder: (context, isEditable, _) => PrimaryButton(
        label: context.localizations.add_reminder__save_btn_text,
        onPressed: isEditable ? () => widget.viewModel.onSaveButtonClicked() : null,
        minWidth: double.infinity,
      ),
    );
  }

  Widget _buildInputField({
    required BuildContext context,
    required TextEditingController controller,
    required String hintText,
    String? labelText,
    bool readOnly = false,
    int minLines = 1,
    int maxLines = 1,
    TextInputAction textInputAction = TextInputAction.next,
    IconData? suffixIcon,
    FocusNode? focusNode,
    bool highlightSuffixOnActive = false,
    VoidCallback? onTap,
    bool enabled = true,
  }) {
    final isDark = _isDark(context);
    final outlineColor = _fieldBorderColor(context);
    final accent = _accentColor(context);

    final resolvedKeyboardType =
        textInputAction == TextInputAction.newline || maxLines > 1
            ? TextInputType.multiline
            : TextInputType.text;

    return TextField(
      controller: controller,
      enabled: enabled,
      focusNode: focusNode,
      readOnly: readOnly,
      onTap: onTap,
      minLines: minLines,
      maxLines: maxLines,
      textInputAction: textInputAction,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: Dimens.dimen_16,
          ),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: _hintColor(context),
              fontWeight: FontWeight.w500,
              fontSize: Dimens.dimen_14,
            ),
        labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: _accentColor(context),
              fontWeight: FontWeight.w700,
              letterSpacing: .6,
              fontSize: Dimens.dimen_12,
            ),
        filled: true,
        fillColor: _fieldBg(context),
        contentPadding: EdgeInsets.symmetric(
          horizontal: Dimens.dimen_16,
          vertical: minLines > 1 ? Dimens.dimen_16 : Dimens.dimen_14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.dimen_16),
          borderSide: BorderSide(
            color: outlineColor.withOpacity(isDark ? .85 : .75),
            width: 1.2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dimens.dimen_16),
          borderSide: BorderSide(color: accent, width: Dimens.dimen_2),
        ),
        suffixIcon: suffixIcon != null
            ? ListenableBuilder(
                listenable: Listenable.merge([
                  controller,
                  if (focusNode != null) focusNode,
                ]),
                builder: (context, child) {
                  final isActive = highlightSuffixOnActive &&
                      ((focusNode?.hasFocus ?? false) ||
                          controller.text.trim().isNotEmpty);
                  return Padding(
                    padding: EdgeInsets.only(right: Dimens.dimen_8),
                    child: Icon(
                      suffixIcon,
                      color: isActive ? _accentColor(context) : _hintColor(context),
                      size: Dimens.dimen_22,
                    ),
                  );
                },
              )
            : null,
      ),
      keyboardType: resolvedKeyboardType,
    );
  }
}
