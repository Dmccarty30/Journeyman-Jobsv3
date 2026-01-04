# Plan: Feature-First Architecture Refactor

## Phase 1: Audit and Infrastructure [checkpoint: 50ac2e1]

- [x] Task: Audit `lib/` to map all existing files to their respective features. (af9105f)
- [x] Task: Create `lib/features/` directory structure. (059bb7f)
- [x] Task: Conductor - User Manual Verification 'Audit and Infrastructure' (Protocol in workflow.md) (50ac2e1)

## Phase 2: Core Features Migration [checkpoint: 5977340]

- [x] Task: Move `Jobs` feature components and create `lib/features/jobs/jobs.dart`. (f5983c1)
- [x] Task: Move `Storm` feature components and create `lib/features/storm/storm.dart`. (2ebf76e)
- [x] Task: Move `Unions` feature components and create `lib/features/unions/unions.dart`. (74bf702)
- [x] Task: Move `Profile` feature components and create `lib/features/profile/profile.dart`. (70e2840)
- [x] Task: Conductor - User Manual Verification 'Core Features Migration' (Protocol in workflow.md) (5977340)

## Phase 3: Auth and Navigation Migration [checkpoint: 3ea6e49]

- [x] Task: Move `Authentication` components and create `lib/features/auth/auth.dart`. (f6bb3e7)
- [x] Task: Move `Navigation` (go_router setup) to `lib/features/navigation/`. (18f761a)
- [x] Task: Conductor - User Manual Verification 'Auth and Navigation Migration' (Protocol in workflow.md) (3ea6e49)

## Phase 4: Final Cleanup and Global Verification

- [x] Task: Update all project imports to use barrel files. (9db86ba)
- [x] Task: Remove empty legacy directories (`lib/screens`, `lib/models`, `lib/widgets`, `lib/services`, `lib/providers`). (ca2afd8)
- [~] Task: Execute full test suite and verify >80% coverage.
- [ ] Task: Conductor - User Manual Verification 'Final Cleanup and Global Verification' (Protocol in workflow.md)
