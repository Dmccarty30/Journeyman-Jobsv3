# 🌪️ Storm Contractor Card - Implementation Plan

> **Created:** 2026-01-20  
> **Approach:** Option C - Hybrid (JSON Data + Firebase Storage Logos)  
> **Status:** 🟡 Ready for Implementation  
> **Priority:** Data Architecture First

---

## 📋 User Requirements Summary

| Requirement | Decision |
| ----------- | -------- |
| **Logo Source** | Developer will collect manually |
| **Logo Storage** | Firebase Storage (CDN cached) |
| **Offline Mode** | Online with caching acceptable |
| **Update Workflow** | Developer only, quarterly updates |
| **Firebase Services** | Firestore ✓, Storage ✓ (already configured) |
| **Card Design** | Faded watermark (20-30% opacity) as background |
| **Fallback** | Generic lightning bolt icon when no logo |
| **Data Volume** | ~60 contractors now, max ~250 in future |

---

## 🏗️ Architecture Diagram

```bash
┌──────────────────────────────────────────────────────────────────┐
│                         DATA FLOW                                │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│   📁 assets/data/storm_roster.json                               │
│          │                                                       │
│          │  (includes new LOGO_URL field)                        │
│          ▼                                                       │
│   ┌──────────────────────────┐                                   │
│   │   Contractor Model       │                                   │
│   │   + logoUrl: String?     │  ◄─── Enhanced with logoUrl       │
│   └──────────────────────────┘                                   │
│          │                                                       │
│          ▼                                                       │
│   ┌──────────────────────────┐    ┌────────────────────────────┐ │
│   │  StormContractorCard     │───►│  Firebase Storage          │ │
│   │  (Faded Logo Background) │    │  storm_contractors/logos/  │ │
│   └──────────────────────────┘    └────────────────────────────┘ │
│          │                                                       │
│          ▼                                                       │
│   ┌──────────────────────────┐                                   │
│   │  CachedNetworkImage      │                                   │
│   │  + Fallback Lightning ⚡  │                                   │
│   └──────────────────────────┘                                   │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

---

## 📝 ALL IMPLEMENTATION TASKS

---

### PHASE 1: Data Schema Updates

---

#### ⬜ Task 1.1: Add LOGO_URL Field to JSON Schema

**File:** `assets/data/storm_roster.json`

**Description:**  
Add a new `LOGO_URL` field to every contractor entry in the JSON file. This field will hold the Firebase Storage URL for the company logo. Initially, most will be empty strings until logos are collected and uploaded.

**Before:**

```json
{
    "COMPANY": "ADVENT",
    "HOW TO SIGNUP": "Online",
    "WEBSITE": "https://callfire-widgets-prod.s3.amazonaws.com/..."
}
```

**After:**

```json
{
    "COMPANY": "ADVENT",
    "HOW TO SIGNUP": "Online",
    "WEBSITE": "https://callfire-widgets-prod.s3.amazonaws.com/...",
    "LOGO_URL": ""
}
```

**Acceptance Criteria:**

- [ ] Every contractor entry (60+) has a `LOGO_URL` field
- [ ] Field can be empty string `""` or null when no logo exists
- [ ] JSON remains valid and parseable

---

#### ⬜ Task 1.2: Update Contractor Model with logoUrl Field

**File:** `lib/core/models/contractor_model.dart`

**Description:**  
Add a new `logoUrl` property to the Contractor model class. Update the constructor, fromJson, toJson, toFirestore, copyWith, toString, ==, and hashCode methods.

**Changes Required:**

1. **Add field declaration:**

```dart
final String? logoUrl;
```

1. **Update constructor:**

```dart
Contractor({
  // ... existing params ...
  this.logoUrl,
})
```

1. **Update fromJson:**

```dart
logoUrl: json['LOGO_URL'] ?? json['logoUrl'],
```

1. **Update toJson:**

```dart
'logoUrl': logoUrl,
```

1. **Update toFirestore:**

```dart
'logoUrl': logoUrl,
```

1. **Update copyWith:**

```dart
String? logoUrl,
// ...
logoUrl: logoUrl ?? this.logoUrl,
```

1. **Update toString:**

```dart
return 'Contractor(id: $id, company: $company, ..., logoUrl: $logoUrl)';
```

1. **Update == operator:**

```dart
other.logoUrl == logoUrl &&
```

1. **Update hashCode:**

```dart
^ (logoUrl?.hashCode ?? 0)
```

**Acceptance Criteria:**

- [ ] Model compiles without errors
- [ ] `fromJson` correctly parses both `LOGO_URL` (JSON) and `logoUrl` (Firestore)
- [ ] `toJson` and `toFirestore` include the new field
- [ ] `copyWith` supports the new field
- [ ] Equality and hash code updated

---

### PHASE 2: Firebase Storage Setup (Manual Steps)

---

#### ⬜ Task 2.1: Create Firebase Storage Folder Structure

**Location:** Firebase Console > Storage

**Description:**  
Create the folder structure in Firebase Storage to organize contractor logos.

**Folder Structure:**

```bash
gs://your-bucket-name/
└── storm_contractors/
    └── logos/
        ├── advent.png
        ├── agostino_utilities.png
        ├── alliance_power_group.png
        └── ... (upload as collected)
```

**File Naming Convention:**

| Company Name | File Name |
| ------------- | --------- |
| ADVENT | `advent.png` |
| AGOSTINO UTILITIES | `agostino_utilities.png` |
| ALLIANCE POWER GROUP | `alliance_power_group.png` |
| J.W. DIDADO | `jw_didado.png` |

**Rules:**

- Lowercase only
- Replace spaces with underscores `_`
- Remove special characters (periods, commas, apostrophes)
- PNG format preferred (supports transparency)

**Acceptance Criteria:**

- [ ] Folder `storm_contractors/logos/` exists in Firebase Storage
- [ ] At least one test image uploaded to verify access

---

#### ⬜ Task 2.2: Configure Firebase Storage Security Rules

**Location:** Firebase Console > Storage > Rules

**Description:**  
Update security rules to allow public read access to contractor logos (for CDN caching) while preventing unauthorized uploads.

**Security Rules:**

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    
    // Storm contractor logos - public read, no public write
    match /storm_contractors/logos/{fileName} {
      allow read: if true;      // Public CDN access
      allow write: if false;    // Only admin/CLI upload
    }
    
    // ... your other existing rules ...
    
  }
}
```

**Acceptance Criteria:**

- [ ] Rules deployed successfully
- [ ] Test logo URL is accessible in browser without authentication
- [ ] Write access is denied for anonymous users

---

### PHASE 3: Flutter Package & Widget Updates

---

#### ⬜ Task 3.1: Add cached_network_image Package

**File:** `pubspec.yaml`

**Description:**  
Add the `cached_network_image` package to efficiently load and cache logo images from Firebase Storage.

**Add to dependencies:**

```yaml
dependencies:
  cached_network_image: ^3.3.1
```

**Command:**

```bash
flutter pub get
```

**Acceptance Criteria:**

- [ ] Package added to pubspec.yaml
- [ ] `flutter pub get` runs successfully
- [ ] No dependency conflicts

---

#### ⬜ Task 3.2: Update StormContractorCard Widget - Add Logo Background

**File:** `lib/features/storm/widgets/storm_contractor_card.dart`

**Description:**  
Modify the card widget to display the company logo as a faded watermark background. Implement fallback to a lightning bolt icon when no logo URL is available.

**Import to add:**

```dart
import 'package:cached_network_image/cached_network_image.dart';
```

**New method to add:**

```dart
/// Builds the logo background layer with faded watermark effect
Widget _buildLogoBackground() {
  final logoUrl = contractor.logoUrl;
  
  // Fallback: Lightning bolt icon when no logo
  if (logoUrl == null || logoUrl.isEmpty) {
    return Positioned.fill(
      child: Opacity(
        opacity: 0.08,
        child: Center(
          child: Icon(
            Icons.flash_on,
            size: 150,
            color: AppTheme.accentCopper,
          ),
        ),
      ),
    );
  }

  // Logo from Firebase Storage with faded effect
  return Positioned.fill(
    child: Opacity(
      opacity: 0.15, // Faded watermark (adjust 0.1-0.25)
      child: CachedNetworkImage(
        imageUrl: logoUrl,
        fit: BoxFit.contain,
        alignment: Alignment.center,
        placeholder: (context, url) => const SizedBox.shrink(),
        errorWidget: (context, url, error) => Center(
          child: Icon(
            Icons.flash_on,
            size: 150,
            color: AppTheme.accentCopper.withOpacity(0.5),
          ),
        ),
      ),
    ),
  );
}
```

**Update build() method:**

```dart
@override
Widget build(BuildContext context) {
  return Container(
    // ... existing margin and decoration ...
    child: ClipRRect(
      // ... existing borderRadius ...
      child: Stack(
        children: [
          // NEW: Logo background layer (behind everything)
          _buildLogoBackground(),
          
          // EXISTING: Background accent icon (update or remove)
          // Positioned(right: -20, top: -20, ...)
          
          // EXISTING: Content padding and column
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacingLg),
            child: Column(
              // ... existing content ...
            ),
          ),
        ],
      ),
    ),
  );
}
```

**Acceptance Criteria:**

- [ ] Card builds without errors
- [ ] Logo displays with ~15% opacity (faded watermark effect)
- [ ] Lightning bolt icon shows when `logoUrl` is null or empty
- [ ] Lightning bolt icon shows when image fails to load (network error)
- [ ] Images are cached (no re-download on scroll)

---

#### ⬜ Task 3.3: Remove Duplicate Background Icon (Optional Cleanup)

**File:** `lib/features/storm/widgets/storm_contractor_card.dart`

**Description:**  
The existing card has a faded `flash_on` icon in the top-right corner (lines 80-88). Since we're adding a proper logo background with fallback, this may become redundant.

**Decision Options:**

1. **Remove it** - Cleaner look with just the logo/fallback
2. **Keep it** - Additional visual element in corner
3. **Move it** - Put it in a different position as accent

**Current Code (lines 80-88):**

```dart
Positioned(
  right: -20,
  top: -20,
  child: Icon(
    Icons.flash_on,
    size: 100,
    color: AppTheme.accentCopper.withValues(alpha: 0.05),
  ),
),
```

**Acceptance Criteria:**

- [ ] Decision made on keeping/removing existing icon
- [ ] If removed, no visual artifacts remain
- [ ] If kept, ensure it doesn't conflict with new logo background

---

### PHASE 4: Utility Helpers (Optional)

---

#### ⬜ Task 4.1: Create Firebase Storage URL Helper

**File:** `lib/core/utils/firebase_storage_helper.dart` (NEW FILE)

**Description:**  
Create a helper class that generates Firebase Storage URLs from company names. This makes it easier to bulk-update the JSON file with correct URLs.

**Code:**

```dart
/// Helper utilities for Firebase Storage operations
class FirebaseStorageHelper {
  // TODO: Replace with your actual bucket name
  static const String _bucket = 'your-project-id.appspot.com';
  static const String _logoPath = 'storm_contractors/logos';
  
  /// Converts a company name to a Firebase Storage download URL
  /// 
  /// Example:
  /// ```dart
  /// getLogoUrl("ALLIANCE POWER GROUP")
  /// // Returns: https://firebasestorage.googleapis.com/v0/b/.../alliance_power_group.png?alt=media
  /// ```
  static String getLogoUrl(String companyName) {
    final slug = _slugify(companyName);
    return 'https://firebasestorage.googleapis.com/v0/b/$_bucket/o/$_logoPath%2F$slug.png?alt=media';
  }
  
  /// Converts company name to URL-safe slug
  /// 
  /// Example: "J.W. DIDADO" → "jw_didado"
  static String _slugify(String name) {
    return name
        .toLowerCase()
        .trim()
        .replaceAll(RegExp(r'[.\-\'\"]+'), '')  // Remove periods, hyphens, quotes
        .replaceAll(RegExp(r'\s+'), '_')         // Spaces to underscores
        .replaceAll(RegExp(r'[^a-z0-9_]'), '');  // Remove other special chars
  }
  
  /// Gets just the filename slug (for uploading)
  /// 
  /// Example: "ALLIANCE POWER GROUP" → "alliance_power_group.png"
  static String getLogoFileName(String companyName) {
    return '${_slugify(companyName)}.png';
  }
}
```

**Usage Example:**

```dart
// Generate URL for JSON
final url = FirebaseStorageHelper.getLogoUrl("ADVENT");
// → https://firebasestorage.googleapis.com/v0/b/.../advent.png?alt=media

// Get filename for upload
final fileName = FirebaseStorageHelper.getLogoFileName("ADVENT");
// → advent.png
```

**Acceptance Criteria:**

- [ ] Helper class compiles without errors
- [ ] URLs correctly formatted for Firebase Storage
- [ ] Slugify handles special characters (periods, apostrophes, etc.)

---

### PHASE 5: Testing & Verification

---

#### ⬜ Task 5.1: Test with Sample Logo

**Description:**  
Upload a test logo to Firebase Storage and update one JSON entry to verify the entire flow works.

**Steps:**

1. Upload any PNG image to `storm_contractors/logos/test_company.png`
2. Get the public URL from Firebase Storage
3. Update one entry in `storm_roster.json`:

   ```json
   {
     "COMPANY": "ADVENT",
     "LOGO_URL": "https://firebasestorage.googleapis.com/v0/b/..."
   }
   ```

4. Run the app and verify:
   - Logo appears as faded background
   - Opacity is correct (~15-20%)
   - Image is cached on scroll

**Acceptance Criteria:**

- [ ] Test logo displays correctly
- [ ] Opacity creates readable text overlay
- [ ] Caching works (no flicker on scroll)

---

#### ⬜ Task 5.2: Test Fallback Behavior

**Description:**  
Verify the fallback lightning bolt icon works correctly.

**Test Cases:**

1. **Empty string:** `"LOGO_URL": ""` → Should show fallback icon
2. **Null value:** No LOGO_URL field → Should show fallback icon
3. **Invalid URL:** `"LOGO_URL": "https://invalid..."` → Should show fallback icon
4. **Network error:** Disconnect internet → Should show fallback icon

**Acceptance Criteria:**

- [ ] All four test cases show the fallback lightning bolt icon
- [ ] No error dialogs or red error screens
- [ ] Graceful degradation

---

#### ⬜ Task 5.3: Full Regression Test

**Description:**  
Verify all existing card functionality still works after changes.

**Test Checklist:**

- [ ] Company name displays correctly
- [ ] "Sign Up Online" button works (launches URL)
- [ ] "Text to Apply" button works (opens SMS)
- [ ] Phone call button works
- [ ] Email button works
- [ ] Address displays when available
- [ ] Card styling/borders unchanged
- [ ] Scrolling performance is smooth

---

## ✅ Master Checklist

| Phase | Task | Status | Assignee |
| ----- | ---- | ------ | -------- |
| **1** | 1.1 Add LOGO_URL to JSON schema | ⬜ | Claude |
| **1** | 1.2 Update Contractor model | ⬜ | Claude |
| **2** | 2.1 Create Storage folder structure | ⬜ | User (Manual) |
| **2** | 2.2 Configure Storage security rules | ⬜ | User (Manual) |
| **3** | 3.1 Add cached_network_image package | ⬜ | Claude |
| **3** | 3.2 Update StormContractorCard widget | ⬜ | Claude |
| **3** | 3.3 Remove duplicate background icon | ⬜ | Claude |
| **4** | 4.1 Create Firebase Storage URL helper | ⬜ | Claude |
| **5** | 5.1 Test with sample logo | ⬜ | User |
| **5** | 5.2 Test fallback behavior | ⬜ | User |
| **5** | 5.3 Full regression test | ⬜ | User |

---

## 🚀 Ready to Execute?

**Reply with "Go" to start implementation!**

I will execute:

- Task 1.1: Add LOGO_URL to all JSON entries
- Task 1.2: Update Contractor model
- Task 3.1: Add cached_network_image package
- Task 3.2: Update StormContractorCard widget
- Task 4.1: Create helper utility

You will need to manually:

- Task 2.1: Create Firebase Storage folder
- Task 2.2: Update Storage security rules
- Task 5.x: Testing tasks

---

## � Future Enhancements (Not in Scope)

For later consideration:

- [ ] Migrate JSON data to Firestore collection
- [ ] Build admin panel for managing contractors
- [ ] Implement contractor search/filter functionality
- [ ] Add contractor location on map view
- [ ] Implement "favorite" contractors feature
