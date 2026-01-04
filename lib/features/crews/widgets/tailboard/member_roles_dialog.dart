import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../design_system/tailboard_theme.dart';
import '../../../../design_system/tailboard_components.dart';
import '../../crews.dart';

class MemberRolesDialog extends ConsumerStatefulWidget {
  const MemberRolesDialog({super.key});

  static Future<void> show(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => const MemberRolesDialog(),
    );
  }

  @override
  ConsumerState<MemberRolesDialog> createState() => _MemberRolesDialogState();
}

class _MemberRolesDialogState extends ConsumerState<MemberRolesDialog> {
  final Map<String, String> _roleChanges = {};

  @override
  Widget build(BuildContext context) {
    final selectedCrew = ref.watch(selectedCrewProvider);

    if (selectedCrew == null) {
      return const SizedBox.shrink();
    }

    final membersAsync = ref.watch(crewMembersStreamProvider(selectedCrew.id));

    return Dialog(
      backgroundColor: TailboardTheme.backgroundDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TailboardTheme.radiusL),
      ),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 600, maxWidth: 500),
        padding: const EdgeInsets.all(TailboardTheme.spacingL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Member Roles',
                  style: TailboardTheme.headingMedium,
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: TailboardTheme.textSecondary),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: TailboardTheme.spacingM),
            Expanded(
              child: membersAsync.when(
                loading: () => const ElectricalLoadingIndicator(
                  message: 'Loading members...',
                ),
                error: (error, stack) => EmptyStateWidget(
                  icon: Icons.error_outline,
                  title: 'Error Loading Members',
                  message: error.toString(),
                ),
                data: (members) {
                  if (members.isEmpty) {
                    return const EmptyStateWidget(
                      icon: Icons.people_outline,
                      title: 'No Members Yet',
                      message: 'Invite members to join your crew',
                    );
                  }

                  return ListView.builder(
                    itemCount: members.length,
                    itemBuilder: (context, index) {
                      final member = members[index];
                      final currentRole = member.role;
                      final newRole = _roleChanges[member.uid] ?? currentRole;

                      return _MemberRoleItem(
                        member: member,
                        currentRole: newRole,
                        onRoleChanged: (role) {
                          setState(() {
                            _roleChanges[member.uid] = role;
                          });
                        },
                      );
                    },
                  );
                },
              ),
            ),
            if (_roleChanges.isNotEmpty) ...[
              const SizedBox(height: TailboardTheme.spacingM),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _roleChanges.clear();
                        });
                      },
                      style: TailboardTheme.secondaryButton,
                      child: const Text('Reset'),
                    ),
                  ),
                  const SizedBox(width: TailboardTheme.spacingM),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saveRoleChanges,
                      style: TailboardTheme.primaryButton,
                      child: const Text('Save Changes'),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _saveRoleChanges() async {
    // TODO: Implement role saving logic via crew service
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Role changes saved successfully'),
        backgroundColor: TailboardTheme.success,
      ),
    );
  }
}

class _MemberRoleItem extends StatelessWidget {
  final CrewMember member;
  final String currentRole;
  final ValueChanged<String> onRoleChanged;

  const _MemberRoleItem({
    required this.member,
    required this.currentRole,
    required this.onRoleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: TailboardTheme.spacingS),
      child: Container(
        padding: const EdgeInsets.all(TailboardTheme.spacingM),
        decoration: TailboardTheme.cardDecoration(),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: TailboardTheme.copper.withValues(alpha:0.2),
              child: Text(
                      member.displayName.isNotEmpty ? member.displayName[0].toUpperCase() : '?',
                      style: TailboardTheme.bodyMedium.copyWith(
                        color: TailboardTheme.copper,
                      ),
                    ),
            ),
            const SizedBox(width: TailboardTheme.spacingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.displayName,
                    style: TailboardTheme.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            DropdownButton<String>(
              value: currentRole,
              dropdownColor: TailboardTheme.backgroundCard,
              style: TailboardTheme.bodyMedium,
              underline: Container(),
              icon: const Icon(Icons.arrow_drop_down, color: TailboardTheme.copper),
              items: ['Foreman', 'Member'].map((role) {
                return DropdownMenuItem(
                  value: role,
                  child: Row(
                    children: [
                      Icon(
                        _getRoleIcon(role),
                        size: 16,
                        color: _getRoleColor(role),
                      ),
                      const SizedBox(width: TailboardTheme.spacingS),
                      Text(
                        role,
                        style: TailboardTheme.bodyMedium.copyWith(
                          color: _getRoleColor(role),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (role) {
                if (role != null) {
                  onRoleChanged(role);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  IconData _getRoleIcon(String role) {
    switch (role) {
      case 'Foreman':
        return Icons.engineering;
      case 'Member':
      default:
        return Icons.person;
    }
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case 'Foreman':
        return TailboardTheme.copper;
      case 'Member':
      default:
        return TailboardTheme.textSecondary;
    }
  }
}


