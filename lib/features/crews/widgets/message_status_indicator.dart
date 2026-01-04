import 'package:flutter/material.dart';
import 'package:journeyman_jobs/design_system/design_system.dart';

class MessageStatusIndicator extends StatelessWidget {
  final String status; // 'sent', 'delivered', 'read', 'failed'
  final int readCount;
  final bool isGroupChat;
  final int totalMembers;

  const MessageStatusIndicator({
    super.key,
    required this.status,
    this.readCount = 0,
    this.isGroupChat = false,
    this.totalMembers = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildStatusIcon(),
      ],
    );
  }

  Widget _buildStatusIcon() {
    switch (status) {
      case 'sending':
        return const Icon(
          Icons.access_time,
          size: 14,
          color: AppTheme.textLight,
        );
      case 'sent':
        return const Icon(
          Icons.done,
          size: 14,
          color: AppTheme.textLight,
        );
      case 'read':
        return const Icon(
          Icons.done_all,
          size: 14,
          color: AppTheme.accentCopper,
        );
      case 'failed':
        return const Icon(
          Icons.error_outline,
          size: 14,
          color: AppTheme.errorRed,
        );
      case 'delivered':
      default:
        return const Icon(
          Icons.done_all,
          size: 14,
          color: AppTheme.textLight,
        );
    }
  }
}

// Enhanced status indicator with tooltip and advanced features
class EnhancedMessageStatusIndicator extends StatelessWidget {
  final String status;
  final int readCount;
  final bool isGroupChat;
  final int totalMembers;
  final VoidCallback? onTap;

  const EnhancedMessageStatusIndicator({
    super.key,
    required this.status,
    this.readCount = 0,
    this.isGroupChat = false,
    this.totalMembers = 1,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MessageStatusIndicator(
      status: status,
      readCount: readCount,
      isGroupChat: isGroupChat,
      totalMembers: totalMembers,
    );
  }
}

// Status indicator for message lists (compact version)
class CompactMessageStatusIndicator extends StatelessWidget {
  final String status;
  final bool isUnread;

  const CompactMessageStatusIndicator({
    super.key,
    required this.status,
    this.isUnread = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: _getIndicatorColor(),
        shape: BoxShape.circle,
      ),
    );
  }

  Color _getIndicatorColor() {
    if (isUnread) return AppTheme.accentCopper;
    
    switch (status) {
      case 'failed':
        return AppTheme.errorRed;
      case 'sending':
        return AppTheme.infoBlue;
      default:
        return AppTheme.successGreen;
    }
  }
}

