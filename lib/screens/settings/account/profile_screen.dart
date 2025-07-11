import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../design_system/app_theme.dart';
import '../../../design_system/components/reusable_components.dart';
import '../../../electrical_components/jj_circuit_breaker_switch.dart';
import '../../../electrical_components/jj_circuit_breaker_switch_list_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isEditing = false;
  OverlayEntry? _overlayEntry;
  bool _hasShownTooltip = false;
  final GlobalKey _editButtonKey = GlobalKey();
  
  // Personal Information Controllers
  final _firstNameController = TextEditingController(text: 'John');
  final _lastNameController = TextEditingController(text: 'Smith');
  final _emailController = TextEditingController(text: 'john.smith@email.com');
  final _phoneController = TextEditingController(text: '(555) 123-4567');
  final _address1Controller = TextEditingController(text: '123 Electrician Ave');
  final _address2Controller = TextEditingController(text: 'Apt 4B');
  final _cityController = TextEditingController(text: 'Louisville');
  final _stateController = TextEditingController(text: 'KY');
  final _zipcodeController = TextEditingController(text: '40203');
  
  // Professional Information Controllers
  final _homeLocalController = TextEditingController(text: 'IBEW Local 369');
  final _ticketNumberController = TextEditingController(text: 'J123456789');
  final _booksOnController = TextEditingController(text: 'Book 1');
  String _selectedClassification = 'Journeyman Lineman';
  bool _isWorking = true;
  
  // Job Preferences
  final Set<String> _selectedConstructionTypes = {'Distribution', 'Transmission'};
  String _selectedHoursPerWeek = 'Open to overtime';
  String _selectedPerDiem = 'Yes, required';
  final _preferredLocalsController = TextEditingController(text: 'Local 369, Local 77, Local 613');
  final _careerGoalsController = TextEditingController(text: 'Advance to foreman position, gain more storm restoration experience');
  
  // Additional onboarding fields that were missing
  bool _networkWithOthers = true;
  bool _careerAdvancements = false;
  bool _betterBenefits = true;
  bool _higherPayRate = true;
  bool _learnNewSkill = false;
  bool _travelToNewLocation = true;
  bool _findLongTermWork = false;
  final _howHeardAboutUsController = TextEditingController(text: 'Referred by IBEW Local 369');
  final _lookingToAccomplishController = TextEditingController(text: 'Find steady work with good benefits and advancement opportunities');
  
  // Notification Settings
  bool _jobAlerts = true;
  bool _stormAlerts = true;
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  bool _weeklyDigest = false;

  final List<String> _classifications = [
    'Journeyman Lineman',
    'Journeyman Electrician',
    'Journeyman Wireman',
    'Journeyman Tree Trimmer',
    'Operator',
  ];

  final List<String> _constructionTypes = [
    'Distribution',
    'Transmission',
    'SubStation',
    'Residential',
    'Industrial',
    'Data Center',
    'Commercial',
    'Underground',
  ];

  final List<String> _hoursOptions = [
    '40',
    '40-50', 
    '50-60',
    '60-70',
    '>70',
    'Open to overtime',
    'Standard hours only',
  ];

  final List<String> _perDiemOptions = [
    '100-150',
    '150-200', 
    '200+',
    'Yes, required',
    'Preferred but not required',
    'Not needed',
  ];

  final List<String> _usStates = [
    'AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA',
    'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD',
    'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ',
    'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC',
    'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY',
    'DC',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadUserData();
    
    // Show tooltip after 1 second if not shown before
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && !_hasShownTooltip && !_isEditing) {
        _showEditTooltip();
      }
    });
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _tabController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _address1Controller.dispose();
    _address2Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipcodeController.dispose();
    _homeLocalController.dispose();
    _ticketNumberController.dispose();
    _booksOnController.dispose();
    _preferredLocalsController.dispose();
    _careerGoalsController.dispose();
    _howHeardAboutUsController.dispose();
    _lookingToAccomplishController.dispose();
    super.dispose();
  }

  void _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      // Load from Firebase Auth first (basic info)
      _emailController.text = user.email ?? '';
      if (user.displayName != null) {
        final nameParts = user.displayName!.split(' ');
        if (nameParts.isNotEmpty) {
          _firstNameController.text = nameParts.first;
          if (nameParts.length > 1) {
            _lastNameController.text = nameParts.skip(1).join(' ');
          }
        }
      }

      // Load from Firestore (detailed profile data)
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (doc.exists) {
        final data = doc.data()!;
        
        setState(() {
          // Personal Information
          _firstNameController.text = data['first_name'] ?? _firstNameController.text;
          _lastNameController.text = data['last_name'] ?? _lastNameController.text;
          _phoneController.text = data['phone_number'] ?? '';
          _address1Controller.text = data['address1'] ?? '';
          _address2Controller.text = data['address2'] ?? '';
          _cityController.text = data['city'] ?? '';
          _stateController.text = (data['state'] as String?)?.toUpperCase() ?? '';
          _zipcodeController.text = data['zipcode']?.toString() ?? '';
          
          // Professional Information
          _homeLocalController.text = data['home_local'] ?? '';
          _ticketNumberController.text = data['ticket_number']?.toString() ?? '';
          _booksOnController.text = data['books_on'] ?? '';
          _selectedClassification = data['classification'] ?? 'Journeyman Lineman';
          _isWorking = data['is_working'] ?? false;
          
          // Job Preferences
          if (data['constructionTypes'] != null) {
            _selectedConstructionTypes.clear();
            _selectedConstructionTypes.addAll(List<String>.from(data['constructionTypes']));
          }
          _selectedHoursPerWeek = data['hours_per_week'] ?? '40+ hours';
          _selectedPerDiem = data['per_diem_requirement'] ?? 'Yes, required';
          _preferredLocalsController.text = data['preferred_locals'] ?? '';
          _careerGoalsController.text = data['careerGoals'] ?? '';
          
          // Job Search Goals
          _networkWithOthers = data['networkWithOthers'] ?? false;
          _careerAdvancements = data['careerAdvancements'] ?? false;
          _betterBenefits = data['betterBenefits'] ?? false;
          _higherPayRate = data['higherPayRate'] ?? false;
          _learnNewSkill = data['learnNewSkill'] ?? false;
          _travelToNewLocation = data['travelToNewLocation'] ?? false;
          _findLongTermWork = data['findLongTermWork'] ?? false;
          
          // Additional Information
          _howHeardAboutUsController.text = data['how_heard_about_us'] ?? '';
          _lookingToAccomplishController.text = data['lookingToAccomplish'] ?? '';
          
          // Notification Settings
          _jobAlerts = data['job_alerts'] ?? true;
          _stormAlerts = data['storm_alerts'] ?? true;
          _emailNotifications = data['email_notifications'] ?? true;
          _pushNotifications = data['push_notifications'] ?? true;
          _weeklyDigest = data['weekly_digest'] ?? false;
        });
      }
    } catch (e) {
      if (mounted) {
        JJSnackBar.showError(
          context: context,
          message: 'Error loading profile data: ${e.toString()}',
        );
      }
    }
  }

  void _toggleEditing() {
    _hideTooltip();
    setState(() {
      _isEditing = !_isEditing;
      _hasShownTooltip = true; // Mark tooltip as shown when user starts editing
    });
  }
  
  void _showEditTooltip() {
    if (_overlayEntry != null || _hasShownTooltip) return;

    final renderBox = _editButtonKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate tooltip width and position
    const tooltipWidth = 200.0;
    const padding = 16.0;

    // Position tooltip to the left of the button, ensuring it stays on screen
    final buttonCenterX = offset.dx + (size.width / 2);
    final idealLeft = buttonCenterX - tooltipWidth + 40; // Shift left significantly
    final finalLeft = (idealLeft < padding) ? padding : idealLeft;

    // Make sure tooltip doesn't go off the right edge either
    final maxLeft = screenWidth - tooltipWidth - padding;
    final adjustedLeft = (finalLeft > maxLeft) ? maxLeft : finalLeft;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Main tooltip
          Positioned(
            left: adjustedLeft,
            top: offset.dy + size.height + 8, // Position below the button
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: _hideTooltip,
                child: Container(
                  width: tooltipWidth,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryNavy,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.accentCopper, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryNavy.withAlpha(51),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Tap here to edit your profile settings and preferences',
                        style: AppTheme.bodyMedium.copyWith(
                          color: AppTheme.white,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Arrow pointing up to the edit button
          Positioned(
            left: buttonCenterX - 8, // Center arrow on button
            top: offset.dy + size.height - 2, // Position at top of tooltip
            child: CustomPaint(
              size: const Size(16, 10),
              painter: ArrowPainter(AppTheme.accentCopper),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);

    // Auto-dismiss after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      _hideTooltip();
    });
  }
  
  void _hideTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _hasShownTooltip = true;
    });
  }

  void _saveProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      JJSnackBar.showError(
        context: context,
        message: 'User not authenticated',
      );
      return;
    }

    try {
      // Show loading indicator
      setState(() {
        _isEditing = false;
      });

      // Prepare data for Firestore
      final profileData = {
        // Personal Information
        'first_name': _firstNameController.text.trim(),
        'last_name': _lastNameController.text.trim(),
        'phone_number': _phoneController.text.trim(),
        'address1': _address1Controller.text.trim(),
        'address2': _address2Controller.text.trim().isEmpty ? null : _address2Controller.text.trim(),
        'city': _cityController.text.trim(),
        'state': _stateController.text.trim(),
        'zipcode': int.tryParse(_zipcodeController.text.trim()),
        
        // Professional Information
        'home_local': _homeLocalController.text.trim().isNotEmpty ? _homeLocalController.text.trim() : null,
        'ticket_number': int.tryParse(_ticketNumberController.text.trim()),
        'books_on': _booksOnController.text.trim().isEmpty ? null : _booksOnController.text.trim(),
        'classification': _selectedClassification,
        'is_working': _isWorking,
        
        // Job Preferences
        'constructionTypes': _selectedConstructionTypes.toList(),
        'hours_per_week': _selectedHoursPerWeek,
        'per_diem_requirement': _selectedPerDiem,
        'preferred_locals': _preferredLocalsController.text.trim().isEmpty ? null : _preferredLocalsController.text.trim(),
        'careerGoals': _careerGoalsController.text.trim().isEmpty ? null : _careerGoalsController.text.trim(),
        
        // Job Search Goals
        'networkWithOthers': _networkWithOthers,
        'careerAdvancements': _careerAdvancements,
        'betterBenefits': _betterBenefits,
        'higherPayRate': _higherPayRate,
        'learnNewSkill': _learnNewSkill,
        'travelToNewLocation': _travelToNewLocation,
        'findLongTermWork': _findLongTermWork,
        
        // Additional Information
        'how_heard_about_us': _howHeardAboutUsController.text.trim().isEmpty ? null : _howHeardAboutUsController.text.trim(),
        'lookingToAccomplish': _lookingToAccomplishController.text.trim().isEmpty ? null : _lookingToAccomplishController.text.trim(),
        
        // Notification Settings
        'job_alerts': _jobAlerts,
        'storm_alerts': _stormAlerts,
        'email_notifications': _emailNotifications,
        'push_notifications': _pushNotifications,
        'weekly_digest': _weeklyDigest,
        
        // Metadata
        'updated_time': FieldValue.serverTimestamp(),
      };

      // Save to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set(profileData, SetOptions(merge: true));

      // Update Firebase Auth display name if needed
      final newDisplayName = '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}';
      if (user.displayName != newDisplayName) {
        await user.updateDisplayName(newDisplayName);
      }

      if (mounted) {
        JJSnackBar.showSuccess(
          context: context,
          message: 'Profile updated successfully!',
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isEditing = true; // Re-enable editing on error
        });
        JJSnackBar.showError(
          context: context,
          message: 'Error saving profile: ${e.toString()}',
        );
      }
    }
  }

  void _cancelEditing() {
    setState(() {
      _isEditing = false;
    });
    _loadUserData(); // Reset to original values from Firestore
  }

  // Method to check if keyboard is visible by checking the bottom viewInsets
  bool _isKeyboardVisible() {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryNavy,
        elevation: 0,
        title: Text(
          'Profile',
          style: AppTheme.headlineMedium.copyWith(color: AppTheme.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (_isEditing)
            TextButton(
              onPressed: _cancelEditing,
              child: Text(
                'Cancel',
                style: AppTheme.bodyMedium.copyWith(color: AppTheme.white),
              ),
            )
          else
            IconButton(
              key: _editButtonKey,
              icon: const Icon(Icons.edit, color: AppTheme.white),
              onPressed: _toggleEditing,
            ),
        ],
      ),
      body: Column(
        children: [
          // Profile header
          Container(
            color: AppTheme.primaryNavy,
            padding: const EdgeInsets.fromLTRB(
              AppTheme.spacingLg,
              0,
              AppTheme.spacingLg,
              AppTheme.spacingLg,
            ),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppTheme.accentCopper,
                    shape: BoxShape.circle,
                    boxShadow: [AppTheme.shadowMd],
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 40,
                    color: AppTheme.white,
                  ),
                ),
                const SizedBox(width: AppTheme.spacingMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_firstNameController.text} ${_lastNameController.text}',
                        style: AppTheme.headlineMedium.copyWith(
                          color: AppTheme.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacingXs),
                      Text(
                        _selectedClassification,
                        style: AppTheme.bodyLarge.copyWith(
                          color: AppTheme.accentCopper,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacingXs),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Home Local ',
                              style: AppTheme.bodyMedium.copyWith(
                                color: AppTheme.white.withValues(alpha: 0.8),
                              ),
                            ),
                            TextSpan(
                              text: _homeLocalController.text.isNotEmpty ? _homeLocalController.text : '---',
                              style: AppTheme.bodyMedium.copyWith(
                                color: AppTheme.accentCopper,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tab bar
          Container(
            color: AppTheme.primaryNavy,
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppTheme.accentCopper,
              labelColor: AppTheme.white,
              unselectedLabelColor: AppTheme.white.withValues(alpha: 0.7),
              tabs: const [
                Tab(text: 'Personal'),
                Tab(text: 'Professional'),
                Tab(text: 'Settings'),
              ],
            ),
          ),

          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPersonalTab(),
                _buildProfessionalTab(),
                _buildSettingsTab(),
              ],
            ),
          ),

          // Save button (when editing and keyboard is not visible)
          if (_isEditing && !_isKeyboardVisible())
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              child: JJPrimaryButton(
                text: 'Save Changes',
                icon: Icons.save,
                onPressed: _saveProfile,
                isFullWidth: true,
              ),
            ),
        ],
      ),
    );
  }
 
  Widget _buildPersonalTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        AppTheme.spacingMd,
        AppTheme.spacingMd,
        AppTheme.spacingMd,
        AppTheme.spacingMd + MediaQuery.of(context).padding.bottom + (_isEditing && !_isKeyboardVisible() ? 80 : 0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personal Information',
            style: AppTheme.headlineSmall.copyWith(
              color: AppTheme.primaryNavy,
            ),
          ),
          const SizedBox(height: AppTheme.spacingMd),

          // Name fields
          Row(
            children: [
              Expanded(
                child: JJTextField(
                  label: 'First Name',
                  controller: _firstNameController,
                  enabled: _isEditing,
                  prefixIcon: Icons.person_outline,
                ),
              ),
              const SizedBox(width: AppTheme.spacingMd),
              Expanded(
                child: JJTextField(
                  label: 'Last Name',
                  controller: _lastNameController,
                  enabled: _isEditing,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppTheme.spacingMd),

          // Contact information
          JJTextField(
            label: 'Email',
            controller: _emailController,
            enabled: false, // Email shouldn't be editable
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: AppTheme.spacingMd),

          JJTextField(
            label: 'Phone Number',
            controller: _phoneController,
            enabled: _isEditing,
            prefixIcon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
          ),

          const SizedBox(height: AppTheme.spacingLg),

          Text(
            'Address',
            style: AppTheme.headlineSmall.copyWith(
              color: AppTheme.primaryNavy,
            ),
          ),
          const SizedBox(height: AppTheme.spacingMd),

          JJTextField(
            label: 'Street Address',
            controller: _address1Controller,
            enabled: _isEditing,
            prefixIcon: Icons.home_outlined,
          ),

          const SizedBox(height: AppTheme.spacingMd),

          JJTextField(
            label: 'Apartment, suite, etc. (optional)',
            controller: _address2Controller,
            enabled: _isEditing,
          ),

          const SizedBox(height: AppTheme.spacingMd),

          Row(
            children: [
              Expanded(
                flex: 2,
                child: JJTextField(
                  label: 'City',
                  controller: _cityController,
                  enabled: _isEditing,
                ),
              ),
              const SizedBox(width: AppTheme.spacingMd),
              Expanded(
                child: _isEditing
                    ? Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.lightGray),
                          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: _stateController.text.isNotEmpty && _usStates.contains(_stateController.text.toUpperCase())
                              ? _stateController.text.toUpperCase()
                              : null,
                          decoration: const InputDecoration(
                            labelText: 'State',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: AppTheme.spacingMd,
                              vertical: AppTheme.spacingMd,
                            ),
                          ),
                          items: _usStates.map((state) {
                            return DropdownMenuItem(
                              value: state,
                              child: Text(state),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _stateController.text = value ?? '';
                            });
                          },
                        ),
                      )
                    : JJTextField(
                        label: 'State',
                        controller: _stateController,
                        enabled: false,
                      ),
              ),
              const SizedBox(width: AppTheme.spacingMd),
              Expanded(
                child: JJTextField(
                  label: 'ZIP Code',
                  controller: _zipcodeController,
                  enabled: _isEditing,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfessionalTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        AppTheme.spacingMd,
        AppTheme.spacingMd,
        AppTheme.spacingMd,
        AppTheme.spacingMd + MediaQuery.of(context).padding.bottom + (_isEditing && !_isKeyboardVisible() ? 80 : 0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'IBEW Information',
            style: AppTheme.headlineSmall.copyWith(
              color: AppTheme.primaryNavy,
            ),
          ),
          const SizedBox(height: AppTheme.spacingMd),

          JJTextField(
            label: 'Home Local',
            controller: _homeLocalController,
            enabled: _isEditing,
            prefixIcon: Icons.business_outlined,
          ),

          const SizedBox(height: AppTheme.spacingMd),

          JJTextField(
            label: 'Ticket Number',
            controller: _ticketNumberController,
            enabled: _isEditing,
            prefixIcon: Icons.badge_outlined,
          ),

          const SizedBox(height: AppTheme.spacingMd),

          // Classification dropdown
          if (_isEditing)
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.lightGray),
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: DropdownButtonFormField<String>(
                value: _selectedClassification,
                decoration: const InputDecoration(
                  labelText: 'Classification',
                  prefixIcon: Icon(Icons.work_outline),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingMd,
                    vertical: AppTheme.spacingMd,
                  ),
                ),
                items: _classifications.map((classification) {
                  return DropdownMenuItem(
                    value: classification,
                    child: Text(classification),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedClassification = value!;
                  });
                },
              ),
            )
          else
            JJTextField(
              label: 'Classification',
              controller: TextEditingController(text: _selectedClassification),
              enabled: false,
              prefixIcon: Icons.work_outline,
            ),

          const SizedBox(height: AppTheme.spacingMd),

          JJTextField(
            label: 'Books On',
            controller: _booksOnController,
            enabled: _isEditing,
            prefixIcon: Icons.menu_book_outlined,
          ),

          const SizedBox(height: AppTheme.spacingMd),

          // Working status
          if (_isEditing)
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.lightGray),
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: Row(
                children: [
                  const Icon(Icons.work_outline, color: AppTheme.textSecondary),
                  const SizedBox(width: AppTheme.spacingMd),
                  Text(
                    'Currently Working:',
                    style: AppTheme.bodyMedium.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const Spacer(),
                  JJCircuitBreakerSwitch(
                    value: _isWorking,
                    onChanged: (value) {
                      setState(() {
                        _isWorking = value;
                      });
                    },
                    size: JJCircuitBreakerSize.small,
                    showElectricalEffects: true,
                  ),
                ],
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.lightGray),
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: Row(
                children: [
                  const Icon(Icons.work_outline, color: AppTheme.textSecondary),
                  const SizedBox(width: AppTheme.spacingMd),
                  Text(
                    'Currently Working:',
                    style: AppTheme.bodyMedium.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingSm,
                      vertical: AppTheme.spacingXs,
                    ),
                    decoration: BoxDecoration(
                      color: _isWorking ? AppTheme.successGreen : AppTheme.errorRed,
                      borderRadius: BorderRadius.circular(AppTheme.radiusXs),
                    ),
                    child: Text(
                      _isWorking ? 'Yes' : 'No',
                      style: AppTheme.labelSmall.copyWith(
                        color: AppTheme.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: AppTheme.spacingLg),

          Text(
            'Job Preferences',
            style: AppTheme.headlineSmall.copyWith(
              color: AppTheme.primaryNavy,
            ),
          ),
          const SizedBox(height: AppTheme.spacingMd),

          // Construction types
          Text(
            'Preferred Construction Types:',
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppTheme.spacingSm),

          if (_isEditing)
            Wrap(
              spacing: AppTheme.spacingSm,
              runSpacing: AppTheme.spacingSm,
              children: _constructionTypes.map((type) {
                final isSelected = _selectedConstructionTypes.contains(type);
                return FilterChip(
                  label: Text(type),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedConstructionTypes.add(type);
                      } else {
                        _selectedConstructionTypes.remove(type);
                      }
                    });
                  },
                  backgroundColor: AppTheme.lightGray,
                  selectedColor: AppTheme.accentCopper,
                  side: isSelected 
                    ? BorderSide(color: AppTheme.primaryNavy, width: 2)
                    : null,
                  labelStyle: TextStyle(
                    color: isSelected ? AppTheme.white : AppTheme.textPrimary,
                  ),
                );
              }).toList(),
            )
          else
            Wrap(
              spacing: AppTheme.spacingSm,
              runSpacing: AppTheme.spacingSm,
              children: _selectedConstructionTypes.map((type) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingMd,
                    vertical: AppTheme.spacingSm,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.accentCopper.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  ),
                  child: Text(
                    type,
                    style: AppTheme.bodyMedium.copyWith(
                      color: AppTheme.accentCopper,
                    ),
                  ),
                );
              }).toList(),
            ),

          const SizedBox(height: AppTheme.spacingMd),

          // Hours per week
          if (_isEditing)
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.lightGray),
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: DropdownButtonFormField<String>(
                value: _selectedHoursPerWeek,
                decoration: const InputDecoration(
                  labelText: 'Preferred Hours per Week',
                  prefixIcon: Icon(Icons.schedule),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingMd,
                    vertical: AppTheme.spacingMd,
                  ),
                ),
                items: _hoursOptions.map((hours) {
                  return DropdownMenuItem(
                    value: hours,
                    child: Text(hours),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedHoursPerWeek = value!;
                  });
                },
              ),
            )
          else
            JJTextField(
              label: 'Preferred Hours per Week',
              controller: TextEditingController(text: _selectedHoursPerWeek),
              enabled: false,
              prefixIcon: Icons.schedule,
            ),

          const SizedBox(height: AppTheme.spacingMd),

          // Per diem preference
          if (_isEditing)
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.lightGray),
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: DropdownButtonFormField<String>(
                value: _selectedPerDiem,
                decoration: const InputDecoration(
                  labelText: 'Per Diem Preference',
                  prefixIcon: Icon(Icons.hotel),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingMd,
                    vertical: AppTheme.spacingMd,
                  ),
                ),
                items: _perDiemOptions.map((option) {
                  return DropdownMenuItem(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPerDiem = value!;
                  });
                },
              ),
            )
          else
            JJTextField(
              label: 'Per Diem Preference',
              controller: TextEditingController(text: _selectedPerDiem),
              enabled: false,
              prefixIcon: Icons.hotel,
            ),

          const SizedBox(height: AppTheme.spacingMd),

          JJTextField(
            label: 'Preferred Locals',
            controller: _preferredLocalsController,
            enabled: _isEditing,
            prefixIcon: Icons.location_on_outlined,
            maxLines: 2,
          ),

          const SizedBox(height: AppTheme.spacingMd),

          JJTextField(
            label: 'Career Goals',
            controller: _careerGoalsController,
            enabled: _isEditing,
            prefixIcon: Icons.flag_outlined,
            maxLines: 3,
          ),

          const SizedBox(height: AppTheme.spacingLg),

          // Job Search Goals - from onboarding
          Text(
            'Job Search Goals',
            style: AppTheme.headlineSmall.copyWith(
              color: AppTheme.primaryNavy,
            ),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          Text(
            'What are you looking for in your next opportunity?',
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppTheme.spacingMd),

          // Job search goals checkboxes
          if (_isEditing)
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingSm),
              decoration: BoxDecoration(
                color: AppTheme.offWhite,
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                border: Border.all(color: AppTheme.lightGray),
              ),
              child: Column(
                children: [
                  CheckboxListTile(
                    title: Text('Network with Others', style: AppTheme.bodyMedium),
                    subtitle: Text('Connect with other electricians', style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary)),
                    value: _networkWithOthers,
                    activeColor: AppTheme.accentCopper,
                    onChanged: (value) => setState(() => _networkWithOthers = value ?? false),
                    dense: true,
                  ),
                  CheckboxListTile(
                    title: Text('Career Advancement', style: AppTheme.bodyMedium),
                    subtitle: Text('Seek leadership roles', style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary)),
                    value: _careerAdvancements,
                    activeColor: AppTheme.accentCopper,
                    onChanged: (value) => setState(() => _careerAdvancements = value ?? false),
                    dense: true,
                  ),
                  CheckboxListTile(
                    title: Text('Better Benefits', style: AppTheme.bodyMedium),
                    subtitle: Text('Improved benefit packages', style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary)),
                    value: _betterBenefits,
                    activeColor: AppTheme.accentCopper,
                    onChanged: (value) => setState(() => _betterBenefits = value ?? false),
                    dense: true,
                  ),
                  CheckboxListTile(
                    title: Text('Higher Pay Rate', style: AppTheme.bodyMedium),
                    subtitle: Text('Increase compensation', style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary)),
                    value: _higherPayRate,
                    activeColor: AppTheme.accentCopper,
                    onChanged: (value) => setState(() => _higherPayRate = value ?? false),
                    dense: true,
                  ),
                  CheckboxListTile(
                    title: Text('Learn New Skills', style: AppTheme.bodyMedium),
                    subtitle: Text('Gain new experience', style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary)),
                    value: _learnNewSkill,
                    activeColor: AppTheme.accentCopper,
                    onChanged: (value) => setState(() => _learnNewSkill = value ?? false),
                    dense: true,
                  ),
                  CheckboxListTile(
                    title: Text('Travel to New Locations', style: AppTheme.bodyMedium),
                    subtitle: Text('Work in different areas', style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary)),
                    value: _travelToNewLocation,
                    activeColor: AppTheme.accentCopper,
                    onChanged: (value) => setState(() => _travelToNewLocation = value ?? false),
                    dense: true,
                  ),
                  CheckboxListTile(
                    title: Text('Find Long-term Work', style: AppTheme.bodyMedium),
                    subtitle: Text('Secure stable employment', style: AppTheme.bodySmall.copyWith(color: AppTheme.textSecondary)),
                    value: _findLongTermWork,
                    activeColor: AppTheme.accentCopper,
                    onChanged: (value) => setState(() => _findLongTermWork = value ?? false),
                    dense: true,
                  ),
                ],
              ),
            )
          else
            // Display selected goals when not editing
            Wrap(
              spacing: AppTheme.spacingSm,
              runSpacing: AppTheme.spacingSm,
              children: [
                if (_networkWithOthers) _buildGoalChip('Network with Others'),
                if (_careerAdvancements) _buildGoalChip('Career Advancement'),
                if (_betterBenefits) _buildGoalChip('Better Benefits'),
                if (_higherPayRate) _buildGoalChip('Higher Pay Rate'),
                if (_learnNewSkill) _buildGoalChip('Learn New Skills'),
                if (_travelToNewLocation) _buildGoalChip('Travel to New Locations'),
                if (_findLongTermWork) _buildGoalChip('Find Long-term Work'),
              ],
            ),

          const SizedBox(height: AppTheme.spacingLg),

          // Additional feedback fields from onboarding
          Text(
            'Additional Information',
            style: AppTheme.headlineSmall.copyWith(
              color: AppTheme.primaryNavy,
            ),
          ),
          const SizedBox(height: AppTheme.spacingMd),

          JJTextField(
            label: 'How did you hear about us?',
            controller: _howHeardAboutUsController,
            enabled: _isEditing,
            prefixIcon: Icons.info_outline,
            maxLines: 2,
          ),

          const SizedBox(height: AppTheme.spacingMd),

          JJTextField(
            label: 'What are you looking to accomplish?',
            controller: _lookingToAccomplishController,
            enabled: _isEditing,
            prefixIcon: Icons.track_changes_outlined,
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        AppTheme.spacingMd,
        AppTheme.spacingMd,
        AppTheme.spacingMd,
        AppTheme.spacingMd + MediaQuery.of(context).padding.bottom + (_isEditing && !_isKeyboardVisible() ? 80 : 0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notification Preferences',
            style: AppTheme.headlineSmall.copyWith(
              color: AppTheme.primaryNavy,
            ),
          ),
          const SizedBox(height: AppTheme.spacingMd),

          _buildSettingsTile(
            'Job Alerts',
            'Get notified about new job opportunities',
            Icons.work_outline,
            _jobAlerts,
            (value) => setState(() => _jobAlerts = value),
          ),

          _buildSettingsTile(
            'Storm Work Alerts',
            'Emergency storm restoration notifications',
            Icons.flash_on,
            _stormAlerts,
            (value) => setState(() => _stormAlerts = value),
          ),

          _buildSettingsTile(
            'Email Notifications',
            'Receive notifications via email',
            Icons.email_outlined,
            _emailNotifications,
            (value) => setState(() => _emailNotifications = value),
          ),

          _buildSettingsTile(
            'Push Notifications',
            'Receive push notifications on your device',
            Icons.notifications_outlined,
            _pushNotifications,
            (value) => setState(() => _pushNotifications = value),
          ),

          _buildSettingsTile(
            'Weekly Digest',
            'Summary of job opportunities each week',
            Icons.summarize_outlined,
            _weeklyDigest,
            (value) => setState(() => _weeklyDigest = value),
          ),

          const SizedBox(height: AppTheme.spacingLg),

          Text(
            'Account Actions',
            style: AppTheme.headlineSmall.copyWith(
              color: AppTheme.primaryNavy,
            ),
          ),
          const SizedBox(height: AppTheme.spacingMd),

          _buildActionTile(
            'Change Password',
            'Update your account password',
            Icons.lock_outline,
            () {
              JJSnackBar.showSuccess(
                context: context,
                message: 'Password change feature coming soon',
              );
            },
          ),

          _buildActionTile(
            'Download My Data',
            'Download a copy of your profile data',
            Icons.download_outlined,
            () {
              JJSnackBar.showSuccess(
                context: context,
                message: 'Data download feature coming soon',
              );
            },
          ),

          _buildActionTile(
            'Delete Account',
            'Permanently delete your account',
            Icons.delete_outline,
            () {
              _showDeleteAccountDialog();
            },
            isDestructive: true,
          ),

          const SizedBox(height: AppTheme.spacingLg),

          Text(
            'App Information',
            style: AppTheme.headlineSmall.copyWith(
              color: AppTheme.primaryNavy,
            ),
          ),
          const SizedBox(height: AppTheme.spacingMd),

          _buildInfoTile('Version', '1.0.0'),
          _buildInfoTile('Build', '2024.1'),
          _buildInfoTile('Last Updated', 'Today'),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    Function(bool) onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        boxShadow: [AppTheme.shadowSm],
      ),
      child: JJCircuitBreakerSwitchListTile(
        title: Text(
          title,
          style: AppTheme.bodyLarge.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: AppTheme.bodyMedium.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        secondary: Icon(icon, color: AppTheme.accentCopper),
        value: value,
        onChanged: onChanged,
        size: JJCircuitBreakerSize.small,
        showElectricalEffects: true,
      ),
    );
  }

  Widget _buildActionTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        boxShadow: [AppTheme.shadowSm],
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isDestructive ? AppTheme.errorRed : AppTheme.accentCopper,
        ),
        title: Text(
          title,
          style: AppTheme.bodyLarge.copyWith(
            color: isDestructive ? AppTheme.errorRed : AppTheme.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: AppTheme.bodyMedium.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppTheme.textLight,
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        boxShadow: [AppTheme.shadowSm],
      ),
      child: ListTile(
        title: Text(
          title,
          style: AppTheme.bodyLarge.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Text(
          value,
          style: AppTheme.bodyMedium.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildGoalChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMd,
        vertical: AppTheme.spacingSm,
      ),
      decoration: BoxDecoration(
        color: AppTheme.accentCopper.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(color: AppTheme.accentCopper.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: AppTheme.bodyMedium.copyWith(
          color: AppTheme.accentCopper,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          ),
          title: Row(
            children: [
              Icon(
                Icons.warning,
                color: AppTheme.errorRed,
                size: AppTheme.iconMd,
              ),
              const SizedBox(width: AppTheme.spacingSm),
              Text(
                'Delete Account',
                style: AppTheme.headlineSmall.copyWith(
                  color: AppTheme.errorRed,
                ),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to permanently delete your account? This action cannot be undone and all your data will be lost.',
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.textPrimary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                JJSnackBar.showError(
                  context: context,
                  message: 'Account deletion feature coming soon',
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.errorRed,
                foregroundColor: AppTheme.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}

class ArrowPainter extends CustomPainter {
  final Color color;
  
  ArrowPainter(this.color);
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    final path = Path();
    path.moveTo(size.width / 2, 0); // Top center (point of arrow)
    path.lineTo(0, size.height); // Bottom left
    path.lineTo(size.width, size.height); // Bottom right
    path.close();
    
    canvas.drawPath(path, paint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}