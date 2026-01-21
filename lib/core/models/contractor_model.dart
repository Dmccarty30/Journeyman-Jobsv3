import 'package:cloud_firestore/cloud_firestore.dart';

/// Model representing a storm work contractor
class Contractor {
  final String id;
  final String company;
  final String howToSignup;
  final String? phoneNumber;
  final String? email;
  final String? website;
  final String? address;
  final String? city;
  final String? state;
  final DateTime createdAt;
  final String? logoUrl;

  Contractor({
    required this.id,
    required this.company,
    required this.howToSignup,
    this.phoneNumber,
    this.email,
    this.website,
    this.address,
    this.city,
    this.state,
    required this.createdAt,
    this.logoUrl,
  });

  /// Creates a Contractor from JSON data
  factory Contractor.fromJson(Map<String, dynamic> json) {
    return Contractor(
      id: json['id'] ?? '',
      company: json['COMPANY'] ?? json['company'] ?? '',
      howToSignup: json['HOW TO SIGNUP'] ?? json['howToSignup'] ?? '',
      phoneNumber: json['PHONE NUMBER'] ?? json['phoneNumber'],
      email: json['EMAIL'] ?? json['email'],
      website: json['WEBSITE'] ?? json['website'],
      address: json['ADDRESS'] ?? json['address'],
      city: json['CITY'] ?? json['city'],
      state: json['STATE'] ?? json['state'],
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] is Timestamp
              ? (json['createdAt'] as Timestamp).toDate()
              : DateTime.parse(json['createdAt']))
          : DateTime.now(),
      logoUrl: json['LOGO_URL'] ?? json['logoUrl'],
    );
  }

  /// Converts Contractor to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company': company,
      'howToSignup': howToSignup,
      'phoneNumber': phoneNumber,
      'email': email,
      'website': website,
      'address': address,
      'city': city,
      'state': state,
      'createdAt': createdAt.toIso8601String(),
      'logoUrl': logoUrl,
    };
  }

  /// Converts Contractor to Firestore format
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'company': company,
      'howToSignup': howToSignup,
      'phoneNumber': phoneNumber,
      'email': email,
      'website': website,
      'address': address,
      'city': city,
      'state': state,
      'createdAt': Timestamp.fromDate(createdAt),
      'logoUrl': logoUrl,
    };
  }

  /// Creates a copy of this Contractor with updated fields
  Contractor copyWith({
    String? id,
    String? company,
    String? howToSignup,
    String? phoneNumber,
    String? email,
    String? website,
    String? address,
    String? city,
    String? state,
    DateTime? createdAt,
    String? logoUrl,
  }) {
    return Contractor(
      id: id ?? this.id,
      company: company ?? this.company,
      howToSignup: howToSignup ?? this.howToSignup,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      website: website ?? this.website,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      createdAt: createdAt ?? this.createdAt,
      logoUrl: logoUrl ?? this.logoUrl,
    );
  }

  /// Gets the expected local asset path for the contractor's logo
  String? get localAssetPath {
    if (company.isEmpty) return null;
    final fileName = company
        .trim()
        .toLowerCase()
        .replaceAll(' ', '_')
        .replaceAll('.', '')
        .replaceAll(',', '')
        .replaceAll("'", '')
        .replaceAll('"', '')
        .replaceAll('-', '_')
        .replaceAll('__', '_');

    // Most contractor logos are saved as jpg inassets/images/
    return 'assets/images/$fileName.jpg';
  }

  @override
  String toString() {
    return 'Contractor(id: $id, company: $company, howToSignup: $howToSignup, address: $address, logoUrl: $logoUrl, localAssetPath: $localAssetPath)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Contractor &&
        other.id == id &&
        other.company == company &&
        other.howToSignup == howToSignup &&
        other.phoneNumber == phoneNumber &&
        other.email == email &&
        other.website == website &&
        other.address == address &&
        other.city == city &&
        other.state == state &&
        other.logoUrl == logoUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        company.hashCode ^
        howToSignup.hashCode ^
        (phoneNumber?.hashCode ?? 0) ^
        (email?.hashCode ?? 0) ^
        (website?.hashCode ?? 0) ^
        (address?.hashCode ?? 0) ^
        (city?.hashCode ?? 0) ^
        (state?.hashCode ?? 0) ^
        (logoUrl?.hashCode ?? 0);
  }
}
