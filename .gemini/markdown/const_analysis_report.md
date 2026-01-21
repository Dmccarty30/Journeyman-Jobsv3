# Const Optimization Analysis Report

**Generated:** 2026-01-21 01:14:01  
**Total Files Analyzed:** 335  
**Total Opportunities:** 1223

## Executive Summary

This report identifies opportunities to add `const` constructors throughout the Flutter codebase.
Adding `const` to immutable widgets reduces rebuilds and improves performance.

## Findings by Category

### Text Widgets (551 opportunities)

#### `lib\core\services\notification_permission_service.dart` (4 instances)

- [ ] **Line 90:** `Text(`
- [ ] **Line 168:** `Text(`
- [ ] **Line 250:** `Text(`
- [ ] **Line 258:** `Text(`

#### `lib\core\widgets\message_bubble.dart` (3 instances)

- [ ] **Line 39:** `Text(`
- [ ] **Line 47:** `Text(`
- [ ] **Line 54:** `Text(`

#### `lib\core\widgets\notification_badge.dart` (1 instances)

- [ ] **Line 188:** `Text(`

#### `lib\core\widgets\notification_popup.dart` (4 instances)

- [ ] **Line 247:** `Text(`
- [ ] **Line 255:** `Text(`
- [ ] **Line 292:** `Text(`
- [ ] **Line 303:** `Text(`

#### `lib\core\widgets\offline_indicator.dart` (8 instances)

- [ ] **Line 92:** `Text(`
- [ ] **Line 99:** `Text(`
- [ ] **Line 146:** `Text(`
- [ ] **Line 154:** `Text(`
- [ ] **Line 191:** `Text(`
- [ ] **Line 251:** `Text(`
- [ ] **Line 343:** `Text('Sync failed: ${e.toString()}'),`
- [ ] **Line 390:** `Text(`

#### `lib\core\widgets\offline_indicators.dart` (8 instances)

- [ ] **Line 47:** `Text(`
- [ ] **Line 192:** `Text(`
- [ ] **Line 256:** `Text(`
- [ ] **Line 305:** `Text(`
- [ ] **Line 459:** `Text(`
- [ ] **Line 505:** `Text(`
- [ ] **Line 509:** `Text(`
- [ ] **Line 519:** `Text(`

#### `lib\core\widgets\optimized_virtual_job_list.dart` (6 instances)

- [ ] **Line 309:** `Text(`
- [ ] **Line 335:** `Text(`
- [ ] **Line 343:** `Text(`
- [ ] **Line 371:** `Text(`
- [ ] **Line 379:** `Text(`
- [ ] **Line 481:** `Text(`

#### `lib\design_system\tailboard_components.dart` (7 instances)

- [ ] **Line 35:** `Text(`
- [ ] **Line 49:** `Text(`
- [ ] **Line 93:** `Text(`
- [ ] **Line 146:** `Text(`
- [ ] **Line 152:** `Text(`
- [ ] **Line 194:** `Text(`
- [ ] **Line 279:** `Text(`

#### `lib\design_system\components\job_card.dart` (6 instances)

- [ ] **Line 109:** `Text(`
- [ ] **Line 178:** `Text(`
- [ ] **Line 200:** `Text(`
- [ ] **Line 278:** `Text(`
- [ ] **Line 430:** `Text(`
- [ ] **Line 440:** `Text(`

#### `lib\design_system\components\reusable_components.dart` (8 instances)

- [ ] **Line 88:** `Text(`
- [ ] **Line 136:** `Text(`
- [ ] **Line 244:** `Text(`
- [ ] **Line 306:** `Text(`
- [ ] **Line 313:** `Text(`
- [ ] **Line 483:** `Text(`
- [ ] **Line 623:** `Text(`
- [ ] **Line 634:** `Text(`

#### `lib\design_system\electrical\electrical_illustrations_example.dart` (4 instances)

- [ ] **Line 87:** `Text(`
- [ ] **Line 132:** `Text(`
- [ ] **Line 170:** `Text(`
- [ ] **Line 176:** `Text(`

#### `lib\design_system\electrical\electrical_rotation_meter.dart` (1 instances)

- [ ] **Line 99:** `Text(`

#### `lib\design_system\electrical\jj_contractor_card.dart` (4 instances)

- [ ] **Line 50:** `Text(`
- [ ] **Line 55:** `Text(`
- [ ] **Line 61:** `Text(`
- [ ] **Line 111:** `Text(`

#### `lib\design_system\electrical\jj_electrical_toast.dart` (1 instances)

- [ ] **Line 335:** `Text(`

#### `lib\design_system\electrical\jj_power_line_loader.dart` (1 instances)

- [ ] **Line 115:** `Text(`

#### `lib\design_system\electrical\transformer_trainer\jj_transformer_trainer.dart` (8 instances)

- [ ] **Line 231:** `Text(`
- [ ] **Line 238:** `Text(`
- [ ] **Line 246:** `Text(`
- [ ] **Line 280:** `Text(`
- [ ] **Line 293:** `Text(`
- [ ] **Line 306:** `Text(`
- [ ] **Line 353:** `Text(`
- [ ] **Line 391:** `Text(`

#### `lib\design_system\electrical\transformer_trainer\modes\guided_mode.dart` (7 instances)

- [ ] **Line 92:** `Text(`
- [ ] **Line 130:** `Text(`
- [ ] **Line 135:** `Text(`
- [ ] **Line 163:** `Text(step.safetyNote!),`
- [ ] **Line 195:** `Text(step.commonMistake!),`
- [ ] **Line 231:** `Text(description),`
- [ ] **Line 348:** `Text(`

#### `lib\design_system\electrical\transformer_trainer\modes\quiz_mode.dart` (12 instances)

- [ ] **Line 103:** `Text(`
- [ ] **Line 197:** `Text(`
- [ ] **Line 214:** `Text(`
- [ ] **Line 222:** `Text(`
- [ ] **Line 392:** `Text(`
- [ ] **Line 400:** `Text(`
- [ ] **Line 420:** `Text(`
- [ ] **Line 491:** `Text(`
- [ ] **Line 502:** `Text(`
- [ ] **Line 519:** `Text(`
- [ ] **Line 527:** `Text(`
- [ ] **Line 534:** `Text(`

#### `lib\design_system\electrical\transformer_trainer\widgets\mobile_ui_patterns.dart` (7 instances)

- [ ] **Line 53:** `Text(`
- [ ] **Line 100:** `Text(`
- [ ] **Line 147:** `Text(`
- [ ] **Line 160:** `Text(`
- [ ] **Line 194:** `Text(`
- [ ] **Line 233:** `Text(`
- [ ] **Line 618:** `Text(`

#### `lib\design_system\electrical\transformer_trainer\widgets\trainer_widget.dart` (7 instances)

- [ ] **Line 197:** `Text(`
- [ ] **Line 240:** `Text(`
- [ ] **Line 247:** `Text(`
- [ ] **Line 253:** `Text(`
- [ ] **Line 260:** `Text(`
- [ ] **Line 266:** `Text(`
- [ ] **Line 273:** `Text(`

#### `lib\design_system\widgets\buttons\jj_button.dart` (1 instances)

- [ ] **Line 72:** `Text(`

#### `lib\features\auth\screens\auth_screen.dart` (2 instances)

- [ ] **Line 300:** `Text(`
- [ ] **Line 309:** `Text(`

#### `lib\features\auth\screens\forgot_password_screen.dart` (5 instances)

- [ ] **Line 122:** `Text(`
- [ ] **Line 131:** `Text(`
- [ ] **Line 269:** `Text(`
- [ ] **Line 328:** `Text(`
- [ ] **Line 338:** `Text(`

#### `lib\features\auth\screens\welcome_screen.dart` (3 instances)

- [ ] **Line 145:** `Text(`
- [ ] **Line 169:** `Text(`
- [ ] **Line 194:** `Text(`

#### `lib\features\crews\screens\create_crew_screen.dart` (1 instances)

- [ ] **Line 174:** `Text('Minimum Hourly Rate: \$$_minHourlyRate'),`

#### `lib\features\crews\screens\crew_onboarding_screen.dart` (3 instances)

- [ ] **Line 47:** `Text(`
- [ ] **Line 66:** `Text(`
- [ ] **Line 86:** `Text(`

#### `lib\features\crews\screens\join_crew_screen.dart` (2 instances)

- [ ] **Line 86:** `Text(`
- [ ] **Line 95:** `Text(`

#### `lib\features\crews\screens\tailboard_screen.dart` (4 instances)

- [ ] **Line 813:** `Text('Job Preferences', style: TailboardTheme.bodyMedium),`
- [ ] **Line 1028:** `Text(`
- [ ] **Line 1034:** `Text(`
- [ ] **Line 1117:** `Text(`

#### `lib\features\crews\widgets\activity_card.dart` (2 instances)

- [ ] **Line 59:** `Text(`
- [ ] **Line 67:** `Text(`

#### `lib\features\crews\widgets\announcement_card.dart` (6 instances)

- [ ] **Line 56:** `Text(`
- [ ] **Line 86:** `Text(`
- [ ] **Line 94:** `Text(`
- [ ] **Line 104:** `Text(`
- [ ] **Line 156:** `Text(`
- [ ] **Line 187:** `Text(`

#### `lib\features\crews\widgets\chat_components.dart` (3 instances)

- [ ] **Line 105:** `Text(`
- [ ] **Line 114:** `Text(`
- [ ] **Line 273:** `Text(`

#### `lib\features\crews\widgets\comment_animation.dart` (1 instances)

- [ ] **Line 173:** `Text(`

#### `lib\features\crews\widgets\comment_input.dart` (2 instances)

- [ ] **Line 101:** `Text(`
- [ ] **Line 146:** `Text(`

#### `lib\features\crews\widgets\comment_item.dart` (4 instances)

- [ ] **Line 78:** `Text(`
- [ ] **Line 86:** `Text(`
- [ ] **Line 105:** `Text(`
- [ ] **Line 129:** `Text(`

#### `lib\features\crews\widgets\comment_thread.dart` (1 instances)

- [ ] **Line 87:** `Text(`

#### `lib\features\crews\widgets\crew_member_avatar.dart` (4 instances)

- [ ] **Line 141:** `Text(`
- [ ] **Line 151:** `Text(`
- [ ] **Line 159:** `Text(`
- [ ] **Line 166:** `Text(`

#### `lib\features\crews\widgets\crew_preferences_dialog.dart` (13 instances)

- [ ] **Line 165:** `Text(`
- [ ] **Line 173:** `Text(`
- [ ] **Line 230:** `Text(`
- [ ] **Line 287:** `Text(`
- [ ] **Line 343:** `Text(`
- [ ] **Line 351:** `Text(`
- [ ] **Line 412:** `Text(`
- [ ] **Line 420:** `Text(`
- [ ] **Line 477:** `Text(`
- [ ] **Line 519:** `Text(`
- [ ] **Line 527:** `Text(`
- [ ] **Line 536:** `Text(`
- [ ] **Line 560:** `Text(`

#### `lib\features\crews\widgets\dm_preview_card.dart` (1 instances)

- [ ] **Line 114:** `Text(`

#### `lib\features\crews\widgets\dynamic_container_row.dart` (1 instances)

- [ ] **Line 232:** `Text(`

#### `lib\features\crews\widgets\job_match_card.dart` (4 instances)

- [ ] **Line 77:** `Text(`
- [ ] **Line 91:** `Text(`
- [ ] **Line 99:** `Text(`
- [ ] **Line 173:** `Text(`

#### `lib\features\crews\widgets\message_bubble.dart` (2 instances)

- [ ] **Line 109:** `Text(`
- [ ] **Line 118:** `Text(`

#### `lib\features\crews\widgets\post_card.dart` (5 instances)

- [ ] **Line 201:** `Text(`
- [ ] **Line 209:** `Text(`
- [ ] **Line 286:** `Text(`
- [ ] **Line 394:** `Text(`
- [ ] **Line 409:** `Text(`

#### `lib\features\crews\widgets\realtime_summary_feed.dart` (3 instances)

- [ ] **Line 32:** `Text(`
- [ ] **Line 38:** `Text(`
- [ ] **Line 43:** `Text(`

#### `lib\features\crews\widgets\tab_widgets.dart` (4 instances)

- [ ] **Line 317:** `Text(`
- [ ] **Line 324:** `Text(`
- [ ] **Line 769:** `Text(`
- [ ] **Line 776:** `Text(`

#### `lib\features\crews\widgets\tailboard\apply_job_dialog.dart` (1 instances)

- [ ] **Line 88:** `Text(`

#### `lib\features\crews\widgets\tailboard\classification_filter_dialog.dart` (2 instances)

- [ ] **Line 147:** `Text(`
- [ ] **Line 157:** `Text(`

#### `lib\features\crews\widgets\tailboard\feed_sort_options_dialog.dart` (2 instances)

- [ ] **Line 136:** `Text(`
- [ ] **Line 146:** `Text(`

#### `lib\features\crews\widgets\tailboard\job_preferences_dialog.dart` (1 instances)

- [ ] **Line 241:** `Text(`

#### `lib\features\crews\widgets\tailboard\member_availability_dialog.dart` (3 instances)

- [ ] **Line 133:** `Text(`
- [ ] **Line 205:** `Text(`
- [ ] **Line 213:** `Text(`

#### `lib\features\crews\widgets\tailboard\member_roles_dialog.dart` (2 instances)

- [ ] **Line 179:** `Text(`
- [ ] **Line 205:** `Text(`

#### `lib\features\crews\widgets\tailboard\member_roster_dialog.dart` (4 instances)

- [ ] **Line 107:** `Text(`
- [ ] **Line 114:** `Text(`
- [ ] **Line 120:** `Text(`
- [ ] **Line 141:** `Text(`

#### `lib\features\jobs\profile\screens\home_screen.dart` (13 instances)

- [x] **Line 85:** `Text(`
- [x] **Line 121:** `Text(`
- [x] **Line 129:** `Text(`
- [x] **Line 168:** `Text(`
- [x] **Line 176:** `Text(`
- [x] **Line 185:** `Text(`
- [x] **Line 211:** `Text(`
- [x] **Line 219:** `Text(`
- [x] **Line 236:** `Text(`
- [x] **Line 298:** `Text(`
- [x] **Line 316:** `Text(`
- [x] **Line 360:** `Text(`
- [x] **Line 389:** `Text(`

#### `lib\features\jobs\profile\screens\onboarding_steps_screen.dart" (16 instances)

- [x] **Line 474:** `Text(`
- [x] **Line 682:** `Text(`
- [x] **Line 801:** `Text(`
- [x] **Line 806:** `Text(`
- [x] **Line 924:** `Text(`
- [x] **Line 929:** `Text(`
- [x] **Line 959:** `Text(`
- [x] **Line 964:** `Text(`
- [x] **Line 1003:** `Text(`
- [x] **Line 1008:** `Text(`
- [x] **Line 1062:** `Text(`
- [x] **Line 1067:** `Text(`
- [x] **Line 1082:** `Text('Network with Others', style: AppTheme.bodyMedium),`
- [x] **Line 1150:** `Text('Find Long-term Work', style: AppTheme.bodyMedium),`
- [x] **Line 1237:** `Text(`
- [x] **Line 1243:** `Text(`

#### `lib\features\jobs\profile\screens\profile_screen.dart" (22 instances)

- [x] **Line 593:** `Text(`
- [x] **Line 602:** `Text(`
- [x] **Line 751:** `Text(`
- [x] **Line 760:** `Text(`
- [x] **Line 768:** `Text(`
- [x] **Line 841:** `Text(`
- [x] **Line 887:** `Text(`
- [x] **Line 959:** `Text(`
- [x] **Line 981:** `Text(`
- [x] **Line 1021:** `Text(`
- [x] **Line 1079:** `Text(`
- [x] **Line 1088:** `Text(`
- [x] **Line 1251:** `Text(`
- [x] **Line 1279:** `Text(`
- [x] **Line 1318:** `Text(`
- [x] **Line 1350:** `Text(`
- [x] **Line 1470:** `Text(`
- [x] **Line 1476:** `Text(`
- [x] **Line 1528:** `Text(`
- [x] **Line 1535:** `Text(`
- [x] **Line 1575:** `Text(`
- [x] **Line 1582:** `Text(`

#### `lib\features\jobs\profile\screens\training_certificates_screen.dart" (25 instances)

- [x] **Line 296:** `Text(`
- [x] **Line 303:** `Text(`
- [x] **Line 345:** `Text(`
- [x] **Line 353:** `Text(`
- [x] **Line 407:** `Text(`
- [x] **Line 432:** `Text(`
- [x] **Line 472:** `Text(`
- [x] **Line 479:** `Text(`
- [x] **Line 594:** `Text(`
- [x] **Line 602:** `Text(`
- [x] **Line 631:** `Text(`
- [x] **Line 729:** `Text(`
- [x] **Line 736:** `Text(`
- [x] **Line 803:** `Text(`
- [x] **Line 810:** `Text(`
- [x] **Line 822:** `Text(`
- [x] **Line 830:** `Text(`
- [x] **Line 836:** `Text(`
- [x] **Line 890:** `Text(`
- [x] **Line 905:** `Text(`
- [x] **Line 1011:** `Text(`
- [x] **Line 1019:** `Text(`
- [x] **Line 1028:** `Text(`
- [x] **Line 1034:** `Text(`
- [x] **Line 1040:** `Text(`

#### `lib\features\jobs\screens\jobs_screen.dart" (6 instances)

- [x] **Line 176:** `Text(`
- [x] **Line 249:** `Text(`
- [x] **Line 256:** `Text(`
- [x] **Line 287:** `Text(`
- [x] **Line 294:** `Text(`
- [x] **Line 354:** `Text(`

#### `lib\features\jobs\widgets\job_details_dialog.dart" (4 instances)

- [x] **Line 116:** `Text(`
- [x] **Line 125:** `Text(`
- [x] **Line 211:** `Text(`
- [x] **Line 238:** `Text(`

#### `lib\features\jobs\widgets\job_suggestion_card.dart" (3 instances)

- [x] **Line 29:** `Text(`
- [x] **Line 34:** `Text(`
- [x] **Line 39:** `Text(`

#### `lib\features\jobs\widgets\optimized_job_card.dart" (5 instances)

- [x] **Line 28:** `Text(`
- [x] **Line 38:** `Text(JobDataFormatter.formatLocation(job.location)),`
- [x] **Line 46:** `Text(JobDataFormatter.formatCompany(job.company)),`
- [x] **Line 54:** `Text(JobDataFormatter.formatClassification(`
- [x] **Line 64:** `Text('\$${job.wage}/hr'),`

#### `lib\features\jobs\widgets\rich_text_job_card.dart" (1 instances)

- [x] **Line 169:** `Text(`

#### `lib\features\jobs\widgets\virtual_job_list.dart" (8 instances)

- [x] **Line 245:** `Text(`
- [x] **Line 329:** `Text(`
- [x] **Line 366:** `Text(`
- [x] **Line 373:** `Text(`
- [x] **Line 396:** `Text(`
- [x] **Line 404:** `Text(`
- [x] **Line 438:** `Text(`
- [x] **Line 446:** `Text(`

#### `lib\features\navigation\screens\splash_screen.dart" (4 instances)

- [x] **Line 303:** `Text(`
- [x] **Line 317:** `Text(`
- [x] **Line 332:** `Text(`
- [x] **Line 362:** `Text(`

#### `lib\features\navigation\services\app_router.dart" (2 instances)

- [x] **Line 246:** `Text(`
- [x] **Line 251:** `Text(`

#### `lib\features\settings\screens\appearance_display_screen.dart" (2 instances)

- [x] **Line 162:** `Text(title, style: AppTheme.titleMedium),`
- [x] **Line 163:** `Text(`

#### `lib\features\settings\screens\app_settings_screen.dart" (5 instances)

- [x] **Line 326:** `Text(`
- [x] **Line 333:** `Text(`
- [x] **Line 404:** `Text(`
- [x] **Line 411:** `Text(`
- [x] **Line 469:** `Text(`

#### `lib\features\settings\screens\data_storage_screen.dart" (4 instances)

- [x] **Line 145:** `Text('Clear Cache', style: AppTheme.titleMedium),`
- [x] **Line 146:** `Text(`
- [x] **Line 207:** `Text(title, style: AppTheme.titleMedium),`
- [x] **Line 208:** `Text(`

#### `lib\features\settings\screens\feedback_screen.dart" (4 instances)

- [x] **Line 147:** `Text(`
- [x] **Line 154:** `Text(`
- [x] **Line 177:** `Text(`
- [x] **Line 186:** `Text(`

#### `lib\features\settings\screens\help_support_screen.dart" (12 instances)

- [x] **Line 252:** `Text(`
- [x] **Line 259:** `Text(`
- [x] **Line 292:** `Text(`
- [x] **Line 301:** `Text(`
- [x] **Line 308:** `Text(`
- [x] **Line 331:** `Text(`
- [x] **Line 494:** `Text(`
- [x] **Line 503:** `Text(`
- [x] **Line 563:** `Text(`
- [x] **Line 571:** `Text(`
- [x] **Line 666:** `Text(`
- [x] **Line 673:** `Text(`

#### `lib\features\settings\screens\job_search_preferences_screen.dart" (4 instances)

- [x] **Line 188:** `Text(`
- [x] **Line 195:** `Text(`
- [x] **Line 316:** `Text(`
- [x] **Line 323:** `Text(`

#### `lib\features\settings\screens\notifications_settings_screen.dart" (15 instances)

- [x] **Line 178:** `Text(`
- [x] **Line 187:** `Text(`
- [x] **Line 412:** `Text(`
- [x] **Line 490:** `Text(`
- [x] **Line 500:** `Text(`
- [x] **Line 700:** `Text(`
- [x] **Line 785:** `Text(`
- [x] **Line 825:** `Text(`
- [x] **Line 891:** `Text(`
- [x] **Line 899:** `Text(`
- [x] **Line 959:** `Text(`
- [x] **Line 967:** `Text(`
- [x] **Line 1032:** `Text(`
- [x] **Line 1040:** `Text(`
- [x] **Line 1079:** `Text(`

#### `lib\features\settings\screens\privacy_security_screen.dart" (2 instances)

- [x] **Line 179:** `Text(`
- [x] **Line 186:** `Text(`

#### `lib\features\settings\screens\resources_screen.dart" (3 instances)

- [x] **Line 423:** `Text(`
- [x] **Line 431:** `Text(`
- [x] **Line 551:** `Text(`

#### `lib\features\settings\screens\settings_screen.dart" (9 instances)

- [x] **Line 114:** `Text(`
- [x] **Line 131:** `Text(`
- [x] **Line 354:** `Text(`
- [x] **Line 362:** `Text(`
- [x] **Line 408:** `Text(`
- [x] **Line 424:** `Text(`
- [x] **Line 431:** `Text(`
- [x] **Line 464:** `Text(`
- [x] **Line 473:** `Text(`

#### `lib\features\settings\screens\sync_settings_screen.dart" (18 instances)

- [x] **Line 164:** `Text(`
- [x] **Line 251:** `Text(title),`
- [x] **Line 271:** `Text(title),`
- [x] **Line 298:** `Text(`
- [x] **Line 377:** `Text(`
- [x] **Line 392:** `Text(`
- [x] **Line 399:** `Text(`
- [x] **Line 439:** `Text(success ? 'Sync completed successfully' : 'Sync failed'),`
- [x] **Line 554:** `Text('The following changes are waiting to sync:'),`
- [x] **Line 556:** `Text('â€¢ Job bookmarks'),`
- [x] **Line 557:** `Text('â€¢ User preferences'),`
- [x] **Line 558:** `Text('â€¢ Search history'),`
- [x] **Line 560:** `Text('These will sync automatically when you\'re online.'),`
- [x] **Line 591:** `Text('Recent sync activities:'),`
- [x] **Line 598:** `Text('â€¢ 2 hours ago - Full sync completed'),`
- [x] **Line 599:** `Text('â€¢ 4 hours ago - Bookmarks synced'),`
- [x] **Line 600:** `Text('â€¢ 6 hours ago - Job data refreshed'),`
- [x] **Line 601:** `Text('â€¢ 1 day ago - Initial offline cache'),`

#### `lib\features\storm\screens\storm_screen.dart" (6 instances)

- [x] **Line 96:** `Text(`
- [x] **Line 133:** `Text(`
- [x] **Line 161:** `Text(`
- [x] **Line 206:** `Text(`
- [x] **Line 345:** `Text(`
- [x] **Line 354:** `Text(`

#### `lib\features\storm\widgets\fox_weather_widget.dart" (1 instances)

- [x] **Line 58:** `Text(`

#### `lib\features\storm\widgets\interactive_radar_map.dart" (6 instances)

- [x] **Line 170:** `Text(`
- [x] **Line 195:** `Text(`
- [x] **Line 432:** `Text(`
- [x] **Line 440:** `Text(`
- [x] **Line 499:** `Text(`
- [x] **Line 530:** `Text(`

#### `lib\features\storm\widgets\noaa_radar_map.dart" (16 instances)

- [x] **Line 136:** `Text(`
- [x] **Line 161:** `Text(`
- [x] **Line 262:** `Text(`
- [x] **Line 335:** `Text(`
- [x] **Line 343:** `Text(`
- [x] **Line 441:** `Text(`
- [x] **Line 539:** `Text(`
- [x] **Line 611:** `Text(`
- [x] **Line 620:** `Text(`
- [x] **Line 627:** `Text(`
- [x] **Line 642:** `Text(`
- [x] **Line 669:** `Text(system.name),`
- [x] **Line 676:** `Text(`
- [x] **Line 690:** `Text(`
- [x] **Line 714:** `Text(`
- [x] **Line 720:** `Text(`

#### `lib\features\storm\widgets\power_outage_card.dart" (10 instances)

- [x] **Line 64:** `Text(`
- [x] **Line 82:** `Text(`
- [x] **Line 98:** `Text(`
- [x] **Line 115:** `Text(`
- [x] **Line 154:** `Text(`
- [x] **Line 168:** `Text(`
- [x] **Line 231:** `Text(`
- [x] **Line 238:** `Text(`
- [x] **Line 293:** `Text(`
- [x] **Line 300:** `Text(`

#### `lib\features\storm\widgets\storm_contractor_card.dart" (3 instances)

- [x] **Line 245:** `Text(`
- [x] **Line 291:** `Text(`
- [x] **Line 343:** `Text(`

#### `lib\features\storm\widgets\storm_tracker_section.dart` (5 instances)

- [ ] **Line 40:** `Text(`
- [ ] **Line 136:** `Text('${track.contractor} â€¢ ${track.utility}'),`
- [ ] **Line 137:** `Text(`
- [ ] **Line 173:** `Text(`
- [ ] **Line 180:** `Text(`

#### `lib\features\storm\widgets\storm_track_form.dart` (3 instances)

- [ ] **Line 187:** `Text(`
- [ ] **Line 388:** `Text(`
- [ ] **Line 413:** `Text(`

#### `lib\features\storm\widgets\storm_track_summary_sheet.dart` (6 instances)

- [ ] **Line 109:** `Text(`
- [ ] **Line 140:** `Text(title, style: style.copyWith(fontWeight: FontWeight.bold)),`
- [ ] **Line 141:** `Text(amount, style: style),`
- [ ] **Line 167:** `Text(label, style: AppTheme.bodyMedium),`
- [ ] **Line 169:** `Text(`
- [ ] **Line 176:** `Text(amount, style: AppTheme.bodyMedium.copyWith(color: AppTheme.textPrimary)),`

#### `lib\features\tools\screens\electrical_calculators_screen.dart` (16 instances)

- [ ] **Line 104:** `Text(`
- [ ] **Line 235:** `Text(`
- [ ] **Line 240:** `Text(`
- [ ] **Line 311:** `Text(`
- [ ] **Line 319:** `Text(`
- [ ] **Line 410:** `Text(`
- [ ] **Line 415:** `Text(`
- [ ] **Line 442:** `Text('Voltage',`
- [ ] **Line 571:** `Text(`
- [ ] **Line 576:** `Text(`
- [ ] **Line 592:** `Text('Conduit Size',`
- [ ] **Line 623:** `Text('Wire Size',`
- [ ] **Line 763:** `Text(`
- [ ] **Line 768:** `Text(`
- [ ] **Line 801:** `Text('Voltage',`
- [ ] **Line 837:** `Text('Wire Size',`

#### `lib\features\tools\screens\transformer_bank_screen.dart` (3 instances)

- [ ] **Line 233:** `Text(`
- [ ] **Line 275:** `Text(`
- [ ] **Line 359:** `Text(`

#### `lib\features\tools\screens\transformer_reference_screen.dart` (8 instances)

- [ ] **Line 83:** `Text(`
- [ ] **Line 92:** `Text(`
- [ ] **Line 170:** `Text(`
- [ ] **Line 283:** `Text(`
- [ ] **Line 292:** `Text(`
- [ ] **Line 301:** `Text(`
- [ ] **Line 335:** `Text(`
- [ ] **Line 388:** `Text(`

#### `lib\features\tools\screens\transformer_workbench_screen.dart` (14 instances)

- [ ] **Line 600:** `Text(`
- [ ] **Line 641:** `Text(`
- [ ] **Line 917:** `Text(`
- [ ] **Line 921:** `Text(`
- [ ] **Line 923:** `Text(`
- [ ] **Line 926:** `Text(`
- [ ] **Line 930:** `Text('â€¢ Red: Primary side (high voltage)'),`
- [ ] **Line 931:** `Text('â€¢ Blue: Secondary side (low voltage)'),`
- [ ] **Line 932:** `Text('â€¢ Gray: Neutral connections'),`
- [ ] **Line 933:** `Text('â€¢ Green: Ground connections'),`
- [ ] **Line 935:** `Text(`
- [ ] **Line 939:** `Text('â€¢ Use hints for guidance'),`
- [ ] **Line 940:** `Text('â€¢ Check your work with the validation button'),`
- [ ] **Line 941:** `Text('â€¢ Reset to start over'),`

#### `lib\features\tools\services\conduit_fill_calculator.dart` (18 instances)

- [ ] **Line 159:** `Text(`
- [ ] **Line 166:** `Text(`
- [ ] **Line 191:** `Text(`
- [ ] **Line 201:** `Text(`
- [ ] **Line 265:** `Text(`
- [ ] **Line 306:** `Text(`
- [ ] **Line 366:** `Text(`
- [ ] **Line 466:** `Text(`
- [ ] **Line 490:** `Text(`
- [ ] **Line 497:** `Text(`
- [ ] **Line 520:** `Text(`
- [ ] **Line 526:** `Text(`
- [ ] **Line 532:** `Text(`
- [ ] **Line 585:** `Text(`
- [ ] **Line 603:** `Text(`
- [ ] **Line 609:** `Text(`
- [ ] **Line 640:** `Text(`
- [ ] **Line 681:** `Text(`

#### `lib\features\tools\services\load_calculator.dart` (20 instances)

- [ ] **Line 241:** `Text(`
- [ ] **Line 248:** `Text(`
- [ ] **Line 273:** `Text(`
- [ ] **Line 360:** `Text(`
- [ ] **Line 431:** `Text(`
- [ ] **Line 531:** `Text(`
- [ ] **Line 567:** `Text(`
- [ ] **Line 659:** `Text(`
- [ ] **Line 738:** `Text(`
- [ ] **Line 769:** `Text(`
- [ ] **Line 807:** `Text(`
- [ ] **Line 815:** `Text(`
- [ ] **Line 823:** `Text(`
- [ ] **Line 830:** `Text(`
- [ ] **Line 866:** `Text(`
- [ ] **Line 877:** `Text(`
- [ ] **Line 913:** `Text(`
- [ ] **Line 920:** `Text(`
- [ ] **Line 943:** `Text(`
- [ ] **Line 988:** `Text(`

#### `lib\features\tools\services\voltage_drop_calculator.dart` (12 instances)

- [ ] **Line 152:** `Text(`
- [ ] **Line 159:** `Text(`
- [ ] **Line 188:** `Text(`
- [ ] **Line 297:** `Text(`
- [ ] **Line 349:** `Text(`
- [ ] **Line 412:** `Text(`
- [ ] **Line 504:** `Text(`
- [ ] **Line 569:** `Text(`
- [ ] **Line 587:** `Text(`
- [ ] **Line 594:** `Text(`
- [ ] **Line 658:** `Text(`
- [ ] **Line 669:** `Text(`

#### `lib\features\tools\services\wire_size_chart.dart` (11 instances)

- [ ] **Line 193:** `Text(`
- [ ] **Line 199:** `Text(`
- [ ] **Line 249:** `Text(`
- [ ] **Line 429:** `Text(`
- [ ] **Line 483:** `Text(`
- [ ] **Line 490:** `Text(`
- [ ] **Line 502:** `Text(`
- [ ] **Line 508:** `Text(`
- [ ] **Line 540:** `Text(`
- [ ] **Line 580:** `Text(`
- [ ] **Line 622:** `Text(`

#### `lib\features\unions\screens\locals_screen.dart` (13 instances)

- [ ] **Line 145:** `Text(`
- [ ] **Line 150:** `Text(`
- [ ] **Line 189:** `Text(`
- [ ] **Line 195:** `Text(`
- [ ] **Line 266:** `Text(`
- [ ] **Line 274:** `Text(`
- [ ] **Line 506:** `Text(`
- [ ] **Line 514:** `Text(`
- [ ] **Line 719:** `Text(`
- [ ] **Line 832:** `Text(`
- [ ] **Line 840:** `Text(`
- [ ] **Line 897:** `Text(`
- [ ] **Line 905:** `Text(`


### Icon Widgets (102 opportunities)

#### `lib\core\services\notification_permission_service.dart` (1 instances)

- [ ] **Line 240:** `Icon(`

#### `lib\core\widgets\notification_badge.dart` (1 instances)

- [ ] **Line 180:** `Icon(`

#### `lib\core\widgets\offline_indicator.dart` (3 instances)

- [ ] **Line 183:** `Icon(`
- [ ] **Line 245:** `Icon(`
- [ ] **Line 384:** `Icon(`

#### `lib\core\widgets\offline_indicators.dart` (5 instances)

- [ ] **Line 40:** `Icon(`
- [ ] **Line 87:** `Icon(`
- [ ] **Line 186:** `Icon(`
- [ ] **Line 202:** `Icon(`
- [ ] **Line 453:** `Icon(`

#### `lib\core\widgets\optimized_virtual_job_list.dart` (3 instances)

- [ ] **Line 329:** `Icon(`
- [ ] **Line 365:** `Icon(`
- [ ] **Line 421:** `Icon(`

#### `lib\design_system\tailboard_components.dart` (2 instances)

- [ ] **Line 47:** `Icon(icon, size: 16, color: color),`
- [ ] **Line 273:** `Icon(`

#### `lib\design_system\components\job_card.dart` (5 instances)

- [ ] **Line 124:** `Icon(`
- [ ] **Line 149:** `Icon(`
- [ ] **Line 173:** `Icon(`
- [ ] **Line 194:** `Icon(`
- [ ] **Line 424:** `Icon(`

#### `lib\design_system\components\reusable_components.dart` (2 instances)

- [ ] **Line 237:** `Icon(`
- [ ] **Line 299:** `Icon(`

#### `lib\design_system\electrical\jj_snack_bar.dart` (1 instances)

- [ ] **Line 29:** `Icon(icon, color: AppTheme.white),`

#### `lib\design_system\electrical\transformer_trainer\jj_transformer_trainer.dart` (2 instances)

- [ ] **Line 345:** `Icon(`
- [ ] **Line 383:** `Icon(`

#### `lib\design_system\electrical\transformer_trainer\modes\guided_mode.dart` (3 instances)

- [ ] **Line 121:** `Icon(Icons.lightbulb_outline, color: Colors.blue[600]),`
- [ ] **Line 153:** `Icon(Icons.warning_amber, color: Colors.orange[600], size: 20),`
- [ ] **Line 185:** `Icon(Icons.error_outline, color: Colors.red[600], size: 20),`

#### `lib\design_system\electrical\transformer_trainer\modes\quiz_mode.dart` (3 instances)

- [ ] **Line 90:** `Icon(Icons.quiz, color: Colors.purple[700], size: 28),`
- [ ] **Line 126:** `Icon(Icons.info_outline, color: Colors.purple),`
- [ ] **Line 212:** `Icon(icon, color: color, size: 20),`

#### `lib\design_system\electrical\transformer_trainer\widgets\mobile_ui_patterns.dart` (2 instances)

- [ ] **Line 134:** `Icon(`
- [ ] **Line 611:** `Icon(`

#### `lib\design_system\electrical\transformer_trainer\widgets\trainer_widget.dart` (1 instances)

- [ ] **Line 191:** `Icon(`

#### `lib\design_system\widgets\buttons\jj_button.dart` (1 instances)

- [ ] **Line 65:** `Icon(`

#### `lib\design_system\widgets\buttons\jj_primary_button.dart` (1 instances)

- [ ] **Line 72:** `Icon(`

#### `lib\design_system\widgets\buttons\jj_secondary_button.dart` (1 instances)

- [ ] **Line 70:** `Icon(`

#### `lib\features\crews\widgets\announcement_card.dart` (1 instances)

- [ ] **Line 181:** `Icon(`

#### `lib\features\crews\widgets\comment_item.dart` (1 instances)

- [ ] **Line 99:** `Icon(`

#### `lib\features\crews\widgets\crew_member_avatar.dart` (1 instances)

- [ ] **Line 212:** `Icon(`

#### `lib\features\crews\widgets\crew_preferences_dialog.dart` (1 instances)

- [ ] **Line 75:** `Icon(`

#### `lib\features\crews\widgets\dynamic_container_row.dart` (1 instances)

- [ ] **Line 224:** `Icon(`

#### `lib\features\crews\widgets\job_match_card.dart` (2 instances)

- [ ] **Line 71:** `Icon(`
- [ ] **Line 171:** `Icon(icon, size: 14, color: color),`

#### `lib\features\crews\widgets\tab_widgets.dart` (1 instances)

- [ ] **Line 464:** `Icon(icon, size: 16, color: TailboardTheme.textSecondary),`

#### `lib\features\crews\widgets\tailboard\classification_filter_dialog.dart` (1 instances)

- [ ] **Line 136:** `Icon(`

#### `lib\features\crews\widgets\tailboard\construction_type_filter_dialog.dart` (1 instances)

- [ ] **Line 135:** `Icon(`

#### `lib\features\crews\widgets\tailboard\local_filter_dialog.dart` (1 instances)

- [ ] **Line 176:** `Icon(`

#### `lib\features\crews\widgets\tailboard\member_roles_dialog.dart` (1 instances)

- [ ] **Line 199:** `Icon(`

#### `lib\features\jobs\profile\screens\home_screen.dart` (1 instances)

- [ ] **Line 279:** `Icon(`

#### `lib\features\jobs\profile\screens\onboarding_steps_screen.dart` (1 instances)

- [ ] **Line 882:** `Icon(`

#### `lib\features\jobs\profile\screens\profile_screen.dart` (3 instances)

- [ ] **Line 587:** `Icon(`
- [ ] **Line 1519:** `Icon(`
- [ ] **Line 1569:** `Icon(icon, color: AppTheme.textSecondary),`

#### `lib\features\jobs\widgets\rich_text_job_card.dart` (3 instances)

- [ ] **Line 164:** `Icon(`
- [ ] **Line 211:** `Icon(leftIcon, size: 16, color: AppTheme.textDark),`
- [ ] **Line 244:** `Icon(rightIcon, size: 16, color: AppTheme.textDark),`

#### `lib\features\settings\screens\help_support_screen.dart` (1 instances)

- [ ] **Line 487:** `Icon(`

#### `lib\features\settings\screens\notifications_settings_screen.dart` (1 instances)

- [ ] **Line 172:** `Icon(`

#### `lib\features\settings\screens\resources_screen.dart` (1 instances)

- [ ] **Line 440:** `Icon(`

#### `lib\features\settings\screens\sync_settings_screen.dart` (5 instances)

- [ ] **Line 91:** `Icon(`
- [ ] **Line 162:** `Icon(Icons.sync_alt),`
- [ ] **Line 245:** `Icon(`
- [ ] **Line 269:** `Icon(icon, size: 20),`
- [ ] **Line 296:** `Icon(Icons.tune),`

#### `lib\features\storm\widgets\interactive_radar_map.dart` (2 instances)

- [ ] **Line 189:** `Icon(`
- [ ] **Line 426:** `Icon(`

#### `lib\features\storm\widgets\noaa_radar_map.dart` (7 instances)

- [ ] **Line 155:** `Icon(`
- [ ] **Line 257:** `Icon(`
- [ ] **Line 325:** `Icon(`
- [ ] **Line 352:** `Icon(`
- [ ] **Line 435:** `Icon(`
- [ ] **Line 636:** `Icon(`
- [ ] **Line 664:** `Icon(`

#### `lib\features\storm\widgets\power_outage_card.dart` (1 instances)

- [ ] **Line 287:** `Icon(`

#### `lib\features\storm\widgets\storm_contractor_card.dart` (1 instances)

- [ ] **Line 341:** `Icon(icon, color: color, size: 18),`

#### `lib\features\storm\widgets\storm_track_form.dart` (1 instances)

- [ ] **Line 410:** `Icon(Icons.calendar_today,`

#### `lib\features\tools\screens\electrical_calculators_screen.dart` (1 instances)

- [ ] **Line 96:** `Icon(`

#### `lib\features\tools\screens\transformer_bank_screen.dart` (1 instances)

- [ ] **Line 353:** `Icon(`

#### `lib\features\tools\screens\transformer_reference_screen.dart` (2 instances)

- [ ] **Line 73:** `Icon(`
- [ ] **Line 396:** `Icon(`

#### `lib\features\tools\screens\transformer_workbench_screen.dart` (1 instances)

- [ ] **Line 330:** `Icon(_showHints ? Icons.lightbulb : Icons.lightbulb_outline),`

#### `lib\features\tools\services\conduit_fill_calculator.dart` (3 instances)

- [ ] **Line 460:** `Icon(`
- [ ] **Line 563:** `Icon(`
- [ ] **Line 634:** `Icon(`

#### `lib\features\tools\services\load_calculator.dart` (4 instances)

- [ ] **Line 386:** `Icon(`
- [ ] **Line 653:** `Icon(`
- [ ] **Line 704:** `Icon(`
- [ ] **Line 860:** `Icon(`

#### `lib\features\tools\services\voltage_drop_calculator.dart` (3 instances)

- [ ] **Line 498:** `Icon(`
- [ ] **Line 547:** `Icon(`
- [ ] **Line 652:** `Icon(`

#### `lib\features\tools\services\wire_size_chart.dart` (4 instances)

- [ ] **Line 209:** `Icon(`
- [ ] **Line 243:** `Icon(`
- [ ] **Line 278:** `Icon(`
- [ ] **Line 534:** `Icon(`

#### `lib\features\unions\screens\locals_screen.dart` (6 instances)

- [ ] **Line 139:** `Icon(`
- [ ] **Line 183:** `Icon(`
- [ ] **Line 378:** `Icon(`
- [ ] **Line 822:** `Icon(`
- [ ] **Line 857:** `Icon(`
- [ ] **Line 887:** `Icon(`


### SizedBox Widgets (42 opportunities)

#### `lib\core\widgets\offline_indicators.dart` (2 instances)

- [ ] **Line 242:** `SizedBox(`
- [ ] **Line 394:** `SizedBox(`

#### `lib\core\widgets\optimized_virtual_job_list.dart` (1 instances)

- [ ] **Line 298:** `SizedBox(`

#### `lib\design_system\tailboard_components.dart` (1 instances)

- [ ] **Line 81:** `SizedBox(`

#### `lib\design_system\components\reusable_components.dart` (1 instances)

- [ ] **Line 122:** `SizedBox(`

#### `lib\design_system\electrical\electrical_rotation_meter.dart` (1 instances)

- [ ] **Line 80:** `SizedBox(`

#### `lib\design_system\electrical\transformer_trainer\modes\guided_mode.dart` (1 instances)

- [ ] **Line 44:** `SizedBox(`

#### `lib\design_system\electrical\transformer_trainer\modes\quiz_mode.dart` (2 instances)

- [ ] **Line 38:** `SizedBox(`
- [ ] **Line 127:** `SizedBox(width: 8),`

#### `lib\design_system\electrical\transformer_trainer\widgets\mobile_ui_patterns.dart` (2 instances)

- [ ] **Line 294:** `SizedBox(`
- [ ] **Line 315:** `SizedBox(`

#### `lib\design_system\widgets\buttons\jj_button.dart` (1 instances)

- [ ] **Line 55:** `SizedBox(`

#### `lib\features\crews\screens\crew_onboarding_screen.dart` (2 instances)

- [ ] **Line 106:** `SizedBox(`
- [ ] **Line 132:** `SizedBox(`

#### `lib\features\crews\screens\tailboard_screen.dart` (1 instances)

- [ ] **Line 1042:** `SizedBox(`

#### `lib\features\crews\widgets\chat_components.dart` (1 instances)

- [ ] **Line 281:** `SizedBox(`

#### `lib\features\crews\widgets\post_card.dart` (4 instances)

- [ ] **Line 240:** `SizedBox(width: 8),`
- [ ] **Line 252:** `SizedBox(width: 8),`
- [ ] **Line 263:** `SizedBox(width: 8),`
- [ ] **Line 294:** `SizedBox(`

#### `lib\features\jobs\profile\screens\profile_screen.dart` (1 instances)

- [ ] **Line 918:** `SizedBox(`

#### `lib\features\jobs\profile\screens\training_certificates_screen.dart` (1 instances)

- [ ] **Line 954:** `SizedBox(`

#### `lib\features\jobs\widgets\job_details_dialog.dart` (2 instances)

- [ ] **Line 172:** `SizedBox(`
- [ ] **Line 286:** `SizedBox(`

#### `lib\features\jobs\widgets\rich_text_job_card.dart` (1 instances)

- [ ] **Line 168:** `SizedBox(width: 4),`

#### `lib\features\jobs\widgets\virtual_job_list.dart` (1 instances)

- [ ] **Line 320:** `SizedBox(`

#### `lib\features\settings\screens\sync_settings_screen.dart` (5 instances)

- [ ] **Line 163:** `SizedBox(width: 8),`
- [ ] **Line 297:** `SizedBox(width: 8),`
- [ ] **Line 555:** `SizedBox(height: 8),`
- [ ] **Line 559:** `SizedBox(height: 16),`
- [ ] **Line 592:** `SizedBox(height: 16),`

#### `lib\features\tools\screens\transformer_bank_screen.dart` (1 instances)

- [ ] **Line 258:** `SizedBox(`

#### `lib\features\tools\screens\transformer_reference_screen.dart` (6 instances)

- [ ] **Line 78:** `SizedBox(width: AppTheme.spacingMd),`
- [ ] **Line 91:** `SizedBox(height: AppTheme.spacingXs),`
- [ ] **Line 291:** `SizedBox(height: AppTheme.spacingXs),`
- [ ] **Line 300:** `SizedBox(height: AppTheme.spacingSm),`
- [ ] **Line 309:** `SizedBox(height: AppTheme.spacingMd),`
- [ ] **Line 395:** `SizedBox(width: AppTheme.spacingXs),`

#### `lib\features\tools\screens\transformer_workbench_screen.dart` (2 instances)

- [ ] **Line 925:** `SizedBox(height: 16),`
- [ ] **Line 934:** `SizedBox(height: 16),`

#### `lib\features\tools\services\conduit_fill_calculator.dart` (2 instances)

- [ ] **Line 377:** `SizedBox(`
- [ ] **Line 411:** `SizedBox(`


### Padding Widgets (32 opportunities)

#### `lib\core\widgets\notification_popup.dart` (1 instances)

- [ ] **Line 155:** `Padding(`

#### `lib\design_system\tailboard_components.dart` (1 instances)

- [ ] **Line 313:** `Padding(`

#### `lib\design_system\electrical\jj_electrical_notifications.dart` (2 instances)

- [ ] **Line 255:** `Padding(`
- [ ] **Line 441:** `Padding(`

#### `lib\design_system\electrical\transformer_trainer\modes\guided_mode.dart` (1 instances)

- [ ] **Line 226:** `Padding(`

#### `lib\design_system\electrical\transformer_trainer\widgets\mobile_ui_patterns.dart` (1 instances)

- [ ] **Line 48:** `Padding(`

#### `lib\features\auth\screens\auth_screen.dart` (1 instances)

- [ ] **Line 513:** `Padding(`

#### `lib\features\auth\screens\welcome_screen.dart` (2 instances)

- [ ] **Line 87:** `Padding(`
- [ ] **Line 225:** `Padding(`

#### `lib\features\crews\widgets\announcement_card.dart` (1 instances)

- [ ] **Line 67:** `Padding(`

#### `lib\features\crews\widgets\chat_components.dart` (2 instances)

- [ ] **Line 69:** `Padding(`
- [ ] **Line 348:** `Padding(`

#### `lib\features\crews\widgets\comment_thread.dart` (1 instances)

- [ ] **Line 83:** `Padding(`

#### `lib\features\crews\widgets\job_match_card.dart` (1 instances)

- [ ] **Line 106:** `Padding(`

#### `lib\features\crews\widgets\message_bubble.dart` (1 instances)

- [ ] **Line 68:** `Padding(`

#### `lib\features\crews\widgets\post_card.dart` (2 instances)

- [ ] **Line 454:** `Padding(`
- [ ] **Line 506:** `Padding(`

#### `lib\features\crews\widgets\tab_widgets.dart` (1 instances)

- [ ] **Line 426:** `Padding(`

#### `lib\features\crews\widgets\tailboard\apply_job_dialog.dart` (1 instances)

- [ ] **Line 109:** `Padding(`

#### `lib\features\jobs\profile\screens\training_certificates_screen.dart` (2 instances)

- [ ] **Line 242:** `Padding(`
- [ ] **Line 368:** `Padding(`

#### `lib\features\jobs\widgets\optimized_job_card.dart` (1 instances)

- [ ] **Line 70:** `Padding(`

#### `lib\features\settings\screens\data_storage_screen.dart` (1 instances)

- [ ] **Line 128:** `Padding(`

#### `lib\features\settings\screens\notifications_settings_screen.dart` (1 instances)

- [ ] **Line 1063:** `Padding(`

#### `lib\features\settings\screens\resources_screen.dart` (1 instances)

- [ ] **Line 337:** `Padding(`

#### `lib\features\settings\screens\settings_screen.dart` (1 instances)

- [ ] **Line 299:** `Padding(`

#### `lib\features\storm\screens\storm_screen.dart` (1 instances)

- [ ] **Line 123:** `Padding(`

#### `lib\features\storm\widgets\fox_weather_widget.dart` (1 instances)

- [ ] **Line 52:** `Padding(`

#### `lib\features\storm\widgets\storm_contractor_card.dart` (1 instances)

- [ ] **Line 124:** `Padding(`

#### `lib\features\storm\widgets\storm_track_form.dart` (1 instances)

- [ ] **Line 182:** `Padding(`

#### `lib\features\tools\screens\transformer_bank_screen.dart` (1 instances)

- [ ] **Line 81:** `Padding(`

#### `lib\features\tools\screens\transformer_reference_screen.dart` (1 instances)

- [ ] **Line 165:** `Padding(`


### EdgeInsets (42 opportunities)

#### `lib\core\widgets\offline_indicator.dart` (1 instances)

- [ ] **Line 234:** `padding: EdgeInsets.symmetric(`

#### `lib\design_system\popup_theme.dart` (11 instances)

- [ ] **Line 47:** `padding: EdgeInsets.all(AppTheme.spacingMd),`
- [ ] **Line 70:** `padding: EdgeInsets.fromLTRB(`
- [ ] **Line 87:** `padding: EdgeInsets.all(AppTheme.spacingMd),`
- [ ] **Line 98:** `padding: EdgeInsets.symmetric(`
- [ ] **Line 113:** `padding: EdgeInsets.all(AppTheme.spacingXl),`
- [ ] **Line 141:** `padding: EdgeInsets.symmetric(`
- [ ] **Line 155:** `padding: EdgeInsets.all(AppTheme.spacingXs),`
- [ ] **Line 166:** `padding: EdgeInsets.all(AppTheme.spacingMd),`
- [ ] **Line 176:** `padding: EdgeInsets.all(AppTheme.spacingMd),`
- [ ] **Line 186:** `padding: EdgeInsets.all(AppTheme.spacingMd),`
- [ ] **Line 196:** `padding: EdgeInsets.all(AppTheme.spacingMd),`

#### `lib\design_system\theme_variables.dart` (1 instances)

- [ ] **Line 20:** `'buttonPadding': EdgeInsets.all(8.0), // Set button padding size here`

#### `lib\design_system\components\reusable_components.dart` (1 instances)

- [ ] **Line 175:** `margin: EdgeInsets.only(`

#### `lib\design_system\electrical\jj_electrical_interactive_widgets.dart` (1 instances)

- [ ] **Line 410:** `contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),`

#### `lib\design_system\electrical\jj_electrical_toast.dart` (1 instances)

- [ ] **Line 348:** `padding: EdgeInsets.zero,`

#### `lib\design_system\widgets\buttons\jj_button.dart` (1 instances)

- [ ] **Line 46:** `padding: EdgeInsets.symmetric(`

#### `lib\features\crews\widgets\comment_item.dart` (1 instances)

- [ ] **Line 181:** `padding: EdgeInsets.zero,`

#### `lib\features\crews\widgets\comment_thread.dart` (2 instances)

- [ ] **Line 111:** `padding: EdgeInsets.zero,`
- [ ] **Line 148:** `padding: EdgeInsets.symmetric(vertical: 16),`

#### `lib\features\crews\widgets\dynamic_container_row.dart` (2 instances)

- [ ] **Line 36:** `padding: EdgeInsets.only(`
- [ ] **Line 156:** `padding: EdgeInsets.only(`

#### `lib\features\crews\widgets\post_card.dart` (1 instances)

- [ ] **Line 500:** `padding: EdgeInsets.all(16.0),`

#### `lib\features\crews\widgets\reaction_animation.dart` (2 instances)

- [ ] **Line 137:** `padding: EdgeInsets.all(widget.isSelected ? 4.0 : 0.0),`
- [ ] **Line 318:** `padding: EdgeInsets.all(isSelected ? 4.0 : 0.0),`

#### `lib\features\jobs\profile\screens\home_screen.dart` (2 instances)

- [ ] **Line 76:** `padding: EdgeInsets.all(6),`
- [ ] **Line 333:** `padding: EdgeInsets.all(AppTheme.spacingLg),`

#### `lib\features\jobs\profile\screens\profile_screen.dart` (6 instances)

- [ ] **Line 830:** `padding: EdgeInsets.fromLTRB(`
- [ ] **Line 1010:** `padding: EdgeInsets.fromLTRB(`
- [ ] **Line 1054:** `EdgeInsets.symmetric(horizontal: AppTheme.spacingMd),`
- [ ] **Line 1167:** `EdgeInsets.symmetric(horizontal: AppTheme.spacingMd),`
- [ ] **Line 1199:** `EdgeInsets.symmetric(horizontal: AppTheme.spacingMd),`
- [ ] **Line 1240:** `padding: EdgeInsets.fromLTRB(`

#### `lib\features\settings\screens\help_support_screen.dart` (1 instances)

- [ ] **Line 209:** `contentPadding: EdgeInsets.symmetric(`

#### `lib\features\settings\screens\resources_screen.dart` (1 instances)

- [ ] **Line 279:** `contentPadding: EdgeInsets.symmetric(`

#### `lib\features\storm\widgets\storm_tracker_section.dart` (1 instances)

- [ ] **Line 125:** `contentPadding: EdgeInsets.zero,`

#### `lib\features\tools\services\conduit_fill_calculator.dart` (3 instances)

- [ ] **Line 322:** `padding: EdgeInsets.zero,`
- [ ] **Line 388:** `padding: EdgeInsets.zero,`
- [ ] **Line 422:** `padding: EdgeInsets.zero,`

#### `lib\features\tools\services\load_calculator.dart` (2 instances)

- [ ] **Line 446:** `padding: EdgeInsets.zero,`
- [ ] **Line 513:** `contentPadding: EdgeInsets.zero,`

#### `lib\features\tools\services\wire_size_chart.dart` (1 instances)

- [ ] **Line 134:** `contentPadding: EdgeInsets.symmetric(`


### TextStyle (97 opportunities)

#### `lib\core\widgets\contractor_card.dart` (1 instances)

- [ ] **Line 165:** `TextStyle(`

#### `lib\core\widgets\message_bubble.dart` (1 instances)

- [ ] **Line 49:** `style: TextStyle(`

#### `lib\core\widgets\notification_badge.dart` (2 instances)

- [ ] **Line 112:** `style: TextStyle(`
- [ ] **Line 208:** `style: TextStyle(`

#### `lib\core\widgets\offline_indicators.dart` (8 instances)

- [ ] **Line 49:** `style: TextStyle(`
- [ ] **Line 96:** `style: TextStyle(`
- [ ] **Line 110:** `style: TextStyle(`
- [ ] **Line 194:** `style: TextStyle(`
- [ ] **Line 365:** `style: TextStyle(`
- [ ] **Line 461:** `style: TextStyle(`
- [ ] **Line 484:** `style: TextStyle(`
- [ ] **Line 521:** `style: TextStyle(`

#### `lib\design_system\theme_variables.dart` (3 instances)

- [ ] **Line 12:** `'bodyText1': TextStyle(`
- [ ] **Line 17:** `'title': TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black), // Set the title style color here`
- [ ] **Line 21:** `'buttonTextStyle': TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.white), // Set the text style for buttons here`

#### `lib\design_system\components\job_card_implementation.dart` (3 instances)

- [ ] **Line 81:** `style: TextStyle(`
- [ ] **Line 325:** `style: TextStyle(`
- [ ] **Line 348:** `style: TextStyle(`

#### `lib\design_system\electrical\electrical_rotation_meter.dart` (1 instances)

- [ ] **Line 101:** `style: TextStyle(`

#### `lib\design_system\electrical\jj_circuit_breaker_switch.dart` (2 instances)

- [ ] **Line 582:** `style: TextStyle(`
- [ ] **Line 622:** `style: TextStyle(`

#### `lib\design_system\electrical\simple_test_harness.dart` (1 instances)

- [ ] **Line 61:** `style: TextStyle(`

#### `lib\design_system\electrical\transformer_trainer\animations\power_up_animation.dart` (1 instances)

- [ ] **Line 652:** `style: TextStyle(`

#### `lib\design_system\electrical\transformer_trainer\modes\guided_mode.dart` (6 instances)

- [ ] **Line 125:** `style: TextStyle(fontWeight: FontWeight.bold),`
- [ ] **Line 137:** `style: TextStyle(fontSize: 14, color: Colors.grey[600]),`
- [ ] **Line 161:** `style: TextStyle(fontWeight: FontWeight.bold),`
- [ ] **Line 193:** `style: TextStyle(fontWeight: FontWeight.bold),`
- [ ] **Line 237:** `style: TextStyle(fontWeight: FontWeight.bold),`
- [ ] **Line 250:** `style: TextStyle(fontWeight: FontWeight.bold),`

#### `lib\design_system\electrical\transformer_trainer\modes\quiz_mode.dart` (6 instances)

- [ ] **Line 98:** `style: TextStyle(`
- [ ] **Line 105:** `style: TextStyle(`
- [ ] **Line 131:** `style: TextStyle(fontSize: 14),`
- [ ] **Line 199:** `style: TextStyle(`
- [ ] **Line 216:** `style: TextStyle(`
- [ ] **Line 224:** `style: TextStyle(`

#### `lib\design_system\electrical\transformer_trainer\painters\base_transformer_painter.dart` (5 instances)

- [ ] **Line 48:** `TextStyle get labelStyle => _getScaledTextStyle(12, FontWeight.bold, AppTheme.textPrimary);`
- [ ] **Line 49:** `TextStyle get voltageStyle => _getScaledTextStyle(11, FontWeight.w500, AppTheme.errorRed);`
- [ ] **Line 50:** `TextStyle get terminalStyle => _getScaledTextStyle(10, FontWeight.bold, AppTheme.infoBlue);`
- [ ] **Line 69:** `TextStyle _getScaledTextStyle(double baseSize, FontWeight weight, Color color) {`
- [ ] **Line 72:** `return TextStyle(`

#### `lib\design_system\electrical\transformer_trainer\painters\delta_wye_painter.dart` (1 instances)

- [ ] **Line 171:** `TextStyle(color: Colors.orange[700], fontSize: 12, fontWeight: FontWeight.bold),);`

#### `lib\design_system\electrical\transformer_trainer\painters\open_delta_painter.dart` (2 instances)

- [ ] **Line 96:** `TextStyle(color: Colors.red[600], fontSize: 12, fontWeight: FontWeight.bold),);`
- [ ] **Line 199:** `TextStyle(color: Colors.orange[600], fontSize: 10, fontStyle: FontStyle.italic),);`

#### `lib\design_system\electrical\transformer_trainer\painters\wye_delta_painter.dart` (1 instances)

- [ ] **Line 157:** `TextStyle(color: Colors.orange[700], fontSize: 12, fontWeight: FontWeight.bold),);`

#### `lib\design_system\electrical\transformer_trainer\utils\accessibility_manager.dart` (1 instances)

- [ ] **Line 278:** `style: TextStyle(`

#### `lib\design_system\electrical\transformer_trainer\widgets\trainer_widget.dart` (1 instances)

- [ ] **Line 199:** `style: TextStyle(`

#### `lib\features\crews\widgets\comment_animation.dart` (1 instances)

- [ ] **Line 175:** `style: TextStyle(`

#### `lib\features\crews\widgets\crew_member_avatar.dart` (1 instances)

- [ ] **Line 75:** `style: TextStyle(`

#### `lib\features\crews\widgets\job_match_card.dart` (1 instances)

- [ ] **Line 79:** `style: TextStyle(`

#### `lib\features\crews\widgets\reaction_animation.dart` (3 instances)

- [ ] **Line 150:** `style: TextStyle(`
- [ ] **Line 331:** `style: TextStyle(`
- [ ] **Line 543:** `style: TextStyle(`

#### `lib\features\jobs\profile\screens\profile_screen.dart` (2 instances)

- [ ] **Line 1122:** `labelStyle: TextStyle(`
- [ ] **Line 1502:** `labelStyle: TextStyle(`

#### `lib\features\jobs\screens\jobs_screen.dart` (1 instances)

- [ ] **Line 144:** `labelStyle: TextStyle(`

#### `lib\features\jobs\widgets\condensed_job_card.dart` (2 instances)

- [ ] **Line 158:** `style: TextStyle(`
- [ ] **Line 183:** `style: TextStyle(`

#### `lib\features\jobs\widgets\job_details_dialog.dart` (9 instances)

- [ ] **Line 91:** `style: TextStyle(`
- [ ] **Line 127:** `style: TextStyle(`
- [ ] **Line 186:** `style: TextStyle(`
- [ ] **Line 204:** `style: TextStyle(`
- [ ] **Line 213:** `style: TextStyle(`
- [ ] **Line 231:** `style: TextStyle(`
- [ ] **Line 240:** `style: TextStyle(`
- [ ] **Line 319:** `style: TextStyle(`
- [ ] **Line 362:** `style: TextStyle(`

#### `lib\features\jobs\widgets\optimized_job_card.dart` (1 instances)

- [ ] **Line 77:** `style: TextStyle(color: Colors.red)),`

#### `lib\features\jobs\widgets\rich_text_job_card.dart` (5 instances)

- [ ] **Line 128:** `style: TextStyle(`
- [ ] **Line 171:** `style: TextStyle(`
- [ ] **Line 224:** `style: TextStyle(`
- [ ] **Line 257:** `style: TextStyle(`
- [ ] **Line 296:** `style: TextStyle(`

#### `lib\features\settings\screens\sync_settings_screen.dart` (6 instances)

- [ ] **Line 98:** `style: TextStyle(`
- [ ] **Line 166:** `style: TextStyle(`
- [ ] **Line 300:** `style: TextStyle(`
- [ ] **Line 363:** `style: TextStyle(fontWeight: FontWeight.w500),`
- [ ] **Line 401:** `style: TextStyle(`
- [ ] **Line 522:** `style: TextStyle(fontWeight: FontWeight.bold),`

#### `lib\features\storm\widgets\storm_track_form.dart` (1 instances)

- [ ] **Line 210:** `style: TextStyle(color: AppTheme.errorRed)),`

#### `lib\features\tools\screens\transformer_bank_screen.dart` (4 instances)

- [ ] **Line 105:** `style: TextStyle(`
- [ ] **Line 116:** `style: TextStyle(`
- [ ] **Line 137:** `style: TextStyle(`
- [ ] **Line 313:** `style: TextStyle(`

#### `lib\features\tools\screens\transformer_reference_screen.dart` (11 instances)

- [ ] **Line 27:** `style: TextStyle(fontWeight: FontWeight.bold),`
- [ ] **Line 85:** `style: TextStyle(`
- [ ] **Line 94:** `style: TextStyle(`
- [ ] **Line 216:** `style: TextStyle(`
- [ ] **Line 225:** `style: TextStyle(`
- [ ] **Line 234:** `style: TextStyle(`
- [ ] **Line 285:** `style: TextStyle(`
- [ ] **Line 294:** `style: TextStyle(`
- [ ] **Line 303:** `style: TextStyle(`
- [ ] **Line 390:** `style: TextStyle(`
- [ ] **Line 443:** `style: TextStyle(`

#### `lib\features\tools\screens\transformer_workbench_screen.dart` (3 instances)

- [ ] **Line 919:** `style: TextStyle(fontWeight: FontWeight.bold),`
- [ ] **Line 928:** `style: TextStyle(fontWeight: FontWeight.bold),`
- [ ] **Line 937:** `style: TextStyle(fontWeight: FontWeight.bold),`


### Divider Widgets (1 opportunities)

#### `lib\features\jobs\widgets\condensed_job_card.dart` (1 instances)

- [ ] **Line 77:** `Divider(`


### Container Widgets (185 opportunities)

#### `lib\core\services\notification_permission_service.dart` (1 instances)

- [ ] **Line 62:** `Container(`

#### `lib\core\widgets\notification_badge.dart` (1 instances)

- [ ] **Line 197:** `Container(`

#### `lib\core\widgets\notification_popup.dart` (3 instances)

- [ ] **Line 106:** `Container(`
- [ ] **Line 120:** `Container(`
- [ ] **Line 230:** `Container(`

#### `lib\core\widgets\offline_indicators.dart` (1 instances)

- [ ] **Line 81:** `Container(`

#### `lib\design_system\tailboard_components.dart` (1 instances)

- [ ] **Line 132:** `Container(`

#### `lib\design_system\components\job_card.dart` (1 instances)

- [ ] **Line 187:** `Container(`

#### `lib\design_system\components\job_card_implementation.dart` (1 instances)

- [ ] **Line 98:** `Container(`

#### `lib\design_system\components\reusable_components.dart` (2 instances)

- [ ] **Line 391:** `Container(`
- [ ] **Line 402:** `Container(`

#### `lib\design_system\electrical\electrical_illustrations_example.dart` (2 instances)

- [ ] **Line 94:** `Container(`
- [ ] **Line 110:** `Container(`

#### `lib\design_system\electrical\enhanced_backgrounds.dart` (1 instances)

- [ ] **Line 97:** `Container(`

#### `lib\design_system\electrical\jj_electrical_interactive_widgets.dart` (1 instances)

- [ ] **Line 398:** `Container(`

#### `lib\design_system\electrical\jj_electrical_notifications.dart` (1 instances)

- [ ] **Line 260:** `Container(`

#### `lib\design_system\electrical\jj_electrical_page_transitions.dart` (1 instances)

- [ ] **Line 170:** `Container(`

#### `lib\design_system\electrical\transformer_trainer\jj_transformer_trainer.dart` (1 instances)

- [ ] **Line 273:** `Container(`

#### `lib\design_system\electrical\transformer_trainer\animations\flash_animation.dart` (1 instances)

- [ ] **Line 70:** `Container(`

#### `lib\design_system\electrical\transformer_trainer\modes\guided_mode.dart` (2 instances)

- [ ] **Line 143:** `Container(`
- [ ] **Line 175:** `Container(`

#### `lib\design_system\electrical\transformer_trainer\modes\quiz_mode.dart` (2 instances)

- [ ] **Line 117:** `Container(`
- [ ] **Line 510:** `Container(`

#### `lib\design_system\electrical\transformer_trainer\widgets\mobile_ui_patterns.dart` (1 instances)

- [ ] **Line 37:** `Container(`

#### `lib\features\auth\screens\auth_screen.dart` (3 instances)

- [ ] **Line 278:** `Container(`
- [ ] **Line 283:** `Container(`
- [ ] **Line 719:** `Container(`

#### `lib\features\auth\screens\forgot_password_screen.dart` (7 instances)

- [ ] **Line 98:** `Container(`
- [ ] **Line 108:** `Container(`
- [ ] **Line 148:** `Container(`
- [ ] **Line 182:** `Container(`
- [ ] **Line 227:** `Container(`
- [ ] **Line 237:** `Container(`
- [ ] **Line 308:** `Container(`

#### `lib\features\auth\screens\welcome_screen.dart` (1 instances)

- [ ] **Line 122:** `Container(`

#### `lib\features\crews\screens\crew_onboarding_screen.dart` (1 instances)

- [ ] **Line 26:** `Container(`

#### `lib\features\crews\screens\tailboard_screen.dart` (3 instances)

- [ ] **Line 799:** `Container(`
- [ ] **Line 1014:** `Container(`
- [ ] **Line 1074:** `Container(`

#### `lib\features\crews\widgets\activity_card.dart` (2 instances)

- [ ] **Line 40:** `Container(`
- [ ] **Line 78:** `Container(`

#### `lib\features\crews\widgets\announcement_card.dart` (1 instances)

- [ ] **Line 38:** `Container(`

#### `lib\features\crews\widgets\chat_components.dart` (2 instances)

- [ ] **Line 81:** `Container(`
- [ ] **Line 261:** `Container(`

#### `lib\features\crews\widgets\comment_input.dart` (1 instances)

- [ ] **Line 112:** `Container(`

#### `lib\features\crews\widgets\comment_item.dart` (2 instances)

- [ ] **Line 53:** `Container(`
- [ ] **Line 137:** `Container(`

#### `lib\features\crews\widgets\crew_member_avatar.dart` (3 instances)

- [ ] **Line 25:** `Container(`
- [ ] **Line 182:** `Container(`
- [ ] **Line 197:** `Container(`

#### `lib\features\crews\widgets\crew_preferences_dialog.dart` (1 instances)

- [ ] **Line 568:** `Container(`

#### `lib\features\crews\widgets\job_match_card.dart` (2 instances)

- [ ] **Line 44:** `Container(`
- [ ] **Line 61:** `Container(`

#### `lib\features\crews\widgets\message_bubble.dart` (1 instances)

- [ ] **Line 80:** `Container(`

#### `lib\features\crews\widgets\reaction_animation.dart` (1 instances)

- [ ] **Line 120:** `Container(`

#### `lib\features\crews\widgets\tab_widgets.dart` (2 instances)

- [ ] **Line 404:** `Container(`
- [ ] **Line 781:** `Container(`

#### `lib\features\crews\widgets\tailboard\apply_job_dialog.dart` (1 instances)

- [ ] **Line 68:** `Container(`

#### `lib\features\crews\widgets\tailboard\channels_list_dialog.dart` (1 instances)

- [ ] **Line 25:** `Container(`

#### `lib\features\crews\widgets\tailboard\classification_filter_dialog.dart` (2 instances)

- [ ] **Line 57:** `Container(`
- [ ] **Line 173:** `Container(`

#### `lib\features\crews\widgets\tailboard\construction_type_filter_dialog.dart` (2 instances)

- [ ] **Line 58:** `Container(`
- [ ] **Line 162:** `Container(`

#### `lib\features\crews\widgets\tailboard\feed_history_dialog.dart` (1 instances)

- [ ] **Line 21:** `Container(`

#### `lib\features\crews\widgets\tailboard\feed_sort_options_dialog.dart` (1 instances)

- [ ] **Line 114:** `Container(`

#### `lib\features\crews\widgets\tailboard\local_filter_dialog.dart` (2 instances)

- [ ] **Line 83:** `Container(`
- [ ] **Line 203:** `Container(`

#### `lib\features\crews\widgets\tailboard\member_availability_dialog.dart` (3 instances)

- [ ] **Line 28:** `Container(`
- [ ] **Line 124:** `Container(`
- [ ] **Line 221:** `Container(`

#### `lib\features\crews\widgets\tailboard\member_roster_dialog.dart` (2 instances)

- [ ] **Line 29:** `Container(`
- [ ] **Line 130:** `Container(`

#### `lib\features\jobs\profile\screens\home_screen.dart` (1 instances)

- [ ] **Line 68:** `Container(`

#### `lib\features\jobs\profile\screens\onboarding_steps_screen.dart` (8 instances)

- [ ] **Line 465:** `Container(`
- [ ] **Line 688:** `Container(`
- [ ] **Line 831:** `Container(`
- [ ] **Line 874:** `Container(`
- [ ] **Line 969:** `Container(`
- [ ] **Line 1013:** `Container(`
- [ ] **Line 1072:** `Container(`
- [ ] **Line 1222:** `Container(`

#### `lib\features\jobs\profile\screens\profile_screen.dart` (6 instances)

- [ ] **Line 431:** `Container(`
- [ ] **Line 678:** `Container(`
- [ ] **Line 782:** `Container(`
- [ ] **Line 1043:** `Container(`
- [ ] **Line 1156:** `Container(`
- [ ] **Line 1188:** `Container(`

#### `lib\features\jobs\profile\screens\training_certificates_screen.dart` (9 instances)

- [ ] **Line 201:** `Container(`
- [ ] **Line 253:** `Container(`
- [ ] **Line 328:** `Container(`
- [ ] **Line 396:** `Container(`
- [ ] **Line 441:** `Container(`
- [ ] **Line 576:** `Container(`
- [ ] **Line 611:** `Container(`
- [ ] **Line 783:** `Container(`
- [ ] **Line 989:** `Container(`

#### `lib\features\jobs\screens\jobs_screen.dart` (1 instances)

- [ ] **Line 335:** `Container(`

#### `lib\features\jobs\widgets\condensed_job_card.dart` (1 instances)

- [ ] **Line 46:** `Container(`

#### `lib\features\settings\screens\appearance_display_screen.dart` (3 instances)

- [ ] **Line 149:** `Container(`
- [ ] **Line 192:** `Container(`
- [ ] **Line 204:** `Container(`

#### `lib\features\settings\screens\app_settings_screen.dart` (5 instances)

- [ ] **Line 230:** `Container(`
- [ ] **Line 251:** `Container(`
- [ ] **Line 309:** `Container(`
- [ ] **Line 387:** `Container(`
- [ ] **Line 448:** `Container(`

#### `lib\features\settings\screens\data_storage_screen.dart` (2 instances)

- [ ] **Line 132:** `Container(`
- [ ] **Line 194:** `Container(`

#### `lib\features\settings\screens\feedback_screen.dart` (2 instances)

- [ ] **Line 130:** `Container(`
- [ ] **Line 193:** `Container(`

#### `lib\features\settings\screens\help_support_screen.dart` (6 instances)

- [ ] **Line 189:** `Container(`
- [ ] **Line 272:** `Container(`
- [ ] **Line 469:** `Container(`
- [ ] **Line 545:** `Container(`
- [ ] **Line 648:** `Container(`
- [ ] **Line 693:** `Container(`

#### `lib\features\settings\screens\job_search_preferences_screen.dart` (4 instances)

- [ ] **Line 171:** `Container(`
- [ ] **Line 226:** `Container(`
- [ ] **Line 247:** `Container(`
- [ ] **Line 299:** `Container(`

#### `lib\features\settings\screens\language_region_screen.dart` (2 instances)

- [ ] **Line 143:** `Container(`
- [ ] **Line 164:** `Container(`

#### `lib\features\settings\screens\notifications_settings_screen.dart` (7 instances)

- [ ] **Line 456:** `Container(`
- [ ] **Line 512:** `Container(`
- [ ] **Line 591:** `Container(`
- [ ] **Line 617:** `Container(`
- [ ] **Line 873:** `Container(`
- [ ] **Line 941:** `Container(`
- [ ] **Line 1014:** `Container(`

#### `lib\features\settings\screens\privacy_security_screen.dart` (3 instances)

- [ ] **Line 162:** `Container(`
- [ ] **Line 217:** `Container(`
- [ ] **Line 238:** `Container(`

#### `lib\features\settings\screens\resources_screen.dart` (4 instances)

- [ ] **Line 259:** `Container(`
- [ ] **Line 405:** `Container(`
- [ ] **Line 523:** `Container(`
- [ ] **Line 558:** `Container(`

#### `lib\features\settings\screens\settings_screen.dart` (5 instances)

- [ ] **Line 86:** `Container(`
- [ ] **Line 100:** `Container(`
- [ ] **Line 262:** `Container(`
- [ ] **Line 336:** `Container(`
- [ ] **Line 394:** `Container(`

#### `lib\features\storm\screens\storm_screen.dart` (2 instances)

- [ ] **Line 183:** `Container(`
- [ ] **Line 325:** `Container(`

#### `lib\features\storm\widgets\interactive_radar_map.dart` (2 instances)

- [ ] **Line 373:** `Container(`
- [ ] **Line 521:** `Container(`

#### `lib\features\storm\widgets\noaa_radar_map.dart` (2 instances)

- [ ] **Line 370:** `Container(`
- [ ] **Line 593:** `Container(`

#### `lib\features\storm\widgets\power_outage_card.dart` (2 instances)

- [ ] **Line 47:** `Container(`
- [ ] **Line 130:** `Container(`

#### `lib\features\tools\screens\electrical_calculators_screen.dart` (10 instances)

- [ ] **Line 59:** `Container(`
- [ ] **Line 301:** `Container(`
- [ ] **Line 446:** `Container(`
- [ ] **Line 480:** `Container(`
- [ ] **Line 596:** `Container(`
- [ ] **Line 627:** `Container(`
- [ ] **Line 662:** `Container(`
- [ ] **Line 805:** `Container(`
- [ ] **Line 841:** `Container(`
- [ ] **Line 882:** `Container(`

#### `lib\features\tools\screens\transformer_bank_screen.dart` (3 instances)

- [ ] **Line 190:** `Container(`
- [ ] **Line 206:** `Container(`
- [ ] **Line 378:** `Container(`

#### `lib\features\tools\screens\transformer_reference_screen.dart` (4 instances)

- [ ] **Line 197:** `Container(`
- [ ] **Line 266:** `Container(`
- [ ] **Line 325:** `Container(`
- [ ] **Line 344:** `Container(`

#### `lib\features\tools\screens\transformer_workbench_screen.dart` (3 instances)

- [ ] **Line 434:** `Container(`
- [ ] **Line 527:** `Container(`
- [ ] **Line 590:** `Container(`

#### `lib\features\tools\services\conduit_fill_calculator.dart` (3 instances)

- [ ] **Line 141:** `Container(`
- [ ] **Line 478:** `Container(`
- [ ] **Line 554:** `Container(`

#### `lib\features\tools\services\load_calculator.dart` (3 instances)

- [ ] **Line 223:** `Container(`
- [ ] **Line 377:** `Container(`
- [ ] **Line 695:** `Container(`

#### `lib\features\tools\services\voltage_drop_calculator.dart` (2 instances)

- [ ] **Line 134:** `Container(`
- [ ] **Line 538:** `Container(`

#### `lib\features\tools\services\wire_size_chart.dart` (4 instances)

- [ ] **Line 122:** `Container(`
- [ ] **Line 232:** `Container(`
- [ ] **Line 267:** `Container(`
- [ ] **Line 461:** `Container(`

#### `lib\features\unions\screens\locals_screen.dart` (4 instances)

- [ ] **Line 283:** `Container(`
- [ ] **Line 490:** `Container(`
- [ ] **Line 522:** `Container(`
- [ ] **Line 710:** `Container(`


### Row Column Widgets (171 opportunities)

#### `lib\core\widgets\contractor_card.dart` (1 instances)

- [ ] **Line 103:** `Row(`

#### `lib\core\widgets\notification_popup.dart` (1 instances)

- [ ] **Line 102:** `Column(`

#### `lib\core\widgets\offline_indicators.dart` (3 instances)

- [ ] **Line 359:** `Row(`
- [ ] **Line 478:** `Row(`
- [ ] **Line 502:** `Row(`

#### `lib\design_system\tailboard_components.dart` (1 instances)

- [ ] **Line 44:** `Row(`

#### `lib\design_system\components\job_card.dart` (12 instances)

- [ ] **Line 81:** `Row(`
- [ ] **Line 122:** `Row(`
- [ ] **Line 147:** `Row(`
- [ ] **Line 170:** `Row(`
- [ ] **Line 213:** `Row(`
- [ ] **Line 251:** `Row(`
- [ ] **Line 289:** `Row(`
- [ ] **Line 311:** `Row(`
- [ ] **Line 335:** `Row(`
- [ ] **Line 360:** `Row(`
- [ ] **Line 385:** `Row(`
- [ ] **Line 422:** `Row(`

#### `lib\design_system\electrical\jj_contractor_card.dart` (1 instances)

- [ ] **Line 67:** `Row(`

#### `lib\design_system\electrical\transformer_trainer\jj_transformer_trainer.dart` (1 instances)

- [ ] **Line 455:** `Row(`

#### `lib\design_system\electrical\transformer_trainer\modes\guided_mode.dart` (1 instances)

- [ ] **Line 119:** `Row(`

#### `lib\design_system\electrical\transformer_trainer\modes\quiz_mode.dart` (2 instances)

- [ ] **Line 88:** `Row(`
- [ ] **Line 162:** `Row(`

#### `lib\design_system\electrical\transformer_trainer\widgets\mobile_ui_patterns.dart` (1 instances)

- [ ] **Line 241:** `Row(`

#### `lib\design_system\electrical\transformer_trainer\widgets\transformer_diagram.dart` (2 instances)

- [ ] **Line 153:** `Row(`
- [ ] **Line 177:** `Row(`

#### `lib\features\auth\screens\auth_screen.dart` (2 instances)

- [ ] **Line 510:** `Row(`
- [ ] **Line 694:** `Row(`

#### `lib\features\auth\screens\forgot_password_screen.dart` (2 instances)

- [ ] **Line 249:** `Row(`
- [ ] **Line 320:** `Row(`

#### `lib\features\auth\screens\welcome_screen.dart` (2 instances)

- [ ] **Line 230:** `Row(`
- [ ] **Line 253:** `Row(`

#### `lib\features\crews\screens\create_crew_screen.dart` (2 instances)

- [ ] **Line 171:** `Row(`
- [ ] **Line 175:** `Row(`

#### `lib\features\crews\screens\tailboard_screen.dart` (4 instances)

- [ ] **Line 358:** `Row(`
- [ ] **Line 619:** `Row(`
- [ ] **Line 1072:** `Row(`
- [ ] **Line 1101:** `Row(`

#### `lib\features\crews\widgets\announcement_card.dart` (3 instances)

- [ ] **Line 73:** `Row(`
- [ ] **Line 114:** `Row(`
- [ ] **Line 117:** `Row(`

#### `lib\features\crews\widgets\comment_animation.dart` (1 instances)

- [ ] **Line 181:** `Row(`

#### `lib\features\crews\widgets\comment_input.dart` (2 instances)

- [ ] **Line 143:** `Row(`
- [ ] **Line 154:** `Row(`

#### `lib\features\crews\widgets\comment_item.dart` (1 instances)

- [ ] **Line 76:** `Row(`

#### `lib\features\crews\widgets\crew_member_avatar.dart` (2 instances)

- [ ] **Line 149:** `Row(`
- [ ] **Line 179:** `Row(`

#### `lib\features\crews\widgets\crew_preferences_dialog.dart` (1 instances)

- [ ] **Line 534:** `Row(`

#### `lib\features\crews\widgets\dm_preview_card.dart` (2 instances)

- [ ] **Line 98:** `Row(`
- [ ] **Line 124:** `Row(`

#### `lib\features\crews\widgets\job_match_card.dart` (3 instances)

- [ ] **Line 42:** `Row(`
- [ ] **Line 117:** `Row(`
- [ ] **Line 128:** `Row(`

#### `lib\features\crews\widgets\tab_widgets.dart` (2 instances)

- [ ] **Line 396:** `Row(`
- [ ] **Line 435:** `Row(`

#### `lib\features\crews\widgets\tailboard\apply_job_dialog.dart` (1 instances)

- [ ] **Line 128:** `Row(`

#### `lib\features\crews\widgets\tailboard\chat_history_dialog.dart` (1 instances)

- [ ] **Line 26:** `Row(`

#### `lib\features\crews\widgets\tailboard\classification_filter_dialog.dart` (1 instances)

- [ ] **Line 74:** `Row(`

#### `lib\features\crews\widgets\tailboard\construction_type_filter_dialog.dart` (1 instances)

- [ ] **Line 75:** `Row(`

#### `lib\features\crews\widgets\tailboard\direct_messages_dialog.dart` (1 instances)

- [ ] **Line 26:** `Row(`

#### `lib\features\crews\widgets\tailboard\feed_sort_options_dialog.dart` (1 instances)

- [ ] **Line 23:** `Row(`

#### `lib\features\crews\widgets\tailboard\job_preferences_dialog.dart` (2 instances)

- [ ] **Line 94:** `Row(`
- [ ] **Line 264:** `Row(`

#### `lib\features\crews\widgets\tailboard\local_filter_dialog.dart` (2 instances)

- [ ] **Line 96:** `Row(`
- [ ] **Line 103:** `Row(`

#### `lib\features\crews\widgets\tailboard\member_roles_dialog.dart` (2 instances)

- [ ] **Line 46:** `Row(`
- [ ] **Line 102:** `Row(`

#### `lib\features\crews\widgets\tailboard\member_roster_dialog.dart` (1 instances)

- [ ] **Line 128:** `Column(`

#### `lib\features\jobs\profile\screens\home_screen.dart` (1 instances)

- [ ] **Line 230:** `Row(`

#### `lib\features\jobs\profile\screens\onboarding_steps_screen.dart` (3 instances)

- [ ] **Line 462:** `Column(`
- [ ] **Line 574:** `Row(`
- [ ] **Line 660:** `Row(`

#### `lib\features\jobs\profile\screens\profile_screen.dart` (5 instances)

- [ ] **Line 585:** `Row(`
- [ ] **Line 609:** `Row(`
- [ ] **Line 675:** `Column(`
- [ ] **Line 849:** `Row(`
- [ ] **Line 907:** `Row(`

#### `lib\features\jobs\profile\screens\training_certificates_screen.dart` (6 instances)

- [ ] **Line 340:** `Row(`
- [ ] **Line 413:** `Row(`
- [ ] **Line 609:** `Row(`
- [ ] **Line 772:** `Row(`
- [ ] **Line 817:** `Row(`
- [ ] **Line 1026:** `Row(`

#### `lib\features\jobs\screens\jobs_screen.dart` (2 instances)

- [ ] **Line 184:** `Row(`
- [ ] **Line 384:** `Column(`

#### `lib\features\jobs\widgets\condensed_job_card.dart` (3 instances)

- [ ] **Line 43:** `Row(`
- [ ] **Line 116:** `Row(`
- [ ] **Line 141:** `Row(`

#### `lib\features\jobs\widgets\job_card_skeleton.dart` (2 instances)

- [ ] **Line 60:** `Row(`
- [ ] **Line 94:** `Row(`

#### `lib\features\jobs\widgets\job_details_dialog.dart` (1 instances)

- [ ] **Line 304:** `Row(`

#### `lib\features\jobs\widgets\job_suggestion_card.dart` (1 instances)

- [ ] **Line 44:** `Row(`

#### `lib\features\jobs\widgets\optimized_job_card.dart` (4 instances)

- [ ] **Line 34:** `Row(`
- [ ] **Line 42:** `Row(`
- [ ] **Line 50:** `Row(`
- [ ] **Line 60:** `Row(`

#### `lib\features\jobs\widgets\rich_text_job_card.dart` (2 instances)

- [ ] **Line 112:** `Row(`
- [ ] **Line 199:** `Row(`

#### `lib\features\settings\screens\app_settings_screen.dart` (1 instances)

- [ ] **Line 307:** `Row(`

#### `lib\features\settings\screens\feedback_screen.dart` (2 instances)

- [ ] **Line 128:** `Row(`
- [ ] **Line 302:** `Row(`

#### `lib\features\settings\screens\help_support_screen.dart` (3 instances)

- [ ] **Line 284:** `Row(`
- [ ] **Line 467:** `Row(`
- [ ] **Line 646:** `Row(`

#### `lib\features\settings\screens\job_search_preferences_screen.dart` (1 instances)

- [ ] **Line 297:** `Row(`

#### `lib\features\settings\screens\notifications_settings_screen.dart` (5 instances)

- [ ] **Line 170:** `Row(`
- [ ] **Line 192:** `Row(`
- [ ] **Line 475:** `Row(`
- [ ] **Line 588:** `Column(`
- [ ] **Line 1012:** `Row(`

#### `lib\features\settings\screens\settings_screen.dart` (3 instances)

- [ ] **Line 392:** `Row(`
- [ ] **Line 456:** `Row(`
- [ ] **Line 480:** `Row(`

#### `lib\features\settings\screens\sync_settings_screen.dart` (3 instances)

- [ ] **Line 89:** `Row(`
- [ ] **Line 108:** `Row(`
- [ ] **Line 316:** `Row(`

#### `lib\features\storm\screens\storm_screen.dart` (6 instances)

- [ ] **Line 130:** `Row(`
- [ ] **Line 198:** `Row(`
- [ ] **Line 223:** `Column(`
- [ ] **Line 307:** `Row(`
- [ ] **Line 337:** `Row(`
- [ ] **Line 366:** `Row(`

#### `lib\features\storm\widgets\noaa_radar_map.dart` (2 instances)

- [ ] **Line 591:** `Row(`
- [ ] **Line 634:** `Row(`

#### `lib\features\storm\widgets\power_outage_card.dart` (7 instances)

- [ ] **Line 43:** `Row(`
- [ ] **Line 90:** `Row(`
- [ ] **Line 112:** `Column(`
- [ ] **Line 151:** `Row(`
- [ ] **Line 160:** `Row(`
- [ ] **Line 219:** `Row(`
- [ ] **Line 250:** `Row(`

#### `lib\features\storm\widgets\storm_contractor_card.dart` (3 instances)

- [ ] **Line 129:** `Row(`
- [ ] **Line 153:** `Row(`
- [ ] **Line 178:** `Row(`

#### `lib\features\storm\widgets\storm_tracker_section.dart` (2 instances)

- [ ] **Line 29:** `Row(`
- [ ] **Line 32:** `Row(`

#### `lib\features\storm\widgets\storm_track_form.dart` (2 instances)

- [ ] **Line 236:** `Row(`
- [ ] **Line 283:** `Row(`

#### `lib\features\storm\widgets\storm_track_summary_sheet.dart` (1 instances)

- [ ] **Line 40:** `Row(`

#### `lib\features\tools\screens\electrical_calculators_screen.dart` (2 instances)

- [ ] **Line 281:** `Row(`
- [ ] **Line 795:** `Row(`

#### `lib\features\tools\screens\transformer_bank_screen.dart` (4 instances)

- [ ] **Line 145:** `Row(`
- [ ] **Line 204:** `Row(`
- [ ] **Line 348:** `Column(`
- [ ] **Line 351:** `Row(`

#### `lib\features\tools\screens\transformer_reference_screen.dart` (2 instances)

- [ ] **Line 121:** `Row(`
- [ ] **Line 141:** `Row(`

#### `lib\features\tools\services\conduit_fill_calculator.dart` (8 instances)

- [ ] **Line 262:** `Row(`
- [ ] **Line 303:** `Row(`
- [ ] **Line 328:** `Row(`
- [ ] **Line 374:** `Row(`
- [ ] **Line 458:** `Row(`
- [ ] **Line 487:** `Row(`
- [ ] **Line 517:** `Row(`
- [ ] **Line 632:** `Row(`

#### `lib\features\tools\services\load_calculator.dart` (6 instances)

- [ ] **Line 357:** `Row(`
- [ ] **Line 428:** `Row(`
- [ ] **Line 452:** `Row(`
- [ ] **Line 651:** `Row(`
- [ ] **Line 858:** `Row(`
- [ ] **Line 952:** `Row(`

#### `lib\features\tools\services\voltage_drop_calculator.dart` (4 instances)

- [ ] **Line 305:** `Row(`
- [ ] **Line 357:** `Row(`
- [ ] **Line 496:** `Row(`
- [ ] **Line 650:** `Row(`

#### `lib\features\tools\services\wire_size_chart.dart` (3 instances)

- [ ] **Line 149:** `Row(`
- [ ] **Line 499:** `Column(`
- [ ] **Line 532:** `Row(`

#### `lib\features\unions\screens\locals_screen.dart` (3 instances)

- [ ] **Line 107:** `Column(`
- [ ] **Line 259:** `Row(`
- [ ] **Line 302:** `Column(`


## Summary Statistics

| Category | Count |
|----------|-------|
| Text Widgets | 551 |
| Icon Widgets | 102 |
| SizedBox Widgets | 42 |
| Padding Widgets | 32 |
| EdgeInsets | 42 |
| TextStyle | 97 |
| Divider Widgets | 1 |
| Container Widgets | 185 |
| Row Column Widgets | 171 |
| **TOTAL OPPORTUNITIES** | **1223** |


## Recommendations

### High Priority (Likely Safe to Add Const)
1. **Text Widgets** - Most static Text widgets can be const
2. **Icon Widgets** - Icons with fixed IconData can be const  
3. **SizedBox** - Spacing boxes with fixed dimensions should be const
4. **Divider** - Static dividers can be const
5. **EdgeInsets** - All EdgeInsets with literal values should be const
6. **TextStyle** - Styles with literal values should be const

### Medium Priority (Requires Verification)
1. **Padding** - Check if padding values are literal
2. **Container** - Only if all properties are const (decoration, padding, etc.)

### Low Priority (Manual Review Needed)
1. **Row/Column** - Only if all children are const

## Next Steps

1. Review each category starting with High Priority items
2. For each instance, verify:
   - All constructor parameters are compile-time constants
   - No dynamic data or variables are used
   - The widget doesn't depend on runtime state
3. Add `const` keyword and test the build
4. Run `flutter analyze` to catch any invalid const usage

## Notes

- This is an automated analysis and may include false positives
- Always verify before adding `const` to ensure correctness
- Some widgets cannot be const if they reference non-const data
- Use IDE hints (VS Code/Android Studio) to validate const-correctness

---
*Generated by Const Opportunities Analyzer*
