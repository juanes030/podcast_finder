<!-- GitHub Copilot / AI agent instructions for PodcastFinder -->
# PodcastFinder — AI Assistant Guidance

Purpose: help AI coding agents be immediately productive in this repository.

- **Big picture**: This is a Flutter mobile app using a feature-first architecture. See [README.md](README.md) for the layout. Key folders:
  - `lib/core/` — shared infra: `network/`, `router/`, `theme/`, `utils/`.
  - `lib/features/` — features grouped by domain (e.g., `home`).
  - `lib/main.dart` — app entry.

- **Key libraries & patterns** (see `pubspec.yaml`):
  - State: `flutter_riverpod` — prefer `Provider`, `StateNotifierProvider` and `ConsumerWidget` patterns.
  - Networking: `dio` with a configured `dioProvider` and a MockInterceptor (README notes mock responses).
  - Serialization: `json_serializable` — models use `part 'x.g.dart'` and `@JsonSerializable()` annotations.
  - Routing: `go_router` — central router under `lib/core/router`.

- **Project-specific conventions** (follow these exactly):
  - Feature-first layout: data/domain/presentation inside each feature directory.
  - Naming: models end with `Model` (e.g., `PodcastModel`). Screens end with `Screen` (e.g., `SearchScreen`). Notifiers use `Notifier` suffix (e.g., `SearchNotifier`). Providers use lowerCamelCase with `Provider` suffix (e.g., `searchPodcastsProvider`).
  - Generated files: `.g.dart` files exist in repo; when adding/modifying models, run codegen (see below).

- **Where to look first when asked about behavior**:
  - Networking flow and error handling: `lib/core/network/` (interceptors, exceptions).
  - State and use-cases: `lib/features/<feature>/presentation/` and providers in that feature.
  - UI references and designs: `designs/search_screen.md` and `designs/detail_screen.md`.

- **Build / run / test commands** (copy-pasteable):
  - Install deps: `flutter pub get`
  - Generate models: `dart run build_runner build --delete-conflicting-outputs`
  - Run app: `flutter run`
  - Run tests: `flutter test`
  - If codegen fails: `flutter clean && rm -rf .dart_tool && flutter pub get && dart run build_runner build --delete-conflicting-outputs`

- **Networking notes for AI**:
  - The app uses a MockInterceptor so API calls via the app's `dioProvider` will return deterministic mock data. No API keys needed. When proposing code that calls the network, prefer using the existing `dioProvider` and not creating ad-hoc Dio instances.

- **Code generation expectations**:
  - When adding/modifying models, include the `part 'name.g.dart';` and `@JsonSerializable()` annotation. Include the generated `.g.dart` or run the build_runner command above.

- **Testing guidance**:
  - Unit tests should target provider/notifier logic and model (de)serialization. See `test/example_test.dart` for style.
  - Use `ProviderContainer` for provider unit tests.

- **PR & commit guidance for AI contributions**:
  - Make small, focused commits with clear messages (e.g., "Add podcast search with debounced provider").
  - In PR description, include which ticket in `TICKETS.md` was implemented and list the acceptance criteria satisfied.

- **Example snippets / idioms from this repo**:
  - Provider creation:
    ```dart
    final searchPodcastsProvider = StateNotifierProvider<SearchNotifier, SearchState>((ref) {
      return SearchNotifier(ref.read);
    });
    ```
  - Model skeleton (follow exactly):
    ```dart
    @JsonSerializable()
    class PodcastModel { // fields... }
    ```

- **When to ask for clarification (what AI should request from a human)**:
  - If a design detail in `designs/*` is ambiguous (colors, spacing), ask the reviewer which variant to follow.
  - If a proposed change touches multiple features or global providers, request explicit approval before modifying shared infra under `lib/core/`.

If this file needs more detail (e.g., file-level pointers to `dioProvider` or specific provider names), tell me which areas to expand and I'll update the guidance.
