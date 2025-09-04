#───────────────────────────────────────────────────────────────
#  Makefile – Flutter shortcuts (Dart 3.6 compatible)
#───────────────────────────────────────────────────────────────

APP_NAME = customer_app

# 0. CLEAN & CACHE TARGETS ─────────────────────────────────────
clean:              ## Delete build/ and .dart_tool
	flutter clean
	@echo "✅ build/ cleaned."

cache-clean:        ## Remove entire ~/.pub-cache (re-run 'make get' after)
	dart pub cache clean
	@echo "🔥 pub-cache deleted."

analysis-cache-clear: ## Clear IDE analysis-driver cache
	rm -rf ~/.dartServer/.analysis-driver/*
	@echo "✅ analysis-driver cache cleared."

clean-all: clean cache-clean analysis-cache-clear ## Full scrub

# 1. DEPENDENCIES ──────────────────────────────────────────────
get:                ## flutter pub get
	flutter pub get

upgrade:            ## flutter pub upgrade --major-versions
	flutter pub upgrade --major-versions

# 2. BUILD / RUN ───────────────────────────────────────────────
run:                ## Run on all connected devices
	flutter run -d all

apk:                ## Build release APK
	flutter build apk --release --build-number=$$(date +%s)

ios:                ## Build release IPA (no codesign)
	flutter build ipa --release --no-codesign

# 3. CODE-GEN ─────────────────────────────────────────────────
gen:                ## One-shot code generation
	flutter pub run build_runner build --delete-conflicting-outputs

watch:              ## Code-gen in watch mode
	flutter pub run build_runner watch --delete-conflicting-outputs

# 4. STATIC CHECKS ────────────────────────────────────────────
analyze:            ## dart analyze
	dart analyze

sort:               ## Organise imports with import_sorter
	flutter pub run import_sorter:main lib/* test/*

format: sort        ## dart format after sorting imports
	dart format .

test:               ## Run flutter tests with coverage
	flutter test --coverage

# 5. PHONY TARGETS ────────────────────────────────────────────
.PHONY: clean cache-clean analysis-cache-clear clean-all \
        get upgrade run apk ios gen watch analyze sort format test
