import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../../design_system/tailboard_theme.dart';

/// Message bubble widget for chat
class MessageBubble extends StatelessWidget {
  final String message;
  final String senderId;
  final String senderName;
  final DateTime timestamp;
  final bool isCurrentUser;
  final String? avatarUrl;

  const MessageBubble({
    super.key,
    required this.message,
    required this.senderId,
    required this.senderName,
    required this.timestamp,
    required this.isCurrentUser,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    final timeStr = DateFormat('h:mm a').format(timestamp);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: TailboardTheme.spacingM,
        vertical: TailboardTheme.spacingXS,
      ),
      child: Row(
        mainAxisAlignment:
            isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isCurrentUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: TailboardTheme.copper.withValues(alpha: 0.2),
              child: avatarUrl != null
                  ? ClipOval(
                      child: Image.network(
                        avatarUrl!,
                        width: 32,
                        height: 32,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Text(
                      senderName.isNotEmpty ? senderName[0].toUpperCase() : '?',
                      style: TailboardTheme.labelSmall.copyWith(
                        color: TailboardTheme.copper,
                      ),
                    ),
            ),
            const SizedBox(width: TailboardTheme.spacingS),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isCurrentUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                if (!isCurrentUser)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: TailboardTheme.spacingS,
                      bottom: 2,
                    ),
                    child: Text(
                      senderName,
                      style: TailboardTheme.labelSmall.copyWith(
                        color: TailboardTheme.copper,
                      ),
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: TailboardTheme.spacingM,
                    vertical: TailboardTheme.spacingS,
                  ),
                  decoration: BoxDecoration(
                    color: isCurrentUser
                        ? TailboardTheme.copper
                        : TailboardTheme.backgroundCard,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        isCurrentUser
                            ? TailboardTheme.radiusL
                            : TailboardTheme.radiusS,
                      ),
                      topRight: Radius.circular(
                        isCurrentUser
                            ? TailboardTheme.radiusS
                            : TailboardTheme.radiusL,
                      ),
                      bottomLeft: const Radius.circular(TailboardTheme.radiusL),
                      bottomRight:
                          const Radius.circular(TailboardTheme.radiusL),
                    ),
                    boxShadow: TailboardTheme.shadowSmall,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message,
                        style: TailboardTheme.bodyMedium.copyWith(
                          color: isCurrentUser
                              ? TailboardTheme.textPrimary
                              : TailboardTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        timeStr,
                        style: TailboardTheme.labelSmall.copyWith(
                          color: isCurrentUser
                              ? TailboardTheme.textPrimary
                                  .withValues(alpha: 0.7)
                              : TailboardTheme.textTertiary,
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
    ).animate().fadeIn(duration: 200.ms).slideX(
          begin: isCurrentUser ? 0.1 : -0.1,
          end: 0,
          duration: 200.ms,
        );
  }
}
