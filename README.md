# Digi Lawyer

Skill Swap is an innovative mobile application that enables individuals to connect and exchange skills in a secure and user-friendly environment.

## Getting Started

This project uses the flutter and dart versions as mentioned below.

```bash

┌─────────┬─────────┬─────────────────┬──────────────┬──────────────┬
│ Version │ Channel │ Flutter Version │ Dart Version │ Release Date │
├─────────┼─────────┼─────────────────┼──────────────┼──────────────┼
│ stable  │ stable  │ 3.35.4          │ 3.9.2        │ Sep 16, 2025 │
└─────────┴─────────┴─────────────────┴──────────────┴──────────────┴

```

## 📂 Folder Structure

This project follows a structured and modular folder organization to ensure scalability and maintainability.

```bash
lib
├── common               # Shared utilities and UI components
│   ├── styles           # Global styles
│   ├── widgets          # Reusable widgets like buttons, providers
├── data                 # Data layer (repositories, services)
│   ├── repositories     # Handles data fetching and storage logic
│   ├── services         # API and service-related classes
├── features             # Feature-specific modules
│   ├── homepage         # Homepage-related UI and logic
├── localization         # Handles app localization
│   ├── app_localization.dart  # Localization helper functions
│   ├── en.json          # English translations
│   ├── ne.json          # Nepali translations
├── utils                # Utility functions and constants
│   ├── constants        # App-wide constant values (API, colors, sizes, etc.)
│   ├── device           # Device-related utilities
│   ├── formatters       # Formatting-related utilities
│   ├── helpers          # General helper functions (toast, localization, notifications)
├── http                 # Network and API-related logic
│   ├── dio_client.dart  # Dio-based HTTP client
│   ├── http_client.dart # Generic HTTP client
├── local_storage        # Handles local data storage
│   ├── localization_storage.dart  # Stores localization preferences
│   ├── theme_storage.dart         # Stores theme preferences
├── theme                # Theme-related configurations
│   ├── custom           # Custom theme components
│   ├── text_theme.dart  # Text style definitions
│   ├── theme.dart       # Global theme settings
├── validators           # Input validation logic
├── app.dart             # Main application entry point
├── main.dart            # Flutter app startup file
```

## ⚒️ How to Contribute

1. Clone the repository.
2. Create a new branch for your feature.
3. Follow the folder structure conventions.
4. Submit a pull request with your changes.

## 📌 Notes

- Add documentation/comments for better maintainability.
- Ensure translations are added in the `localization/` folder and append locale in `helper/localization_manager.dart`
