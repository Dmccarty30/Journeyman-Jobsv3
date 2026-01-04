import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import '../crews.dart';
import 'package:journeyman_jobs/design_system/design_system.dart';
// For circuit background

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isCurrentUser;
  final bool showAvatar;
  final String senderName;
  final int? totalMembers; // For group chat member count
  final VoidCallback? onStatusTap;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    required this.senderName,
    this.showAvatar = true,
    this.totalMembers,
    this.onStatusTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isImage = message.type == 'image';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMd, vertical: AppTheme.spacingXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isCurrentUser && showAvatar) ...[
            CircleAvatar(
              radius: AppTheme.radiusLg,
              backgroundColor: AppTheme.accentCopper.withValues(alpha:0.2),
              child: Text(
                _getInitials(senderName),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.accentCopper,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: AppTheme.spacingSm),
          ],
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Column(
              crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (!isCurrentUser && showAvatar)
                  Padding(
                    padding: const EdgeInsets.only(left: AppTheme.spacingSm, bottom: AppTheme.spacingXs),
                    child: Text(
                      senderName,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textLight,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.all(AppTheme.spacingMd),
                  decoration: BoxDecoration(
                    color: isCurrentUser ? AppTheme.primaryNavy : AppTheme.electricalSurface,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                    border: Border.all(color: AppTheme.accentCopper, width: AppTheme.borderWidthCopperThin),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.content,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isCurrentUser ? AppTheme.white : AppTheme.textOnDark,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacingXs),
                      Text(
                        _formatTime(message.sentAt),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.textLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isCurrentUser && showAvatar) ...[
            const SizedBox(width: AppTheme.spacingSm),
            const CircleAvatar(
              radius: AppTheme.radiusLg,
              backgroundColor: AppTheme.accentCopper,
              child: Icon(
                Icons.person,
                size: 16,
                color: AppTheme.white,
              ),
            ),
          ],
        ],
      ),
    );
  }

    String _getInitials(String name) {

      if (name.isEmpty) return '?';

      final parts = name.split(' ');

      if (parts.length >= 2) {

        return '${parts[0][0]}${parts[1][0]}'.toUpperCase();

      }

      return name.substring(0, 1).toUpperCase();

    }

  

    String _formatTime(DateTime timestamp) {

      return DateFormat('h:mm a').format(timestamp);

    }

  }

  


