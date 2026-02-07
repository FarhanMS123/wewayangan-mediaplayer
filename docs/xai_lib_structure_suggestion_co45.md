# Flutter App Project Structure Suggestion

> Please get all directory and subdirectory of `lib/` so you understand these project structure. Imagine I have multi pages app, there is Home, Account, Login, Register, Transaction, and Search. The app also handle the edge cases such as Error 404, 403, and any edge case you could think of. This is Android App. Could you suggest the project structure for this Flutter app? Please follow the boilerplate already provide. I am using Very Good CLI Flutter App Core to generate this boilerplate. You just need to suggest a directory tree from `lib/` there is no need to generate files. If you have any question just figure it out, don't ask me back. Just surprise me. I also wants you to complete `lib/*/view/` structure with everything you can think of. I want you to also fill `lib/*/views/` other than `app.dart` or `{feat}_{type}.dart`. My objective is to see a complete structure which each folders can fill. Try to fill the `**/view/*`. Analyze deeper. Follow the boilerplate.

Following the **Very Good CLI** boilerplate pattern with feature-first architecture and BLoC/Cubit state management.

---

## Complete `lib/` Directory Tree

```
lib/
├── main_development.dart
├── main_staging.dart
├── main_production.dart
├── bootstrap.dart
│
├── app/
│   ├── app.dart                              # Barrel export
│   ├── view/
│   │   ├── app.dart                          # MaterialApp root widget
│   │   ├── app_router.dart                   # GoRouter/Navigator 2.0 route config
│   │   └── app_theme.dart                    # Theme configuration widget
│   └── bloc/
│       ├── app_bloc.dart                     # App-level bloc (auth state, connectivity)
│       └── app_state.dart
│
├── home/
│   ├── home.dart                             # Barrel export
│   ├── cubit/
│   │   ├── home_cubit.dart
│   │   └── home_state.dart
│   ├── view/
│   │   ├── home_page.dart                    # Page widget (provides BLoC)
│   │   ├── home_view.dart                    # Main view scaffold
│   │   ├── home_app_bar.dart                 # Custom AppBar for home
│   │   └── home_drawer.dart                  # Navigation drawer
│   └── widgets/
│       ├── home_header.dart                  # Hero header section
│       ├── home_carousel.dart                # Featured content carousel
│       ├── home_quick_actions.dart           # Quick action buttons grid
│       ├── home_recent_transactions.dart     # Recent transactions preview
│       └── home_bottom_nav.dart              # Bottom navigation bar
│
├── account/
│   ├── account.dart                          # Barrel export
│   ├── bloc/
│   │   ├── account_bloc.dart
│   │   ├── account_event.dart
│   │   └── account_state.dart
│   ├── view/
│   │   ├── account_page.dart                 # Page widget (provides BLoC)
│   │   ├── account_view.dart                 # Main account view
│   │   ├── account_profile_view.dart         # Profile details section
│   │   ├── account_settings_view.dart        # Account settings
│   │   ├── account_security_view.dart        # Security & privacy settings
│   │   ├── account_notifications_view.dart   # Notification preferences
│   │   └── account_edit_page.dart            # Edit profile page
│   └── widgets/
│       ├── account_avatar.dart               # Profile avatar with edit
│       ├── account_info_tile.dart            # Reusable info row tile
│       ├── account_menu_item.dart            # Menu item with icon
│       ├── account_stats_card.dart           # Statistics card widget
│       └── account_logout_button.dart        # Logout confirmation button
│
├── auth/
│   ├── auth.dart                             # Barrel export
│   ├── bloc/
│   │   ├── auth_bloc.dart                    # Global auth state
│   │   ├── auth_event.dart
│   │   └── auth_state.dart
│   ├── login/
│   │   ├── login.dart                        # Barrel export
│   │   ├── cubit/
│   │   │   ├── login_cubit.dart
│   │   │   └── login_state.dart
│   │   ├── view/
│   │   │   ├── login_page.dart               # Page widget (provides BLoC)
│   │   │   ├── login_view.dart               # Main login scaffold
│   │   │   ├── login_form.dart               # Login form widget
│   │   │   ├── login_social_buttons.dart     # Social login options
│   │   │   └── login_forgot_password_link.dart # Forgot password navigation
│   │   └── widgets/
│   │       ├── login_header.dart             # Logo & welcome text
│   │       ├── login_email_field.dart        # Email input with validation
│   │       ├── login_password_field.dart     # Password input with toggle
│   │       ├── login_remember_me.dart        # Remember me checkbox
│   │       └── login_submit_button.dart      # Animated submit button
│   ├── register/
│   │   ├── register.dart                     # Barrel export
│   │   ├── cubit/
│   │   │   ├── register_cubit.dart
│   │   │   └── register_state.dart
│   │   ├── view/
│   │   │   ├── register_page.dart            # Page widget (provides BLoC)
│   │   │   ├── register_view.dart            # Main register scaffold
│   │   │   ├── register_form.dart            # Registration form
│   │   │   ├── register_steps_indicator.dart # Multi-step progress indicator
│   │   │   ├── register_personal_info.dart   # Step 1: Personal info
│   │   │   ├── register_credentials.dart     # Step 2: Email & password
│   │   │   ├── register_verification.dart    # Step 3: OTP/Email verification
│   │   │   └── register_terms_view.dart      # Terms & conditions view
│   │   └── widgets/
│   │       ├── register_header.dart          # Registration header
│   │       ├── register_name_fields.dart     # First/Last name inputs
│   │       ├── register_phone_field.dart     # Phone number with country code
│   │       ├── register_email_field.dart     # Email with availability check
│   │       ├── register_password_field.dart  # Password with strength indicator
│   │       ├── register_confirm_password.dart # Confirm password field
│   │       ├── register_terms_checkbox.dart  # Terms agreement checkbox
│   │       └── register_submit_button.dart   # Animated submit button
│   ├── forgot_password/
│   │   ├── forgot_password.dart              # Barrel export
│   │   ├── cubit/
│   │   │   ├── forgot_password_cubit.dart
│   │   │   └── forgot_password_state.dart
│   │   └── view/
│   │       ├── forgot_password_page.dart     # Page widget (provides BLoC)
│   │       ├── forgot_password_view.dart     # Request reset form
│   │       ├── forgot_password_otp_view.dart # OTP verification
│   │       └── forgot_password_reset_view.dart # New password form
│   └── widgets/
│       ├── auth_background.dart              # Shared auth background
│       ├── auth_card.dart                    # Shared card container
│       ├── auth_divider.dart                 # "Or continue with" divider
│       └── social_login_button.dart          # Reusable social button
│
├── transaction/
│   ├── transaction.dart                      # Barrel export
│   ├── bloc/
│   │   ├── transaction_bloc.dart
│   │   ├── transaction_event.dart
│   │   └── transaction_state.dart
│   ├── view/
│   │   ├── transaction_page.dart             # Page widget (provides BLoC)
│   │   ├── transaction_list_view.dart        # Transaction list with filters
│   │   ├── transaction_detail_page.dart      # Single transaction detail
│   │   ├── transaction_detail_view.dart      # Detail content view
│   │   ├── transaction_filter_view.dart      # Filter & sort bottom sheet
│   │   ├── transaction_create_page.dart      # Create new transaction
│   │   ├── transaction_create_view.dart      # Create form view
│   │   └── transaction_receipt_view.dart     # Transaction receipt/confirmation
│   └── widgets/
│       ├── transaction_card.dart             # Transaction list item card
│       ├── transaction_status_badge.dart     # Status indicator badge
│       ├── transaction_amount.dart           # Formatted amount display
│       ├── transaction_date_group.dart       # Date group header
│       ├── transaction_filter_chips.dart     # Quick filter chips
│       ├── transaction_search_bar.dart       # Search transactions
│       ├── transaction_empty_state.dart      # Empty list illustration
│       └── transaction_skeleton.dart         # Loading skeleton
│
├── search/
│   ├── search.dart                           # Barrel export
│   ├── bloc/
│   │   ├── search_bloc.dart
│   │   ├── search_event.dart
│   │   └── search_state.dart
│   ├── view/
│   │   ├── search_page.dart                  # Page widget (provides BLoC)
│   │   ├── search_view.dart                  # Main search scaffold
│   │   ├── search_results_view.dart          # Search results display
│   │   ├── search_filters_view.dart          # Advanced filters bottom sheet
│   │   ├── search_suggestions_view.dart      # Auto-complete suggestions
│   │   └── search_history_view.dart          # Recent search history
│   └── widgets/
│       ├── search_input.dart                 # Search text field with icons
│       ├── search_filter_button.dart         # Filter toggle button
│       ├── search_result_item.dart           # Individual result item
│       ├── search_result_highlight.dart      # Text with query highlight
│       ├── search_category_chip.dart         # Category filter chip
│       ├── search_empty_state.dart           # No results illustration
│       ├── search_loading_indicator.dart     # Search loading animation
│       └── search_history_item.dart          # History item with delete
│
├── error/
│   ├── error.dart                            # Barrel export
│   ├── view/
│   │   ├── error_page.dart                   # Generic error page wrapper
│   │   ├── error_view.dart                   # Base error view widget
│   │   ├── error_404_page.dart               # Not Found page
│   │   ├── error_404_view.dart               # Not Found content
│   │   ├── error_403_page.dart               # Forbidden/Access Denied page
│   │   ├── error_403_view.dart               # Forbidden content
│   │   ├── error_500_page.dart               # Server Error page
│   │   ├── error_500_view.dart               # Server Error content
│   │   ├── error_network_page.dart           # No Internet connection page
│   │   ├── error_network_view.dart           # Network error content
│   │   ├── error_maintenance_page.dart       # App under maintenance page
│   │   ├── error_maintenance_view.dart       # Maintenance content
│   │   ├── error_session_expired_page.dart   # Session timeout page
│   │   ├── error_session_expired_view.dart   # Session expired content
│   │   ├── error_permission_denied_page.dart # Permission denied page
│   │   └── error_permission_denied_view.dart # Permission content
│   └── widgets/
│       ├── error_illustration.dart           # Error illustration/Lottie
│       ├── error_title.dart                  # Error title text
│       ├── error_description.dart            # Error description text
│       ├── error_action_button.dart          # Primary action button
│       ├── error_secondary_action.dart       # Secondary action link
│       └── error_support_link.dart           # Contact support link
│
├── splash/
│   ├── splash.dart                           # Barrel export
│   ├── cubit/
│   │   ├── splash_cubit.dart                 # Init logic (auth check, config)
│   │   └── splash_state.dart
│   └── view/
│       ├── splash_page.dart                  # Page widget (provides BLoC)
│       ├── splash_view.dart                  # Animated splash view
│       └── splash_loading_indicator.dart     # Loading animation
│
├── onboarding/
│   ├── onboarding.dart                       # Barrel export
│   ├── cubit/
│   │   ├── onboarding_cubit.dart
│   │   └── onboarding_state.dart
│   └── view/
│       ├── onboarding_page.dart              # Page widget (provides BLoC)
│       ├── onboarding_view.dart              # PageView with slides
│       ├── onboarding_slide_view.dart        # Single slide template
│       └── onboarding_navigation_view.dart   # Dots & buttons
│
├── settings/
│   ├── settings.dart                         # Barrel export
│   ├── cubit/
│   │   ├── settings_cubit.dart
│   │   └── settings_state.dart
│   └── view/
│       ├── settings_page.dart                # Page widget (provides BLoC)
│       ├── settings_view.dart                # Settings list view
│       ├── settings_theme_view.dart          # Theme selection
│       ├── settings_language_view.dart       # Language selection
│       ├── settings_notification_view.dart   # Push notification settings
│       └── settings_about_view.dart          # About app info
│
├── core/
│   ├── core.dart                             # Barrel export
│   ├── constants/
│   │   ├── constants.dart                    # Barrel export
│   │   ├── api_constants.dart                # API endpoints
│   │   ├── asset_constants.dart              # Asset paths
│   │   ├── app_constants.dart                # App-wide constants
│   │   └── route_constants.dart              # Route names
│   ├── theme/
│   │   ├── theme.dart                        # Barrel export
│   │   ├── app_theme.dart                    # ThemeData definitions
│   │   ├── app_colors.dart                   # Color palette
│   │   ├── app_typography.dart               # Text styles
│   │   ├── app_spacing.dart                  # Spacing constants
│   │   └── app_shadows.dart                  # Box shadow definitions
│   ├── router/
│   │   ├── router.dart                       # Barrel export
│   │   ├── app_router.dart                   # GoRouter configuration
│   │   ├── route_guards.dart                 # Auth guards, permission checks
│   │   └── route_transitions.dart            # Custom page transitions
│   ├── extensions/
│   │   ├── extensions.dart                   # Barrel export
│   │   ├── context_extensions.dart           # BuildContext extensions
│   │   ├── string_extensions.dart            # String utilities
│   │   ├── date_extensions.dart              # DateTime formatting
│   │   └── num_extensions.dart               # Number formatting
│   ├── utils/
│   │   ├── utils.dart                        # Barrel export
│   │   ├── validators.dart                   # Form validators
│   │   ├── formatters.dart                   # Data formatters
│   │   ├── logger.dart                       # Logging utility
│   │   └── debouncer.dart                    # Debounce utility
│   └── error/
│       ├── error.dart                        # Barrel export
│       ├── exceptions.dart                   # Custom exceptions
│       └── failure.dart                      # Failure models
│
├── data/
│   ├── data.dart                             # Barrel export
│   ├── repositories/
│   │   ├── repositories.dart                 # Barrel export
│   │   ├── auth_repository.dart              # Auth data operations
│   │   ├── user_repository.dart              # User data operations
│   │   ├── transaction_repository.dart       # Transaction data
│   │   └── search_repository.dart            # Search data
│   ├── datasources/
│   │   ├── datasources.dart                  # Barrel export
│   │   ├── local/
│   │   │   ├── local.dart                    # Barrel export
│   │   │   ├── secure_storage.dart           # Secure credentials
│   │   │   ├── shared_preferences.dart       # App preferences
│   │   │   └── database.dart                 # Local DB (Drift/Isar)
│   │   └── remote/
│   │       ├── remote.dart                   # Barrel export
│   │       ├── api_client.dart               # Dio/HTTP client
│   │       ├── auth_api.dart                 # Auth endpoints
│   │       ├── user_api.dart                 # User endpoints
│   │       └── transaction_api.dart          # Transaction endpoints
│   └── models/
│       ├── models.dart                       # Barrel export
│       ├── user_model.dart                   # User DTO
│       ├── transaction_model.dart            # Transaction DTO
│       ├── auth_token_model.dart             # Auth token model
│       └── api_response_model.dart           # Generic API response
│
├── domain/
│   ├── domain.dart                           # Barrel export
│   ├── entities/
│   │   ├── entities.dart                     # Barrel export
│   │   ├── user.dart                         # User entity
│   │   ├── transaction.dart                  # Transaction entity
│   │   └── search_result.dart                # Search result entity
│   ├── usecases/
│   │   ├── usecases.dart                     # Barrel export
│   │   ├── login_usecase.dart                # Login business logic
│   │   ├── register_usecase.dart             # Register logic
│   │   ├── get_user_usecase.dart             # Fetch user
│   │   └── search_usecase.dart               # Search logic
│   └── repositories/
│       ├── repositories.dart                 # Barrel export
│       ├── i_auth_repository.dart            # Auth repository interface
│       ├── i_user_repository.dart            # User repository interface
│       └── i_transaction_repository.dart     # Transaction interface
│
├── shared/
│   ├── shared.dart                           # Barrel export
│   └── widgets/
│       ├── widgets.dart                      # Barrel export
│       ├── app_button.dart                   # Primary/Secondary buttons
│       ├── app_text_field.dart               # Styled text input
│       ├── app_card.dart                     # Card container
│       ├── app_loading.dart                  # Loading spinner
│       ├── app_snackbar.dart                 # Custom snackbar
│       ├── app_dialog.dart                   # Modal dialog
│       ├── app_bottom_sheet.dart             # Bottom sheet wrapper
│       ├── app_avatar.dart                   # Avatar widget
│       ├── app_badge.dart                    # Badge/chip widget
│       ├── app_shimmer.dart                  # Shimmer loading effect
│       ├── app_divider.dart                  # Custom divider
│       ├── app_icon_button.dart              # Icon button wrapper
│       ├── app_empty_state.dart              # Generic empty state
│       └── app_error_widget.dart             # Inline error display
│
└── l10n/
    ├── l10n.dart                             # Barrel export & helper extensions
    ├── arb/
    │   ├── app_en.arb                        # English translations
    │   ├── app_es.arb                        # Spanish translations
    │   └── app_id.arb                        # Indonesian translations
    └── gen/
        ├── app_localizations.dart            # Generated base class
        ├── app_localizations_en.dart         # Generated EN
        ├── app_localizations_es.dart         # Generated ES
        └── app_localizations_id.dart         # Generated ID
```

---

## Architecture Pattern Summary

| Layer | Purpose | Location |
|-------|---------|----------|
| **Features** | Self-contained modules with view/bloc/widgets | `lib/{feature}/` |
| **Core** | Shared utilities, theme, routing, constants | `lib/core/` |
| **Data** | Repositories, data sources, DTOs | `lib/data/` |
| **Domain** | Business entities, use cases, repository interfaces | `lib/domain/` |
| **Shared** | Reusable UI components | `lib/shared/widgets/` |
| **L10n** | Localization/Internationalization | `lib/l10n/` |

---

## View Pattern Convention

Each feature follows the **Page-View-Widget** pattern:

```
{feature}/
├── {feature}.dart              # Barrel file exporting all public APIs
├── cubit/ or bloc/             # State management
│   ├── {feature}_cubit.dart
│   └── {feature}_state.dart
├── view/                       # Page views
│   ├── {feature}_page.dart     # Provides BLoC to children
│   ├── {feature}_view.dart     # Main scaffold/layout
│   └── {feature}_*_view.dart   # Sub-views for complex features
└── widgets/                    # Feature-specific reusable widgets
    └── {feature}_*.dart
```

---

## Edge Cases Covered

| Error Type | Page | Description |
|------------|------|-------------|
| **404 Not Found** | `error_404_page.dart` | Invalid route navigation |
| **403 Forbidden** | `error_403_page.dart` | Unauthorized access attempt |
| **500 Server Error** | `error_500_page.dart` | Backend/API failure |
| **No Internet** | `error_network_page.dart` | Connectivity issues |
| **Maintenance** | `error_maintenance_page.dart` | Scheduled downtime |
| **Session Expired** | `error_session_expired_page.dart` | Token invalidation |
| **Permission Denied** | `error_permission_denied_page.dart` | Missing device permissions |

---

> **Note**: All barrel files (`*.dart` at feature root) follow the Very Good CLI pattern of `export` statements only, keeping imports clean across the app.
