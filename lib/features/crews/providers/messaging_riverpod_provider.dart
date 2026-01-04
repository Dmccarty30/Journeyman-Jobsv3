import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../providers/riverpod/auth_riverpod_provider.dart';
import '../models/message.dart';
import '../services/message_service.dart';
import 'crews_riverpod_provider.dart';

part 'messaging_riverpod_provider.g.dart';

/// MessageService provider
@riverpod
MessageService messageService(Ref ref) => MessageService();

/// Stream of crew messages for a specific channel
@riverpod
Stream<List<Message>> crewMessagesStream(Ref ref, String crewId, String channelId) {
  final currentUser = ref.watch(currentUserProvider);
  
  if (currentUser == null) {
    return Stream.value([]);
  }
  
  final messageService = ref.watch(messageServiceProvider);
  return messageService.getCrewMessagesStream(crewId, channelId);
}

/// Crew messages for a specific channel
@riverpod
List<Message> crewMessages(Ref ref, String crewId, String channelId) {
  final messagesAsync = ref.watch(crewMessagesStreamProvider(crewId, channelId));
  
  return messagesAsync.when(
    data: (messages) => messages,
    loading: () => [],
    error: (_, __) => [],
  );
}

/// Provider to get chat channels for a crew
@riverpod
Stream<List<ChatChannel>> crewChannelsStream(Ref ref, String crewId) {
  final messageService = ref.watch(messageServiceProvider);
  return messageService.getCrewChannelsStream(crewId);
}

/// Crew channels
@riverpod
List<ChatChannel> crewChannels(Ref ref, String crewId) {
  final channelsAsync = ref.watch(crewChannelsStreamProvider(crewId));
  
  return channelsAsync.when(
    data: (channels) => channels,
    loading: () => [],
    error: (_, __) => [],
  );
}

/// Provider to get recent messages (last 24 hours) across channels
@riverpod
List<Message> recentMessages(Ref ref, String crewId, String channelId) {
  final messages = ref.watch(crewMessagesProvider(crewId, channelId));
  final twentyFourHoursAgo = DateTime.now().subtract(const Duration(hours: 24));
  
  return messages.where((message) {
    return message.sentAt.isAfter(twentyFourHoursAgo);
  }).toList();
}

/// Provider to get message count for a crew channel
@riverpod
int messageCount(Ref ref, String crewId, String channelId) {
  final messages = ref.watch(crewMessagesProvider(crewId, channelId));
  return messages.length;
}
