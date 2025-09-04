# E-Commerce Seller App - Project Overview

## Purpose
This is a Flutter e-commerce seller application implementing Clean Architecture with BLoC pattern. The app includes:

- Authentication flows with OTP verification
- Localization support (English/Tamil)
- Theme management (light/dark mode)
- Connectivity monitoring
- Account setup for sellers
- Category management

## Tech Stack

### Core Framework
- **Flutter**: Mobile app framework using Dart 3.6+
- **Dart SDK**: >=3.6.0 <4.0.0

### Architecture & State Management
- **Clean Architecture**: Organized in data/domain/presentation layers
- **BLoC Pattern**: flutter_bloc (9.1.1) for state management
- **Dependency Injection**: get_it (8.2.0) service locator pattern

### Navigation & Routing
- **Go Router**: go_router (16.1.0) for declarative routing

### Network & Data
- **HTTP Client**: dio (5.9.0) for API calls
- **Local Storage**: hive/hive_flutter (2.2.3/1.1.0)
- **Connectivity**: connectivity_plus (6.1.5) for network monitoring

### Localization & UI
- **Internationalization**: flutter_localizations, intl (0.20.2)
- **Fonts**: Google Fonts (6.3.0) - Lato (headings), Poppins (body text)
- **Icons**: Font Awesome Flutter (10.9.0), Flutter SVG (2.2.0)
- **UI Components**: flutter_spinkit (5.2.2), pinput (5.0.1), mi_country_picker (0.0.6)

### Code Generation & Development
- **JSON Serialization**: json_serializable (6.10.0), json_annotation (4.9.0)
- **Code Generation**: freezed (3.2.0), build_runner (2.7.0)
- **Equality**: equatable (2.0.7)

### Utilities
- **Logging**: logger (2.6.1), sentry_flutter (9.6.0) for error tracking
- **Notifications**: fluttertoast (8.2.12)

### Development Tools
- **Linting**: flutter_lints (6.0.0)
- **Import Organization**: import_sorter (4.6.0)

## Key Features
1. Authentication with mobile OTP verification
2. Account setup for sellers
3. Category selection and management
4. Multi-language support (English/Tamil)
5. Theme switching (light/dark)
6. Offline capability detection
7. Clean error handling and logging