import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:journeyman_jobs/design_system/design_system.dart';
import 'package:go_router/go_router.dart';
import '../widgets/crew_preferences_dialog.dart';
import '../../../features/navigation/navigation.dart';

import '../crews.dart';
import '../../auth/auth.dart';

class CreateCrewScreen extends ConsumerStatefulWidget {
  const CreateCrewScreen({super.key});

  @override
  CreateCrewScreenState createState() => CreateCrewScreenState();
}

class CreateCrewScreenState extends ConsumerState<CreateCrewScreen> {
  final _formKey = GlobalKey<FormState>();
  final _crewNameController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _selectedJobType = 'Journeyman Lineman';
  int _minHourlyRate = 25;
  bool _autoShareEnabled = false;

  @override
  @override
  void dispose() {
    _crewNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _createCrew() async {
    if (_formKey.currentState!.validate()) {
      try {
        final crewService = ref.read(crewServiceProvider);
        final currentUser = ref.read(currentUserProvider);

        if (currentUser == null) {
          throw Exception('User not authenticated');
        }

        // Create initial preferences from the form
        final initialPreferences = CrewPreferences(
          jobTypes: [_selectedJobType],
          minHourlyRate: _minHourlyRate.toDouble(),
          autoShareEnabled: _autoShareEnabled,
        );

        // Actually CREATE the crew in Firestore and get the generated ID
        final crewId = await crewService.createCrew(
          name: _crewNameController.text,
          foremanId: currentUser.uid,
          preferences: initialPreferences,
        );

        if (mounted) {
          // Show CrewPreferencesDialog to refine preferences (optional)
          final updatedPreferences = await showDialog<CrewPreferences>(
            context: context,
            barrierDismissible: true,
            builder: (context) => CrewPreferencesDialog(
              initialPreferences: initialPreferences,
              crewId: crewId,
              crewService: crewService,
              isNewCrew:
                  false, // Crew is already created, we're just updating preferences
            ),
          );

          if (updatedPreferences != null && mounted) {
            // Update crew with refined preferences
            await crewService.updateCrew(
              crewId: crewId,
              preferences: updatedPreferences,
            );
          }

          if (mounted) {
            // Navigate to Tailboard screen
            context.go('${AppRouter.crews}/$crewId');
          }
        }
      } catch (e) {
        if (mounted) {
          JJElectricalToast.showError(
              context: context, message: 'Failed to create crew: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Crew'),
        elevation: 0,
        backgroundColor: AppTheme.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _crewNameController,
                  decoration: const InputDecoration(
                    labelText: 'Crew Name',
                    hintText: 'Enter crew name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Crew name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _selectedJobType,
                  items: const [
                    DropdownMenuItem(
                        value: 'Journeyman Lineman',
                        child: const Text('Journeyman Lineman')),
                    DropdownMenuItem(
                        value: 'Inside Wireman',
                        child: const Text('Inside Wireman')),
                    DropdownMenuItem(
                        value: 'Journeyman Electrician',
                        child: const Text('Journeyman Electrician')),
                    DropdownMenuItem(
                        value: 'Operator', child: const Text('Operator')),
                    DropdownMenuItem(
                        value: 'URD Technician',
                        child: const Text('URD Technician')),
                    DropdownMenuItem(
                        value: 'Transmission Technician',
                        child: const Text('Transmission Technician')),
                    DropdownMenuItem(
                        value: 'Cable Splicer',
                        child: const Text('Cable Splicer')),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedJobType = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Brief crew description',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description is required';
                    }
                    return null;
                  },
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Minimum Hourly Rate: \$$_minHourlyRate'),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => setState(() =>
                              _minHourlyRate = max(15, _minHourlyRate - 5)),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => setState(() =>
                              _minHourlyRate = min(100, _minHourlyRate + 5)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SwitchListTile(
                  title: const Text('Auto-share matching jobs'),
                  value: _autoShareEnabled,
                  onChanged: (value) {
                    setState(() {
                      _autoShareEnabled = value;
                    });
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: ref.watch(currentUserProvider) != null
                      ? _createCrew
                      : null,
                  icon: const Icon(Icons.check),
                  label: const Text('Create Crew'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ref.watch(currentUserProvider) != null
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
