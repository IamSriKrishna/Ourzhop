// ====================
// Set Location Screen - Independent Feature
// ====================
// File: lib/features/set_location/presentation/screens/set_location_screen.dart

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:customer_app/common/validation/search_input.dart';
import 'package:customer_app/common/widget/app_error_display.dart';
import 'package:customer_app/common/widget/app_extensions.dart';
import 'package:customer_app/common/widget/app_primary_action_button.dart';
import 'package:customer_app/constants/app_route_constants.dart';
import 'package:customer_app/core/l10n/app_localizations.dart';
import 'package:customer_app/core/models/stored_location_model.dart';
import 'package:customer_app/core/services/user_preference_service.dart';
import 'package:customer_app/core/themes/app_colors.dart';
import 'package:customer_app/core/themes/app_style.dart';
import 'package:customer_app/features/set_location/data/models/set_location_model.dart';
import 'package:customer_app/features/set_location/presentation/bloc/set_location_bloc.dart';
import 'package:customer_app/features/set_location/presentation/bloc/set_location_event.dart';
import 'package:customer_app/features/set_location/presentation/bloc/set_location_state.dart';

class SetLocationScreen extends StatefulWidget {
  const SetLocationScreen({super.key});

  @override
  State<SetLocationScreen> createState() => _SetLocationScreenState();
}

class _SetLocationScreenState extends State<SetLocationScreen> {
  // Controllers and keys declaration (late final for lifecycle)
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;

  // State variables for debouncing
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    // Initialize controllers
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // CRITICAL: Always dispose controllers
    _searchController.dispose();
    _searchFocusNode.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // BlocConsumer for state management
    return BlocConsumer<SetLocationBloc, SetLocationState>(
      listenWhen: (previous, current) =>
          // Listen for navigation success or critical errors
          current is SetLocationError,
      buildWhen: (previous, current) =>
          // Rebuild when state type changes or validation state changes
          previous.runtimeType != current.runtimeType ||
          (previous is SetLocationInitial &&
              current is SetLocationInitial &&
              (previous.shouldShowValidationError !=
                      current.shouldShowValidationError ||
                  previous.searchError != current.searchError ||
                  previous.canContinue != current.canContinue)),
      listener: _handleSetLocationStateChange,
      builder: (context, state) => _buildMainScaffold(context, state),
    );
  }

  /// Handles SetLocation state changes
  void _handleSetLocationStateChange(
      BuildContext context, SetLocationState state) {
    if (state is SetLocationError) {
      // Show error dialog for critical errors
      AppErrorDisplay.showDialog(
        context,
        state.message,
      );
    }
  }

  /// Builds the main scaffold structure
  Widget _buildMainScaffold(BuildContext context, SetLocationState state) {
    final appColors = context.appColors;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: appColors.backgroundGradient,
        ),
        child: SafeArea(
          child: _buildMainContent(context, state),
        ),
      ),
    );
  }

  /// Builds the main content with proper structure
  Widget _buildMainContent(BuildContext context, SetLocationState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20.0),
          _buildSubtitleSection(context), // Title Section
          const SizedBox(height: 24.0),
          _buildSearchSection(context, state), // Search Section
          const Spacer(), // Spacer to push button to bottom
          _buildContinueButton(context, state), // Continue Button
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }

  Widget _buildSubtitleSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Text(
          AppLocalizations.of(context)!.setLocationPageTitle,
          style: AppTypography.getAppBarTitle(context).copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          AppLocalizations.of(context)!.setLocationPageSubtitle,
          style: AppTypography.getBodyText(context).copyWith(
            color: context.appColors.onSurfaceVariant,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchSection(BuildContext context, SetLocationState state) {
    return Column(
      children: [
        _buildSearchInputSection(context, state),
        BlocBuilder<SetLocationBloc, SetLocationState>(
          buildWhen: (previous, current) =>
              // Only rebuild when search results or loading state changes
              previous.runtimeType != current.runtimeType ||
              (previous is SetLocationLoading) !=
                  (current is SetLocationLoading) ||
              (previous is SetLocationSuccess &&
                  current is SetLocationSuccess &&
                  previous.locations != current.locations),
          builder: (context, state) {
            if (state is SetLocationLoading) {
              return Container(
                margin: const EdgeInsets.only(top: 8.0),
                height: 60,
                child: Center(
                  child: AppLoadingStates.loadingIndicator(context),
                ),
              );
            } else if (state is SetLocationSuccess) {
              return _buildSearchResults(context, state.locations);
            } else if (state is SetLocationEmpty) {
              return Container(
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: context.appColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: context.appColors.outline),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_off,
                      color: context.appColors.onSurfaceVariant,
                      size: 20,
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.setLocationNoResults,
                        style: AppTypography.getBodyText(context).copyWith(
                          color: context.appColors.onSurfaceVariant,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _buildSearchInputSection(
      BuildContext context, SetLocationState state) {
    return BlocBuilder<SetLocationBloc, SetLocationState>(
      buildWhen: (previous, current) =>
          // Only rebuild when validation state changes
          previous is SetLocationInitial &&
          current is SetLocationInitial &&
          (previous.shouldShowValidationError !=
                  current.shouldShowValidationError ||
              previous.searchError != current.searchError),
      builder: (context, state) {
        final initialState =
            state is SetLocationInitial ? state : const SetLocationInitial();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 56.0,
              decoration: BoxDecoration(
                color: context.appColors.surface,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: initialState.shouldShowValidationError &&
                          initialState.searchError != null
                      ? context.appColors.error
                      : context.appColors.outline,
                ),
              ),
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                autofocus: true, // Auto-focus for better UX
                maxLength:
                    SearchInput.maxSearchLength, // Added maxLength constraint
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.setLocationSearchHint,
                  hintStyle: TextStyle(
                    color: context.appColors.onSurfaceVariant,
                    fontSize: 16,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: context.appColors.onSurfaceVariant,
                    size: 24,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: context.appColors.onSurfaceVariant,
                          ),
                          onPressed: () => _handleClearSearch(context),
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 18.0,
                  ),
                  counterText: '', // Hide character counter for clean UI
                ),
                onChanged: (value) => _handleSearchTextChanged(context, value),
              ),
            ),
            if (initialState.shouldShowValidationError &&
                initialState.searchError != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  _getSearchErrorText(context, initialState.searchError!),
                  style: TextStyle(
                    color: context.appColors.error,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildSearchResults(
      BuildContext context, List<SetLocationModel> locations) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      constraints: const BoxConstraints(maxHeight: 360),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: context.appColors.outline),
        boxShadow: [
          BoxShadow(
            color: context.appColors.onSurface.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final location = locations[index];
          return ListTile(
            leading: Icon(
              Icons.location_on,
              color: context.appColors.onSurfaceVariant,
              size: 20,
            ),
            title: Text(
              location.mainText,
              style: AppTypography.getBodyText(context).copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              location.secondaryText,
              style: AppTypography.getBodyText(context).copyWith(
                color: context.appColors.onSurfaceVariant,
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () => _handleLocationSelected(context, location),
          );
        },
      ),
    );
  }

  /// Builds the continue button with optimized rebuilds
  Widget _buildContinueButton(BuildContext context, SetLocationState state) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<SetLocationBloc, SetLocationState>(
      buildWhen: (previous, current) =>
          // Only rebuild when continue button state changes
          previous is SetLocationInitial &&
          current is SetLocationInitial &&
          previous.canContinue != current.canContinue,
      builder: (context, state) {
        final initialState =
            state is SetLocationInitial ? state : const SetLocationInitial();

        return AppPrimaryActionButton(
          text: l10n.continueButtonTitle,
          onPressed: () => _handleContinuePressed(context, initialState),
          enabled: initialState.canContinue,
        );
      },
    );
  }

  /// Handles search text changes with validation
  void _handleSearchTextChanged(BuildContext context, String value) {
    // Update BLoC with new search input
    context.read<SetLocationBloc>().add(SearchInputChanged(value));

    // Cancel any existing timer
    _debounceTimer?.cancel();

    // If search text is empty or less than minimum, clear search immediately
    if (value.trim().isEmpty || value.length < SearchInput.minSearchLength) {
      context.read<SetLocationBloc>().add(const ClearSetLocationEvent());
      return;
    }

    // Start new debounce timer (500ms delay)
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (value.trim().isNotEmpty &&
          value.length >= SearchInput.minSearchLength) {
        context
            .read<SetLocationBloc>()
            .add(SearchSetLocationRequested(value.trim()));
      }
    });
  }

  /// Handles clearing search input
  void _handleClearSearch(BuildContext context) {
    _searchController.clear();
    context.read<SetLocationBloc>().add(const ClearSetLocationEvent());
  }

  /// Handles location selection from search results
  void _handleLocationSelected(
      BuildContext context, SetLocationModel location) {
    // Immediately save location and navigate - no need to populate search input
    context.read<SetLocationBloc>().add(LocationSelected(location));
    _saveLocationAndNavigate(context, location);
  }

  /// Handles continue button press
  void _handleContinuePressed(BuildContext context, SetLocationInitial state) {
    if (!state.canContinue) {
      context.read<SetLocationBloc>().add(const ShowSearchValidationError());
      _searchFocusNode.requestFocus();
      return;
    }

    _saveLocationAndNavigate(context, state.selectedLocation!);
  }

  /// Gets search error text for display
  String _getSearchErrorText(
      BuildContext context, SearchValidationError error) {
    final l10n = AppLocalizations.of(context)!;
    switch (error) {
      case SearchValidationError.empty:
        return l10n.setLocationEmptySearchError;
      case SearchValidationError.tooShort:
        return l10n.setLocationSearchTooShortError;
      case SearchValidationError.tooLong:
        return l10n.setLocationSearchTooLongError;
      case SearchValidationError.onlyWhitespace:
        return l10n.setLocationInvalidSearchError;
    }
  }

  /// Saves location data and navigates to home screen
  Future<void> _saveLocationAndNavigate(
      BuildContext context, SetLocationModel location) async {
    await _saveSelectedLocation(location);

    if (context.mounted) {
      _navigateToHome(context);
    }
  }

  /// Saves selected location to user preferences
  Future<void> _saveSelectedLocation(SetLocationModel location) async {
    // Save complete location data with display text fields
    final storedLocation = StoredLocationModel(
      placeId: location.placeId,
      description: location.description,
      mainText: location.mainText,
      secondaryText: location.secondaryText,
      latitude: location.latitude,
      longitude: location.longitude,
    );

    await UserPreferenceService().saveSelectedLocation(storedLocation);
  }

  /// Navigates to home screen
  void _navigateToHome(BuildContext context) {
    // Use context.go() to match project routing conventions
    context.go(AppRoutes.home);
  }
}
