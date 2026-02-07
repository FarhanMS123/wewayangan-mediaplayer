# Recommended Project Structure for Scalable Flutter Apps

This document outlines a recommended directory structure for `lib/` that adheres to the Very Good Ventures (VGV) CLI standards while accommodating complex features, multiple sub-pages, and custom components.

## Core Philosophy
1.  **Feature-First**: Code is organized by feature (what it does) rather than type (widgets, controllers, users).
2.  **Scalability**: The structure supports features growing from simple single-page views to complex multi-page workflows without refactoring the entire app.
3.  **Strict Separation**: Logic (`cubit`/`bloc`) is separated from UI (`view`).

---

## 1. High-Level `lib/` Structure

Keep the root clean. Features live at the top level of `lib/`. Shared code goes into `core` or `shared`.

```
lib/
├── app/                 # The root app feature (MaterialApp/CupertinoApp setup)
├── l10n/                # Localization (arb files, generated code)
├── bootstrap.dart       # App startup logic (bloc observer, etc.)
├── main_*.dart          # Entry points (development, staging, production)
│
├── core/                # Global utilities, singleton services, exceptions (LOW-LEVEL)
│   ├── network/
│   ├── utils/
│   └── constants/
│
├── shared/              # Shared UI components & widgets (HIGH-LEVEL)
│   ├── widgets/         # App implementation of design system (Buttons, Cards)
│   └── theme/           # Theme definitions
│
├── pages/               # (Optional) Grouping for page-level features if desired
│   ├── video/           # Feature: Video (e.g., login, dashboard, settings)
│   └── ...
│
└── ...
```

---

## 2. Structure Recommendation for `lib/app`

The `app` directory is the entry point for the UI. It sets up the global context (Providers, Theme, Routing).

**Recommended Structure:**

```
lib/app/
├── app.dart              # Barrel file
├── view/
│   ├── app.dart          # The Root Widget (MaterialApp.router / MaterialApp)
│   └── app_view.dart     # (Optional) If you have a global wrapper layout (uncommon but possible)
├── routes/
│   ├── routes.dart       # Route definitions (e.g., GoRouter configuration)
│   └── route_observer.dart # Analytics or logging for navigation
├── theme/
│   ├── app_theme.dart    # ThemeData configuration
│   └── app_colors.dart   # Color palette
└── bloc/                 # GLOBAL State (only if absolutely necessary)
    ├── app_bloc.dart     # Top-level state (e.g., User Authentication status, Theme mode)
    └── app_event.dart
```

**What goes where?**
- **`view/app.dart`**: This is where you configure `MaterialApp`, `theme`, `localizationsDelegates`, and `routerConfig`.
- **`routes/`**: Keep your routing logic here. If using `auto_route` or `go_router`, define the top-level configuration here.
- **`theme/`**: Theme data often lives in `lib/shared/theme`, but if it's very specific to the `MaterialApp` configuration, it can live here. *Recommendation: Check `lib/shared/theme` first.*
- **`bloc/`**: Only put truly global state here, like "Is the user authenticated?" or "Is the app in Dark Mode?".

---

## 3. Structure Recommendation for `lib/pages/video` (Feature Example)

This folder replaces `lib/counter`. It should contain EVERYTHING related to the "Video" feature.

**Scenario**: A video feature with a list of videos, a video player, and video details.

**Recommended Structure:**

```
lib/pages/video/
├── video.dart                   # Barrel file (exports Page and maybe key models)
│
├── models/                      # Feature-specific models
│   ├── video_item.dart          # Data class for a video
│   └── video_filter.dart        # Filter options (e.g., "Trending", "New")
│
├── cubit/
│   ├── video_list/              # State for the list view
│   │   ├── video_list_cubit.dart
│   │   └── video_list_state.dart
│   │
│   ├── video_player/            # State for the player
│   │   ├── video_player_cubit.dart
│   │   └── video_player_state.dart
│   │
│   └── video_repository.dart    # (Optional) Facade for API calls specific to videos
│
├── view/
│   ├── video_page.dart          # Entry point (Route). Provides BlocProviders.
│   ├── video_view.dart          # Main Layout (Scaffold)
│   │
│   ├── specific_views/          # Break down complex sub-views
│   │   ├── video_list_view.dart
│   │   └── video_player_view.dart
│   │
│   └── widgets/                 # UI components used ONLY in this feature
│       ├── video_card.dart      # Thumbnail + Title card
│       ├── player_controls.dart # Play/Pause/Seek buttons
│       └── video_info_sheet.dart # Bottom sheet with description
│
└── widgets/                     # (Optional) Shared widgets for the feature
    └── ...
```

**Key Principles for `lib/pages/video`:**
1.  **`view/video_page.dart`**: This is the "Container". It connects the `VideoListCubit` and `VideoPlayerCubit` to the UI.
2.  **`view/video_view.dart`**: The "Presenter". It builds the `Scaffold` and decides whether to show the list or the player (or both, if split-screen).
3.  **`models/`**: If `VideoItem` is used *only* here, keep it here. If it's used by other features (e.g., "Favorites"), move it to `lib/models` or `lib/packages/api_repository`.


---

## 4. The "Complex Feature" Structure (Multi-page)

For features that contain multiple pages (e.g., an `Orders` feature that has a `List` page, a `Detail` page, and a `History` page).

Instead of flattening everything, use **sub-directories** within `view` and `cubit` (or `bloc`) to organize by sub-feature/page.

### Example: `lib/orders/`

```
lib/orders/
├── orders.dart                  # Barrel file: exports pages and global feature-widgets
│
├── models/                      # Setup feature-specific models here if they don't belong in domain
│   └── order_filter.dart
│
├── bloc/ (or cubit/)
│   ├── orders_list/             # State for the List Page
│   │   ├── orders_list_cubit.dart
│   │   └── orders_list_state.dart
│   │
│   ├── order_detail/            # State for the Detail Page
│   │   ├── order_detail_cubit.dart
│   │   └── order_detail_state.dart
│   │
│   └── orders_repository.dart   # (Optional) If feature calls specific complex logic
│
├── view/                        # The "View" Layer
│   ├── orders_list/             # Group by Page
│   │   ├── orders_list_page.dart # Injection (BlocProvider) + Scaffold
│   │   ├── orders_list_view.dart # UI Layout
│   │   └── widgets/             # Private widgets ONLY for this page
│   │       ├── order_list_item.dart
│   │       └── order_filter_sheet.dart
│   │
│   └── order_detail/
│       ├── order_detail_page.dart
│       ├── order_detail_view.dart
│       └── widgets/
│           ├── order_timeline.dart
│           └── order_invoice_card.dart
│
└── widgets/                     # Shared widgets across the ENTIRE feature
    ├── order_status_badge.dart  # Used in both List and Detail pages
    └── order_price_text.dart
```

---

## 5. Deep Dive: What goes into `view/`?

The `view` directory is for **UI Layer**. It shouldn't contain business logic.

**Standard Files:**
- `*_page.dart`: The **Entry Point**. Responsible for:
    - Routing arguments (reading `id` from URL/params).
    - Dependency Injection (providing `BlocProvider`, `RepositoryProvider`).
    - Returning the `View`.
- `*_view.dart`: The **Layout**. Responsible for:
    - `Scaffold`, `AppBar`, `listeners` (BlocListener).
    - Building the UI tree.

**What ELSE goes in `view/`?**
If a view is complex, do NOT put everything in one file. Break it down:

1.  **`compoments/` or `sections/`**:
    - Large chunks of the screen that are essentially "partial views".
    - *Example*: `profile_header_section.dart`, `settings_list_section.dart`.
2.  **`dialogs/`**:
    - If a specific dialog is only used here.
    - *Example*: `confirm_delete_dialog.dart`.
3.  **`modals/` or `sheets/`**:
    - Bottom sheets specific to this page.
    - *Example*: `filter_options_sheet.dart`.
4.  **`layout/`**:
    - If you support responsive layouts (Desktop vs Mobile).
    - *Example*: `dashboard_layout_mobile.dart`, `dashboard_layout_web.dart`.

**Example Folder Structure for `lib/profile/view/`:**
```
lib/profile/view/
├── profile_page.dart             # Provides ProfileBloc
├── profile_view.dart             # Scaffold, checks responsive layout
├── layouts/
│   ├── profile_mobile_layout.dart
│   └── profile_web_layout.dart
├── sections/                     # Big chunks of UI
│   ├── profile_header.dart
│   └── profile_stats_grid.dart
├── dialogs/
│   └── edit_username_dialog.dart
└── widgets/                      # Small UI bits unique to Profile
    └── profile_avatar_editor.dart
```

---

## 6. Deep Dive: What goes into `cubit/` (or `bloc/`)?

The `cubit` (or `bloc`) directory is for **Business Logic & State**.

**Standard Files:**
- `*_cubit.dart`: Methods to handle events/actions (`loadData()`, `submitForm()`).
- `*_state.dart`: The state class (`equatable`, properties, factories).

**What ELSE goes in `cubit/`?**
1.  **`models/` (Private Models)**:
    - If your state needs a specific class that isn't a global domain entity.
    - *Example*: `FormInputStatus` (enum), `ProfileEditingData` (temporary holding class).
    - *Note*: If reused, move to `lib/models` or `lib/packages/`.
2.  **`converters/` or `mappers/`**:
    - If you need complex logic to transform API data into UI data.
    - *Example*: `chart_data_mapper.dart`.
3.  **`parts/`**:
    - If your Cubit is huge (500+ lines), use `part` and `part of` to split it.
    - *Example*: `files_cubit.dart`, `files_cubit_upload.dart` (part).

---

## 7. Handling Custom Components

Where do "Custom Components" go? It depends on **reuse scope**.

| Scope | Location | Example |
| :--- | :--- | :--- |
| **Global (App-wide)** | `lib/shared/widgets/` | `AppButton`, `AppTextField`, `CustomLoader` |
| **Feature-wide** | `lib/[feature]/widgets/` | `TransactionCard` (used in History & Detail pages) |
| **Page-specific** | `lib/[feature]/view/[page]/widgets/` | `FilterHeader` (only used in List page) |

### Recommendation for `shared/widgets/`:
Create a "Design System" feel.
```
lib/shared/widgets/
├── buttons/
│   ├── app_primary_button.dart
│   └── app_icon_button.dart
├── inputs/
│   ├── app_text_field.dart
│   └── app_dropdown.dart
├── layout/
│   ├── app_spacer.dart
│   └── app_container.dart
└── typography/
    └── app_text.dart
```

## Summary Checklist
1.  Start with `lib/[feature]/view` and `lib/[feature]/cubit`.
2.  If `view` grows > 300 lines or distinct "pages" appear, create sub-folders `lib/[feature]/view/list` and `lib/[feature]/view/detail`.
3.  If `widgets` are used in > 1 page, put them in `lib/[feature]/widgets`.
4.  If `widgets` are used in > 1 feature, put them in `lib/shared/widgets`.
