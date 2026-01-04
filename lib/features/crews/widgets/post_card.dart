// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post.dart';
import '../../../design_system/app_theme.dart';
import 'reaction_animation.dart';
import 'like_animation.dart';
import 'comment_animation.dart';
import 'crew_member_avatar.dart';
import 'comment_input.dart';
import 'comment_thread.dart';

class PostCard extends StatefulWidget {
  final Post post;
  final String currentUserId;
  final Function(String, Post)? onLike;
  final Function(String, Post)? onComment;
  final Function(String, Post)? onShare;
  final Function(String, Post)? onDelete;
  final Function(String, Post)? onEdit;
  final Function(String, String, Post)? onReaction;
  final Function(String, String)? onAddComment;
  final Function(String, String)? onLikeComment;
  final Function(String, String)? onUnlikeComment;
  final Function(String, String)? onEditComment;
  final Function(String, String)? onDeleteComment;
  final Function(String, String)? onReplyToComment;
  final String commentUserId;
  final String? currentUserName;
  final List<PostComment>? comments;
  final bool showCommentInput;

  const PostCard({
    super.key,
    required this.post,
    required this.currentUserId,
    this.onLike,
    this.onComment,
    this.onShare,
    this.onDelete,
    this.onEdit,
    this.onReaction,
    this.onAddComment,
    this.onLikeComment,
    this.onUnlikeComment,
    this.onEditComment,
    this.onDeleteComment,
    this.onReplyToComment,
    required this.commentUserId,
    this.currentUserName,
    this.comments,
    this.showCommentInput = true,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _isBookmarked = false;
  bool _showComments = false;
  bool _showReactionPicker = false;
  bool _isAddingComment = false;

  void _showReactionAnimation(String emoji) {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx + renderBox.size.width / 2 - 18,
        top: position.dy + renderBox.size.height / 2 - 18,
        child: Material(
          color: Colors.transparent,
          child: EnhancedReactionAnimation(
            emoji: emoji,
            isSelected: true,
            onTap: () {},
            size: 36.0,
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
  }

  void _toggleLike() {
    if (widget.onLike != null) {
      widget.onLike!(widget.currentUserId, widget.post);
    }
  }

  void _toggleReactionPicker() {
    setState(() {
      _showReactionPicker = !_showReactionPicker;
    });
  }

  void _handleReactionSelected(String emoji) {
    setState(() {
      _showReactionPicker = false;
    });

    // Trigger animation
    _showReactionAnimation(emoji);

    // Notify parent
    if (widget.onReaction != null) {
      widget.onReaction!(widget.currentUserId, emoji, widget.post);
    }
  }

  void _toggleComments() {
    setState(() {
      _showComments = !_showComments;
      if (_showComments && widget.onComment != null) {
        widget.onComment!(widget.post.id, widget.post);
      }
    });
  }

  void _sharePost() {
    if (widget.onShare != null) {
      widget.onShare!(widget.currentUserId, widget.post);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Post shared!'),
        backgroundColor: AppTheme.electricalSuccess,
      ),
    );
  }

  void _deletePost() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Post'),
        content: const Text('Are you sure you want to delete this post?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (widget.onDelete != null) {
                widget.onDelete!(widget.currentUserId, widget.post);
              }
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: AppTheme.errorRed),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _editPost() {
    if (widget.onEdit != null) {
      widget.onEdit!(widget.currentUserId, widget.post);
    }
  }

  String _formatTimestamp(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  Widget _buildPostHeader() {
    final displayName = widget.post.authorSnapshot['displayName'] ?? 'Unknown User';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          CrewMemberAvatar(
            memberName: displayName,
            size: 40,
            showStatus: false,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  style: AppTheme.titleMedium.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _formatTimestamp(widget.post.createdAt),
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.textLight,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) async {
              switch (value) {
                case 'edit':
                  _editPost();
                  break;
                case 'delete':
                  _deletePost();
                  break;
                case 'report':
                  // TODO: Implement report functionality
                  break;
              }
            },
            itemBuilder: (context) => [
              if (widget.post.authorId == widget.currentUserId)
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 16, color: AppTheme.accentCopper),
                      SizedBox(width: 8),
                      Text('Edit'),
                    ],
                  ),
                ),
              if (widget.post.authorId == widget.currentUserId)
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, size: 16, color: AppTheme.errorRed),
                      SizedBox(width: 8),
                      Text('Delete'),
                    ],
                  ),
                ),
              const PopupMenuItem(
                value: 'report',
                child: Row(
                  children: [
                    Icon(Icons.report, size: 16, color: AppTheme.warningYellow),
                    SizedBox(width: 8),
                    Text('Report'),
                  ],
                ),
              ),
            ],
            icon: const Icon(
              Icons.more_vert,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.post.content.isNotEmpty)
            Text(
              widget.post.content,
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textPrimary,
              ),
            ),
          if (widget.post.mediaUrls.isNotEmpty) ...[
            const SizedBox(height: 16),
            SizedBox(
              height: 200, 
              child: _buildMediaGrid(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMediaGrid() {
    if (widget.post.mediaUrls.length == 1) {
      return Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          color: AppTheme.electricalSurface,
          border: Border.all(
            color: AppTheme.borderCopperLight,
            width: AppTheme.borderWidthThin,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          child: Image.network(
            widget.post.mediaUrls.first,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: AppTheme.lightGray,
                child: const Icon(
                  Icons.broken_image,
                  size: 48,
                  color: AppTheme.mediumGray,
                ),
              );
            },
          ),
        ),
      );
    } else {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        itemCount: widget.post.mediaUrls.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              color: AppTheme.electricalSurface,
              border: Border.all(
                color: AppTheme.borderCopperLight,
                width: AppTheme.borderWidthThin,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              child: Image.network(
                widget.post.mediaUrls[index],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppTheme.lightGray,
                    child: const Icon(
                      Icons.broken_image,
                      size: 32,
                      color: AppTheme.mediumGray,
                    ),
                  );
                },
              ),
            ),
          );
        },
      );
    }
  }

  Widget _buildPostActions() {
    final likeCount = widget.post.stats['likeCount'] ?? 0;
    final commentCount = widget.post.stats['commentCount'] ?? 0;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          LikeAnimation(
            isLiked: false, // In production, check if user reacted with 'like'
            onLike: _toggleLike,
            size: 24,
            likedColor: AppTheme.errorRed,
            unlikedColor: AppTheme.textSecondary,
          ),
          Text(
            '$likeCount',
            style: AppTheme.bodySmall.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(width: 24),
          IconButton(
            onPressed: _toggleComments,
            icon: const Icon(
              Icons.comment,
              color: AppTheme.textSecondary,
              size: 24,
            ),
          ),
          Text(
            '$commentCount',
            style: AppTheme.bodySmall.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(width: 24),
          IconButton(
            onPressed: _sharePost,
            icon: const Icon(
              Icons.share,
              color: AppTheme.textSecondary,
              size: 24,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              setState(() {
                _isBookmarked = !_isBookmarked;
              });
            },
            icon: Icon(
              _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: _isBookmarked
                  ? AppTheme.accentCopper
                  : AppTheme.textSecondary,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentsSection() {
    if (!_showComments) return const SizedBox.shrink();

    return CommentAnimation(
      isVisible: _showComments,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            if (widget.showCommentInput)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: CommentInput(
                  postId: widget.post.id,
                  currentUserId: widget.commentUserId,
                  currentUserName: widget.currentUserName,
                  onCommentAdded: (comment) {
                    setState(() {
                      _isAddingComment = true;
                    });
                    widget.onAddComment?.call(widget.post.id, comment);
                    // Simulate delay for better UX
                    Future.delayed(const Duration(milliseconds: 500), () {
                      if (mounted) {
                        setState(() {
                          _isAddingComment = false;
                        });
                      }
                    });
                  },
                ),
              ),
            if (widget.comments != null && widget.comments!.isNotEmpty)
              CommentThread(
                comments: widget.comments!,
                postId: widget.post.id,
                currentUserId: widget.commentUserId,
                onLikeComment: (commentId, postId) {
                  widget.onLikeComment?.call(commentId, postId);
                },
                onUnlikeComment: (commentId, postId) {
                  widget.onUnlikeComment?.call(commentId, postId);
                },
                onEditComment: (commentId, postId) {
                  widget.onEditComment?.call(commentId, postId);
                },
                onDeleteComment: (commentId, postId) {
                  widget.onDeleteComment?.call(commentId, postId);
                },
                onReplyToComment: (commentId) {
                  widget.onReplyToComment?.call(widget.post.id, commentId);
                },
              )
            else if (_isAddingComment)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'No comments yet. Be the first to comment!',
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPostHeader(),
          _buildPostContent(),
          _buildPostActions(),
          _buildCommentsSection(),
        ],
      ),
    );
  }
}

