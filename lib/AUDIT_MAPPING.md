# Architecture Audit Mapping

This document maps existing files to their new locations in the Feature-First Architecture.

## Features

### Crews (Done/In Progress)
- `lib/features/crews/` (Keep and refine)

### Jobs
- **Models:**
  - `lib/models/job_model.dart`
  - `lib/models/job_suggestion_model.dart`
  - `lib/models/job_summary_model.dart`
  - `lib/models/jobs_record.dart` (Legacy)
- **Providers:**
  - `lib/providers/riverpod/jobs_riverpod_provider.dart`
  - `lib/providers/riverpod/job_filter_riverpod_provider.dart`
  - `lib/providers/riverpod/job_recommendation_provider.dart`
  - `lib/providers/riverpod/user_job_preference_query_provider.dart`
- **Screens:**
  - `lib/screens/jobs/`
- **Widgets:**
  - `lib/widgets/condensed_job_card.dart`
  - `lib/widgets/job_card_skeleton.dart`
  - `lib/widgets/job_details_dialog.dart`
  - `lib/widgets/optimized_job_card.dart`
  - `lib/widgets/rich_text_job_card.dart`
  - `lib/widgets/virtual_job_list.dart`
  - `lib/widgets/job_suggestions/`
- **Services:**
  - `lib/data/repositories/job_repository*`
- **Domain:**
  - `lib/domain/use_cases/get_jobs_use_case.dart`

### Storm
- **Models:**
  - `lib/models/storm_event.dart`
  - `lib/models/storm_track.dart`
- **Screens:**
  - `lib/screens/storm/`
- **Services:**
  - `lib/screens/storm/services/`
- **Widgets:**
  - `lib/screens/storm/widgets/`

### Unions (Locals)
- **Models:**
  - `lib/models/locals_record.dart`
- **Providers:**
  - `lib/providers/riverpod/locals_riverpod_provider.dart`
- **Screens:**
  - `lib/screens/locals/`

### Profile
- **Models:**
  - `lib/models/user_model.dart`
  - `lib/models/users_record.dart`
- **Screens:**
  - `lib/screens/settings/account/profile_screen.dart`
- **Services:**
  - `lib/services/avatar_service.dart`

### Auth
- **Screens:**
  - `lib/screens/auth/`
  - `lib/screens/onboarding/auth_screen.dart`
- **Services:**
  - `lib/services/auth_service.dart`
- **Providers:**
  - `lib/providers/riverpod/auth_riverpod_provider.dart`

### Onboarding
- **Screens:**
  - `lib/screens/onboarding/` (excluding auth)
- **Services:**
  - `lib/services/onboarding_service.dart`

### Navigation
- `lib/navigation/`
- `lib/screens/nav_bar_page.dart`

### Tools (Calculators / Transformer)
- **Screens:**
  - `lib/screens/tools/`
  - `lib/screens/settings/support/calculators/`
- **Models:**
  - `lib/models/transformer_models.dart`

## Core / Shared

### Design System
- `lib/design_system/`
- `lib/electrical_components/` (Consider moving to `lib/design_system/electrical/`)

### Infrastructure
- `lib/services/analytics_service.dart`
- `lib/services/database_service.dart`
- `lib/services/firestore_service.dart`
- `lib/services/fcm_service.dart`
- `lib/services/connectivity_service.dart`
- `lib/services/location_service.dart`
- `lib/services/storage_service.dart`
- `lib/services/performance_monitoring_service.dart`
- `lib/services/cache_service.dart`
- `lib/services/offline_data_service.dart`
- `lib/providers/core_providers.dart`

### Utils
- `lib/utils/`
- `lib/domain/utils/`
- `lib/domain/exceptions/`
- `lib/domain/enums/`
