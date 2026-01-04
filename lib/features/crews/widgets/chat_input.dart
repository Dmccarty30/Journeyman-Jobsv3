import 'package:flutter/material.dart';
import '../../../design_system/tailboard_theme.dart';

/// Chat input widget with send button
class ChatInput extends StatefulWidget {
  final ValueChanged<String> onSendMessage;
  final bool enabled;
  final String? placeholder;

  const ChatInput({
    super.key,
    required this.onSendMessage,
    this.enabled = true,
    this.placeholder,
  });

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSendMessage(text);
      _controller.clear();
      setState(() {
        _hasText = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(TailboardTheme.spacingM),
      decoration: BoxDecoration(
        color: TailboardTheme.backgroundCard,
        border: Border(
          top: BorderSide(
            color: TailboardTheme.divider,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                constraints: const BoxConstraints(maxHeight: 120),
                child: TextField(
                  controller: _controller,
                  enabled: widget.enabled,
                  maxLines: null,
                  textInputAction: TextInputAction.newline,
                  decoration: TailboardTheme.inputDecoration(
                    hintText: widget.placeholder ?? 'Type a message...',
                    prefixIcon:
                        const Icon(Icons.message, color: TailboardTheme.copper),
                  ),
                  style: TailboardTheme.bodyMedium,
                  onChanged: (text) {
                    setState(() {
                      _hasText = text.trim().isNotEmpty;
                    });
                  },
                  onSubmitted: (_) {
                    if (_hasText) _sendMessage();
                  },
                ),
              ),
            ),
            const SizedBox(width: TailboardTheme.spacingS),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: IconButton(
                onPressed: _hasText && widget.enabled ? _sendMessage : null,
                icon: Icon(
                  Icons.send,
                  color: _hasText && widget.enabled
                      ? TailboardTheme.copper
                      : TailboardTheme.textTertiary,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: _hasText && widget.enabled
                      ? TailboardTheme.copper.withValues(alpha: 0.1)
                      : TailboardTheme.backgroundDark,
                  padding: const EdgeInsets.all(TailboardTheme.spacingM),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
