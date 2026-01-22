# Project Structure Proposal (Refined)

> Please get all directory and subdirectory of `lib/` so you understand these project structure. Imagine I have multi pages app, there is Home, Account, Login, Register, Transaction, and Search. The app also handle the edge cases such as Error 404, 403, and any edge case you could think of. This is Android App. Could you suggest the project structure for this Flutter app? Please follow the boilerplate already provide. I am using Very Good CLI Flutter App Core to generate this boilerplate. You just need to suggest a directory tree from `lib/` there is no need to generate files. If you have any question just figure it out, don't ask me back. Just surprise me. I also wants you to complete `lib/*/view/` structure with everything you can think of. I want you to also fill `lib/*/views/` other than `app.dart` or `{feat}_{type}.dart`. My objective is to see a complete structure which each folders can fill. Try to fill the `**/view/*`. Analyze deeper. Follow the boilerplate. 

> I want you to not use "features/", follow the original that feature directly under `lib/` like `lib/counter/`. I want you to also fill `lib/*/views/` other than app.dart or `{feat}_{ty[e}.dart`. Try to fill the `**/view/*`. Analyze deeper.

This structure follows the **Very Good Core** flat pattern (features directly under `lib/`) and provides a deeper breakdown of the `view/` directories, separating pages, views, and feature-specific widgets.

## Key Principles
- **Flat Hierarchy**: `lib/home`, `lib/login`, etc. (No `features/` folder).
- **View Breakdown**: 
    - `*_page.dart`: The entry point, responsible for DI (providing Cubits/Blocs).
    - `*_view.dart`: The main UI layout consuming the state.
    - `widgets/`: Smaller, feature-specific variables or widgets.
- **Edge Cases**: Dedicated `errors` directory for 404/403/etc.

## Directory Tree

```
lib/
├── app/
│   ├── view/
│   │   └── app.dart
│   └── routes/
│       ├── routes.dart               # Route names/paths
│       └── router.dart               # GoRouter/Navigator config
├── account/                          # Account Feature
│   ├── cubit/
│   │   ├── account_cubit.dart
│   │   └── account_state.dart
│   └── view/
│       ├── account_page.dart         # Provides AccountCubit
│       ├── account_view.dart         # Scaffold, Listeners
│       └── widgets/
│           ├── profile_header.dart   # Avatar, Name
│           └── settings_tile.dart    # Reusable list tile for account settings
├── home/                             # Home Feature
│   ├── cubit/
│   │   ├── home_cubit.dart
│   │   └── home_state.dart
│   └── view/
│       ├── home_page.dart
│       ├── home_view.dart
│       └── widgets/
│           ├── home_app_bar.dart     # Custom App Bar with actions
│           ├── balance_card.dart     # Dashboard widget
│           └── menu_grid.dart        # Navigation grid
├── login/                            # Login Feature
│   ├── cubit/
│   │   ├── login_cubit.dart
│   │   └── login_state.dart
│   └── view/
│       ├── login_page.dart
│       ├── login_view.dart           # Form fields, Button
│       └── widgets/
│           ├── login_form.dart       # The actual form widget
│           └── social_login_row.dart # Google/Facebook buttons
├── register/                         # Register Feature
│   ├── cubit/
│   │   ├── register_cubit.dart
│   │   └── register_state.dart
│   └── view/
│       ├── register_page.dart
│       ├── register_view.dart
│       └── widgets/
│           ├── register_form.dart
│           └── terms_checkbox.dart
├── transaction/                      # Transaction (History/Details)
│   ├── cubit/
│   │   ├── transaction_cubit.dart
│   │   └── transaction_state.dart
│   └── view/
│       ├── transaction_page.dart
│       ├── transaction_list_view.dart  # Renamed for clarity if it's a list
│       ├── transaction_detail_page.dart # Sub-page for details
│       ├── transaction_detail_view.dart
│       └── widgets/
│           ├── transaction_filter_sheet.dart # BottomSheet for filtering
│           └── transaction_item_tile.dart    # Individual list item
├── search/                           # Search Feature
│   ├── cubit/
│   │   ├── search_cubit.dart
│   │   └── search_state.dart
│   └── view/
│       ├── search_page.dart
│       ├── search_view.dart
│       └── widgets/
│           ├── search_bar_input.dart
│           ├── search_results_list.dart
│           └── empty_search_state.dart
├── errors/                           # Edge Case Pages
│   ├── cubit/                        # (Optional) specific logic for error reporting?
│   └── view/
│       ├── not_found_page.dart       # 404
│       ├── forbidden_page.dart       # 403
│       ├── server_error_page.dart    # 500
│       ├── no_internet_view.dart     # Widget to embed or full page
│       └── widgets/
│           └── error_illustration.dart # Shared SVG/Icon for errors
├── shared/                           # Global Shared Code
│   ├── ui/                           # Global UI components
│   │   ├── app_colors.dart
│   │   ├── app_text_styles.dart
│   │   └── widgets/
│   │       ├── loading_indicator.dart
│   │       └── custom_snackbar.dart
│   ├── data/                         # Global Data Layer
│   │   ├── models/
│   │   └── repositories/
│   └── util/
├── bootstrap.dart
├── main_development.dart
├── main_production.dart
└── main_staging.dart
```

## Detailed View Analysis

For each feature, the `view/` directory is split to separate **Structure** (Page) from **Layout** (View) and **Components** (Widgets).

1.  **Transaction Feature Complexity**:
    *   Since "Transaction" usually implies both a list and a set of details, I've suggested `transaction_list_view.dart` for the main list and `transaction_detail_page.dart` (plus its view) as a sub-page, potentially reachable via routing `transactions/:id`.
    *   `widgets/transaction_filter_sheet.dart`: Complex features often have bottom sheets; placing them in the feature's widget folder keeps them localized.

2.  **Login/Register Separation**:
    *   Instead of a generic `auth` folder, `login` and `register` are top-level citizens. This prevents the `view` folder from becoming cluttered with `login_form.dart`, `register_form.dart`, `forgot_password_form.dart` all mixed together.
    *   `widgets/social_login_row.dart`: A specific component likely used only in these two auth screens.

3.  **Error Handling**:
    *   `errors/view/widgets/error_illustration.dart`: A reusable widget that takes an asset path and a message, used by 404, 403, and 500 pages to maintain consistent "Edge Case" styling.
