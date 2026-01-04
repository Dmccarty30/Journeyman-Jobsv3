import 'package:cloud_firestore/cloud_firestore.dart';
import 'crew_preferences.dart';

class Crew {
  final String id;
  final String name;
  final String description;
  final String? logoUrl;
  final String foremanId;
  final String privacy; // 'open', 'inviteOnly', 'private'
  final int memberCount;
  final int jobCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, dynamic>? location; // { 'city': String, 'state': String, 'zip': String }
  final List<String> tags;
  final DateTime lastActivityAt;
  final bool isActive;
  final CrewPreferences preferences;

  const Crew({
    required this.id,
    required this.name,
    required this.description,
    this.logoUrl,
    required this.foremanId,
    required this.privacy,
    this.memberCount = 0,
    this.jobCount = 0,
    required this.createdAt,
    required this.updatedAt,
    this.location,
    this.tags = const [],
    required this.lastActivityAt,
    this.isActive = true,
    required this.preferences,
  });

  factory Crew.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Crew(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      logoUrl: data['logoUrl'],
      foremanId: data['foremanId'] ?? '',
      privacy: data['privacy'] ?? 'open',
      memberCount: data['memberCount'] ?? 0,
      jobCount: data['jobCount'] ?? 0,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      location: data['location'] as Map<String, dynamic>?,
      tags: List<String>.from(data['tags'] ?? []),
      lastActivityAt: (data['lastActivityAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isActive: data['isActive'] ?? true,
      preferences: CrewPreferences.fromMap(data['preferences'] ?? {}),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'logoUrl': logoUrl,
      'foremanId': foremanId,
      'privacy': privacy,
      'memberCount': memberCount,
      'jobCount': jobCount,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'location': location,
      'tags': tags,
      'lastActivityAt': Timestamp.fromDate(lastActivityAt),
      'isActive': isActive,
      'preferences': preferences.toMap(),
    };
  }

  // toMap alias for consistency
  Map<String, dynamic> toMap() => toFirestore();

    // fromMap alias

    factory Crew.fromMap(Map<String, dynamic> map) {

      return Crew(

        id: map['id'] ?? '',

        name: map['name'] ?? '',

        description: map['description'] ?? '',

        logoUrl: map['logoUrl'],

        foremanId: map['foremanId'] ?? '',

        privacy: map['privacy'] ?? 'open',

        memberCount: map['memberCount'] ?? 0,

        jobCount: map['jobCount'] ?? 0,

        createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),

        updatedAt: (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),

        location: map['location'] as Map<String, dynamic>?,

        tags: List<String>.from(map['tags'] ?? []),

        lastActivityAt: (map['lastActivityAt'] as Timestamp?)?.toDate() ?? DateTime.now(),

        isActive: map['isActive'] ?? true,

        preferences: CrewPreferences.fromMap(map['preferences'] ?? {}),

      );

    }

  

    Crew copyWith({

      String? id,

      String? name,

      String? description,

      String? logoUrl,

      String? foremanId,

      String? privacy,

      int? memberCount,

      int? jobCount,

      DateTime? createdAt,

      DateTime? updatedAt,

      Map<String, dynamic>? location,

      List<String>? tags,

      DateTime? lastActivityAt,

      bool? isActive,

      CrewPreferences? preferences,

    }) {

      return Crew(

        id: id ?? this.id,

        name: name ?? this.name,

        description: description ?? this.description,

        logoUrl: logoUrl ?? this.logoUrl,

        foremanId: foremanId ?? this.foremanId,

        privacy: privacy ?? this.privacy,

        memberCount: memberCount ?? this.memberCount,

        jobCount: jobCount ?? this.jobCount,

        createdAt: createdAt ?? this.createdAt,

        updatedAt: updatedAt ?? this.updatedAt,

        location: location ?? this.location,

        tags: tags ?? this.tags,

        lastActivityAt: lastActivityAt ?? this.lastActivityAt,

        isActive: isActive ?? this.isActive,

        preferences: preferences ?? this.preferences,

      );

    }

  }

  