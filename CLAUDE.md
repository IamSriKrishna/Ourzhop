# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with the **Ourzhop E-Commerce Customer Platform**.

## 🏢 PROJECT OVERVIEW

**Ourzhop E-Commerce Customer Platform** - A Flutter mobile application for customers to browse and purchase products with Clean Architecture, BLoC pattern, and enterprise-grade development standards.

**Project Status**: This is the customer-facing mobile application (`customer_app`) for the Ourzhop e-commerce platform. The app enables customers to authenticate, browse products, and make purchases through a mobile-optimized interface.

### Brand Identity
- **Primary Brand**: Purple (#8A38F5) - Innovation, Premium, Digital
- **Secondary**: Dark Gray (#17181A) - Professional, Modern
- **Font Family**: Poppins (universal for all text)
- **Design System**: Material 3 with custom enterprise theme extensions

### Core Technologies
- **Flutter**: 3.24+ (latest stable)
- **Dart**: 3.6+ (latest features)
- **State Management**: flutter_bloc 9.1.1
- **Navigation**: go_router 16.1.0
- **Dependency Injection**: get_it 8.2.0
- **HTTP Client**: dio 5.9.0 with custom interceptors
- **Local Storage**: hive 2.2.3 / hive_flutter 1.1.0
- **Localization**: English (primary) and Tamil via flutter_localizations
- **Code Generation**: freezed 3.2.0, json_serializable 6.10.0, build_runner 2.7.0
- **Additional**: pinput 5.0.1 (OTP), mi_country_picker 0.0.6, flutter_svg 2.2.0
- **Monitoring**: sentry_flutter 9.6.0 for error tracking

## 📱 DEVELOPMENT ENVIRONMENT

### Target Device Configuration
**MANDATORY**: Always use Pixel 9 Pro Android ARM64 Emulator
```bash
# Check for running emulator
flutter devices

# Launch app on Pixel 9 Pro (required)
flutter run -d "Pixel 9 Pro"

# Hot reload workflow (r) for changes
# Hot restart (R) for state reset
```

### Development Session Management
**IMPORTANT**: Respect existing debug sessions from IDE
- Work with whatever development environment is already active
- Focus on code implementation rather than session management
- Use hot reload capabilities provided by the IDE
- **NEVER restart or launch Flutter app** - only read debug console output

### Production Commands Only
```bash
# Essential development commands
flutter pub get                 # Install dependencies (or use 'make get')
make format                     # Format code and organize imports
make gen                        # Code generation for models
make analyze                    # Static analysis
make clean                      # Clean build artifacts when needed
make watch                      # Auto-rebuild during development

# Build commands (production only)
make apk                        # Build release APK (uses date timestamp)
make ios                        # Build release IPA (no codesign)

# NEVER use for development:
❌ flutter build apk           # Use 'make apk' instead
❌ flutter test               # Production code only
❌ Creating new emulators     # Use Pixel 9 Pro only
```

## 🎨 THEME SYSTEM IMPLEMENTATION

### Refactored Theme Structure
```dart
// Core colors from lib/core/themes/app_colors.dart
AppColors.primaryPurple         // #8A38F5 - Main brand
AppColors.primaryPurpleDark     // #7429E8 - Darker variant
AppColors.primaryPurpleLight    // #D1AEFF - Lighter variant
AppColors.darkGray              // #17181A - Text and accents
AppColors.mediumGray            // #61656A - Secondary text
AppColors.lightGray             // #D8D8D8 - Borders

// Theme-aware access
context.appColors               // Current theme colors
context.appTheme                // Theme extensions

// Typography from lib/core/themes/app_style.dart
AppFonts.poppins()              // Universal font with weight
AppDesignTokens.borderRadiusSmall  // 10px
AppDesignTokens.borderRadiusMedium // 17px
AppDesignTokens.borderRadiusLarge  // 50px (buttons)
```

### Theme Rules
1. **NEVER** hardcode colors - use AppColors system
2. **ALWAYS** support light/dark themes
3. **USE** AppFonts.poppins() for all text
4. **APPLY** AppDesignTokens for spacing/borders

## 🏗️ CLEAN ARCHITECTURE STRUCTURE

### Mandatory Feature Structure
```
features/[feature_name]/
├── domain/                 # Pure business logic (NO Flutter deps)
│   ├── entities/          # Business objects
│   ├── repositories/      # Abstract interfaces
│   └── usecases/         # Business operations
├── data/                 # External data handling
│   ├── datasources/      # API calls (remote/local)
│   ├── models/          # JSON serializable (.g.dart)
│   └── repositories/    # Concrete implementations
└── presentation/        # UI layer
    ├── bloc/           # State management
    ├── screens/        # Full pages
    └── widgets/        # Reusable components
```

### Core Application Structure
```
lib/
├── common/              # Shared components
│   ├── network/         # DioClient, ApiResult, error handling
│   ├── validators/      # Form validation
│   └── widget/          # Reusable widgets (app_button.dart, etc.)
├── constants/           # App constants (no magic strings/numbers)
├── core/               # Core functionality
│   ├── themes/         # AppColors, AppFonts, AppDesignTokens
│   ├── l10n/          # English/Tamil localization (.arb files)
│   ├── routes/        # Go Router configuration
│   └── services/      # Preference services
└── features/          # Feature modules (auth, home, etc.)
```

### Data Flow Pattern
```dart
Widget → BLoC → UseCase → Repository → DataSource → API
         ↑                                              ↓
     State ←  Entity  ←  Entity  ←  Model   ←  JSON
```

### Network Layer Architecture
The application uses a sophisticated network layer located in `lib/common/network/`:

- **DioClient**: Centralized HTTP client with custom interceptors
- **ApiResult<T>**: Type-safe result wrapper for API responses using freezed
- **ApiEnvelope<T>**: Standardized response envelope for all API calls
- **ApiException**: Custom exception handling for network errors
- **ApiConfig**: Configuration for API endpoints and settings

```dart
// Usage pattern in data sources
final result = await dioClient.get<ApiEnvelope<UserModel>>(
  '/api/users',
  converter: (response) => ApiEnvelope.fromJson(
    response.data, 
    (json) => UserModel.fromJson(json as Map<String, dynamic>)
  )
);

return result.fold(
  (failure) => Left(failure),
  (envelope) => Right(envelope.data)
);
```

## 📦 REUSABLE WIDGETS STRATEGY

### Widget Organization
```
lib/common/widget/
├── app_button.dart              # Primary action buttons
├── app_text_field.dart          # Form inputs with theme
├── app_dropdown.dart            # Selection fields
├── app_card.dart               # Content containers
├── app_loading_indicator.dart  # Loading states
├── app_error_display.dart      # Error states
├── app_otp_text_field.dart     # OTP input fields
└── app_*.dart                  # Other reusable components
```

### Widget Rules
- **CREATE** reusable widgets in `lib/common/widget/`
- **USE** const constructors aggressively for free performance
- **SUPPORT** both light/dark themes
- **APPLY** consistent naming: `App[Purpose]Widget`
- **FLATTEN** widget trees to avoid nesting nightmares
- **OPTIMIZE** images with caching and compression
- **LOAD** data lazily with pagination

## 🌐 LOCALIZATION REQUIREMENTS

### Bilingual Support (Mandatory)
```dart
// lib/core/l10n/app_en.arb
{
  "loginTitle": "Login",
  "welcomeMessage": "Welcome to Ourzhop Seller"
}

// lib/core/l10n/app_ta.arb
{
  "loginTitle": "உள்நுழைய",
  "welcomeMessage": "Ourzhop விற்பனையாளருக்கு வரவேற்கிறோம்"
}

// Usage in widgets
Text(AppLocalizations.of(context)!.loginTitle)
```

### Localization Rules
- **NEVER** hardcode UI strings
- **ALWAYS** add to both English and Tamil files
- **EXCLUDE** API logs and debug messages

## 📐 RESPONSIVE DESIGN REQUIREMENTS

### Screen Compatibility
All screens must work on:
- Small phones (5.0" - 5.5")
- Medium phones (5.5" - 6.0")
- Large phones (6.0" - 6.7")
- Extra large phones (6.7"+)
- Tablets (7" - 13")

### Responsive Implementation
```dart
// Use MediaQuery for adaptive layouts
final screenWidth = MediaQuery.of(context).size.width;
final padding = screenWidth < 360 ? 16.0 : 24.0;

// Figma-to-Flutter conversion helper
class ResponsiveHelper {
  static double getWidth(BuildContext context, double figmaWidth) {
    final screenWidth = MediaQuery.of(context).size.width;
    const figmaScreenWidth = 375.0; // Standard mobile design width
    return (figmaWidth / figmaScreenWidth) * screenWidth;
  }
}
```

## 🎨 FIGMA-FIRST DESIGN IMPLEMENTATION

**CRITICAL DIRECTIVE: When ANY Figma URL is provided, you MUST:**
1. **IMMEDIATELY** use `mcp__figma-framelink__get_figma_data` to extract COMPLETE design specifications
2. **ANALYZE** every single property (positions, dimensions, spacing, text properties, alignment)
3. **MAINTAIN** exact widget order and hierarchy from Figma
4. **PRESERVE** precise measurements without approximation
5. **IMPLEMENT** pixel-perfect Flutter widgets matching the design exactly

**NEVER** start coding UI without first extracting and analyzing Figma data when a design link is available.

### MCP Figma Integration
When Figma URL provided: `https://www.figma.com/file/[id]/...`

```dart
// 1. Extract design specifications with complete hierarchy
mcp__figma_framelink__get_figma_data(
  fileKey: extractedFileKey,
  nodeId: extractedNodeId,
  depth: 3, // Get complete hierarchy
);

// 2. Download optimized assets
mcp__figma_framelink__download_figma_images(
  fileKey: fileKey,
  localPath: 'assets/images/',
  pngScale: 2.0, // High-DPI support
);
```

### Mandatory Figma Processing Steps
1. **EXTRACT** complete design data with depth parameter
2. **ANALYZE** every property (position, size, spacing, order)
3. **MAP** exact values to Flutter (no approximations)
4. **MAINTAIN** precise widget order from Figma layers
5. **PRESERVE** exact spacing between elements
6. **APPLY** precise text properties (size, weight, height)
7. **IMPLEMENT** exact padding/margins
8. **DOWNLOAD** all required assets
9. **VERIFY** against design checklist

### Property Mapping
```dart
// Figma → Flutter conversion (EXACT values only)
fontSize: 18px → AppFonts.poppins(size: 18.0)
fontWeight: 500 → AppFonts.medium
color: #8A38F5 → AppColors.primaryPurple
borderRadius: 10px → AppDesignTokens.borderRadiusSmall
x: figmaX → Positioned(left: figmaX) or Alignment calculations
y: figmaY → Positioned(top: figmaY) or margin/padding
width: figmaWidth → SizedBox(width: figmaWidth) or constraints
height: figmaHeight → SizedBox(height: figmaHeight) or constraints
```

## 🏗️ IMPLEMENTED FEATURES

The application currently includes these core features:

### Auth Feature (`features/auth/`)
- **Login Screen**: Phone number authentication 
- **OTP Verification**: PIN-based OTP verification with resend timer
- **Account Setup**: Complete user profile setup with gender selection
- **Entity/Model**: User and OTP verification data structures
- **BLoC State Management**: AuthBloc with proper state management
- **Validation**: Form validation for phone numbers and OTP

### Home Feature (`features/home/`)
- **Home Screen**: Main dashboard with bottom navigation
- **Home Content**: Customer-specific content display

### Core System Features
- **Connectivity Monitoring**: Real-time network status tracking
- **Theme Management**: Light/dark theme switching with persistence
- **Localization**: English/Tamil language support
- **Bottom Navigation**: Tab-based navigation system
- **Error Handling**: Comprehensive error display and retry mechanisms

## 🔄 DEVELOPMENT WORKFLOW

### Implementation Flow
1. **Launch** Pixel 9 Pro emulator
2. **Run** app: `flutter run -d "Pixel 9 Pro"`
3. **Domain Layer** - Define entities and repositories
4. **Data Layer** - Implement models and data sources
5. **Presentation Layer** - Build BLoC and UI
6. **Hot Reload** after every change
7. **Monitor** debug console continuously
8. **Register** dependencies in service_locator.dart
9. **Add** routes to app_router.dart

## 🚀 ENTERPRISE FLUTTER PERFORMANCE PATTERNS

### Pro Performance Rules
- **const Aggressively**: All static widgets MUST use const for free performance
- **Image Optimization**: Use `cached_network_image` with placeholders and memory limits
- **Flatten Widget Trees**: Extract complex nesting into separate widgets
- **Extensions for DRY Code**: Create extensions for common operations (`.capitalize`, `.truncate`)
- **Lazy Loading**: Use `ListView.builder` and pagination for large datasets
- **Null Safety Excellence**: Avoid `!` force unwrapping, use safe defaults
- **BLoC Optimization**: Use `buildWhen` and `BlocSelector` for surgical rebuilds
- **Memory Management**: Always dispose controllers and cancel timers

### Performance Implementation Examples
```dart
// ✅ const constructors everywhere
const Text('Account Summary');
const AppButton('Submit');
const Divider(color: AppColors.lightGray);

// ✅ Optimized images with caching
CachedNetworkImage(
  imageUrl: product.imageUrl,
  placeholder: (context, url) => const AppLoadingIndicator(),
  memCacheWidth: 300,
  memCacheHeight: 300,
)

// ✅ Extensions for cleaner code
extension StringExtensions on String {
  String get capitalize => '${this[0].toUpperCase()}${substring(1)}';
}

// ✅ Safe null handling
final productName = product?.name ?? 'Unknown Product';

// ✅ Optimized BLoC rebuilds
BlocBuilder<ProductBloc, ProductState>(
  buildWhen: (previous, current) => previous.products != current.products,
  builder: (context, state) => ProductList(state.products),
)
```

### Quality Checklist
- [ ] Zero console errors
- [ ] Responsive on all screen sizes
- [ ] Light/dark theme support
- [ ] English/Tamil localization
- [ ] No hardcoded strings/colors
- [ ] const constructors used aggressively
- [ ] Clean Architecture followed
- [ ] Images optimized with caching
- [ ] Widget trees flattened
- [ ] Extensions used for DRY code
- [ ] Null safety without force unwrapping
- [ ] BLoC rebuilds optimized
- [ ] Resources properly disposed

## 📡 MCP (Model Context Protocol) INTEGRATION

### MCP Server Overview
You have access to 5 specialized MCP servers that dramatically improve development efficiency. **ALWAYS prefer MCP tools over traditional file operations.**

## 1️⃣ DART MCP - Flutter Development Operations

### Purpose
Primary tool for ALL Flutter/Dart development operations. This is your main development companion.

### When to Use
- **ALWAYS** before starting any Flutter work
- **CONTINUOUSLY** during development for analysis and formatting
- **FREQUENTLY** for package management and hot reload

### Core Commands
```dart
// Initial Setup (MANDATORY)
mcp__dart__add_roots         // Register project root first
mcp__dart__connect_dart_tooling_daemon  // Connect to Flutter tools

// Development Operations
mcp__dart__analyze_files     // Check for errors continuously
mcp__dart__dart_format       // Format code properly
mcp__dart__dart_fix         // Apply automated fixes
mcp__dart__hot_reload       // See changes instantly (primary tool)
mcp__dart__get_runtime_errors // Get console errors directly

// Package Management
mcp__dart__pub_dev_search   // Find packages before implementing
mcp__dart__pub              // Add/remove dependencies

// Code Intelligence
mcp__dart__resolve_workspace_symbol  // Find classes/methods
mcp__dart__hover            // Get documentation
mcp__dart__signature_help   // Method signatures

// Widget Inspection
mcp__dart__get_widget_tree  // Inspect widget hierarchy
mcp__dart__get_runtime_errors // Debug runtime issues
```

### Hot Reload Development Workflow
```dart
// WORKFLOW FOR EVERY CODE CHANGE:
1. Save file → Triggers hot reload automatically (IDE)
2. mcp__dart__hot_reload → Apply changes to running app
3. mcp__dart__get_runtime_errors → Check for console errors
4. BashOutput → Read debug console for any additional output
5. Visual verification in development environment
6. Fix errors immediately before next change

// DO NOT:
❌ Build APK for testing (use hot reload)
❌ Use print() for debugging (check console)
❌ Interrupt existing debug sessions
❌ Use flutter run or restart Flutter app
❌ Launch new emulator sessions
```

## 2️⃣ SERENA MCP - Semantic Code Understanding

### Purpose
Intelligent code navigation and modification without reading entire files. Saves 80-90% tokens.

### Core Commands
```dart
// Code Discovery
mcp__serena__get_symbols_overview   // See file structure (not content)
mcp__serena__find_symbol            // Locate specific classes/methods
mcp__serena__search_for_pattern     // Find patterns across codebase
mcp__serena__find_referencing_symbols // Find usage of symbols

// Code Modification
mcp__serena__replace_symbol_body    // Replace entire method/class
mcp__serena__insert_after_symbol    // Add code after symbol
mcp__serena__insert_before_symbol   // Add imports or code before

// Memory System
mcp__serena__read_memory            // Access documented patterns
mcp__serena__write_memory           // Document new patterns
```

## 3️⃣ FIGMA MCP - Design-to-Code Integration

### Purpose
**CRITICAL**: Extract COMPLETE design specifications for pixel-perfect Flutter implementation.

### Core Commands
```dart
// STEP 1: ALWAYS EXTRACT COMPLETE DESIGN DATA FIRST
mcp__figma-framelink__get_figma_data(
  fileKey: "extracted_from_url",
  nodeId: "specific_frame_id",
  depth: 3  // Get full hierarchy for complete analysis
)

// STEP 2: Download ALL visual assets
mcp__figma-framelink__download_figma_images(
  fileKey: "file_key",
  nodes: [/* ALL image/icon nodes */],
  localPath: "assets/images/",
  pngScale: 2.0  // High-DPI support
)
```

## 4️⃣ SEQUENTIAL THINKING MCP - Complex Problem Solving

### Purpose
Structured thinking for complex architectural decisions and multi-step implementations.

### Core Command
```dart
mcp__sequential-thinking__sequentialthinking(
  thought: "Current analysis step",
  thoughtNumber: 1,
  totalThoughts: 5,
  nextThoughtNeeded: true
)
```

## 5️⃣ CONTEXT7 MCP - Documentation & Best Practices

### Purpose
Access up-to-date Flutter/Dart documentation and best practices.

### Core Commands
```dart
// Find Flutter/Dart libraries
mcp__context7__resolve-library-id("flutter")
mcp__context7__resolve-library-id("bloc")

// Get documentation
mcp__context7__get-library-docs(
  context7CompatibleLibraryID: "/flutter/flutter",
  topic: "navigation"  // Optional focus area
)
```

### Integrated MCP Workflow
```yaml
1. Setup Phase:
   - Dart MCP: add_roots → connect_daemon
   - Serena: check_onboarding → read_memories
   - Verify development environment is ready

2. Design Phase (if Figma provided):
   - Figma MCP: get_figma_data → download_images
   - Sequential: plan component structure
   - Map to responsive dimensions

3. Discovery Phase:
   - Serena: search_patterns → find_symbols
   - Context7: lookup documentation
   - Check existing responsive helpers

4. Implementation Phase:
   - Serena: insert/replace symbols
   - Dart MCP: analyze → format → hot_reload
   - Monitor debug console continuously
   - Visual verification in development environment

5. Quality Phase:
   - Dart MCP: get_runtime_errors → fix issues
   - Test responsive layout
   - Dart MCP: dart_fix → analyze_files
   - Serena: write_memory (document patterns)
```

## 🎯 PRODUCTION FOCUS

### What to Build
✅ Clean Architecture features
✅ BLoC state management
✅ Responsive UI components
✅ Figma-accurate designs
✅ Theme-aware widgets
✅ Localized interfaces
✅ Error handling
✅ Performance optimization

### What NOT to Do
❌ Create test files (*_test.dart)
❌ Build APKs for development
❌ Use iOS/web/desktop targets
❌ Hardcode colors or strings
❌ Skip localization
❌ Ignore responsive design
❌ Create duplicate widgets

## 📋 SPECIALIZED AGENT

This project uses a **Flutter Frontend Architect Agent** (`flutter-frontend-architect`) for specialized Flutter development with:
- Clean Architecture expertise
- BLoC pattern implementation
- Figma design integration
- MCP server orchestration
- Responsive design optimization
- Production-ready code delivery

The agent automatically handles:
- Theme system integration
- Localization requirements
- Widget reusability
- Error handling patterns
- Performance optimization
- Hot reload workflows

## 🔧 QUICK REFERENCE

### Essential Commands
```bash
flutter devices                 # Check emulator status
flutter run -d "Pixel 9 Pro"   # Launch on target device
make format                     # Format code and organize imports
make gen                        # Generate code for models
make analyze                    # Static analysis (uses dart analyze)
make clean                      # Clean build artifacts
make get                        # Install dependencies
make watch                      # Watch mode for code generation
make upgrade                    # Upgrade dependencies with major versions
```

### Key File Locations
- Theme: `lib/core/themes/app_colors.dart`, `app_style.dart`
- Localization: `lib/core/l10n/app_en.arb`, `app_ta.arb`
- Widgets: `lib/common/widget/app_*.dart`
- Routes: `lib/core/routes/app_router.dart`
- Dependencies: `lib/service_locator.dart`

### Development Priorities
1. **Production Code Only** - No testing infrastructure
2. **Pixel 9 Pro Emulator** - Exclusive development target
3. **Responsive Design** - All screen sizes supported
4. **Theme Consistency** - Light/dark mode compatibility
5. **Localization** - English/Tamil bilingual support
6. **Clean Architecture** - Strict layer separation
7. **Performance** - Optimized, efficient code