import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'cache_service.dart';
import 'package:journeyman_jobs/features/jobs/profile/profile.dart';
import '../models/contractor_model.dart';
import 'package:journeyman_jobs/features/crews/crews.dart';
import 'package:journeyman_jobs/core/core.dart';
import 'package:journeyman_jobs/domain/exceptions/app_exception.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String? uid = FirebaseAuth.instance.currentUser?.uid;

  // User Operations
  Future<UserModel?> getUser(String userId) async {
    final cache = CacheService();
    final cachedUser = await cache.get<UserModel>('user_$userId');
    if (cachedUser != null) {
      return cachedUser;
    }

    final connectivity = ConnectivityService();
    if (!connectivity.isOnline) {
      throw OfflineError('No internet connection available');
    }
    try {
      final doc = await _db.collection('users').doc(userId).get();
      final user = doc.exists ? UserModel.fromFirestore(doc) : null;
      if (user != null) {
        await cache.set('user_$userId', user, ttl: CacheService.userDataTtl);
      }
      return user;
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'permission-denied':
          throw PermissionError(e.message ?? 'Permission denied');
        case 'network-request-failed':
          throw NetworkError(e.message ?? 'Network error');
        default:
          throw AppException('Failed to get user: ${e.message}', code: e.code);
      }
    } on PlatformException catch (e) {
      throw NetworkError('Platform error: ${e.message}');
    } catch (e) {
      throw AppException('Failed to get user: ${e.toString()}');
    }
  }

  Future<void> updateUser(UserModel user) async {
    if (!user.isValid()) {
      throw ValidationError('Invalid user data');
    }
    final connectivity = ConnectivityService();
    if (!connectivity.isOnline) {
      throw OfflineError('No internet connection available');
    }
    try {
      await _db
          .collection('users')
          .doc(user.uid)
          .set(user.toFirestore(), SetOptions(merge: true));
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'permission-denied':
          throw PermissionError(e.message ?? 'Permission denied');
        case 'network-request-failed':
          throw NetworkError(e.message ?? 'Network error');
        default:
          throw AppException('Failed to update user: ${e.message}',
              code: e.code);
      }
    } on PlatformException catch (e) {
      throw NetworkError('Platform error: ${e.message}');
    } catch (e) {
      throw AppException('Database error: ${e.toString()}');
    }
  }

  Future<void> setOnlineStatus(bool status) async {
    if (uid == null) return;
    final connectivity = ConnectivityService();
    if (!connectivity.isOnline) {
      throw OfflineError('No internet connection available');
    }
    try {
      await _db.collection('users').doc(uid!).update({
        'onlineStatus': status,
        'lastActive': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'permission-denied':
          throw PermissionError(e.message ?? 'Permission denied');
        case 'network-request-failed':
          throw NetworkError(e.message ?? 'Network error');
        default:
          throw AppException('Failed to update online status: ${e.message}',
              code: e.code);
      }
    } on PlatformException catch (e) {
      throw NetworkError('Platform error: ${e.message}');
    } catch (e) {
      throw AppException('Database error: ${e.toString()}');
    }
  }

  // Crew Operations (Legacy wrappers - should move to CrewService)
  Future<Crew?> getCrew(String crewId) async {
    try {
      final doc = await _db.collection('crews').doc(crewId).get();
      return doc.exists ? Crew.fromFirestore(doc) : null;
    } catch (e) {
      throw AppException('Failed to get crew: $e');
    }
  }

  Future<void> joinCrew(String crewId) async {
    if (uid == null) return;
    try {
      final now = DateTime.now();
      final member = CrewMember(
        uid: uid!,
        crewId: crewId,
        role: 'Member',
        joinedAt: now,
        status: 'active',
        userSnapshot: {}, // In production, fetch from user doc
      );

      await _db.runTransaction((transaction) async {
        transaction.set(
          _db.collection('crews').doc(crewId).collection('members').doc(uid),
          member.toFirestore(),
        );
        transaction.update(_db.collection('crews').doc(crewId), {
          'memberCount': FieldValue.increment(1),
        });
      });
    } catch (e) {
      throw AppException('Failed to join crew: $e');
    }
  }

  // ==================== Contractor Methods ====================

  /// Streams a list of contractors for storm work
  Stream<List<Contractor>> streamContractors({
    int limit = 50,
    DocumentSnapshot? startAfter,
  }) {
    try {
      Query query =
          _db.collection('contractors').orderBy('company').limit(limit);

      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }

      return query.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return Contractor.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();
      });
    } catch (e) {
      throw AppException('Failed to stream contractors: ${e.toString()}');
    }
  }
}
