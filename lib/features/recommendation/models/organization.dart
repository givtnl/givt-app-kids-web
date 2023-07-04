import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:givt_app_kids_web/features/recommendation/models/tag.dart';

class Organization extends Equatable {
  const Organization({
    required this.guid,
    required this.name,
    required this.ein,
    required this.collectGroupId,
    required this.description,
    required this.namespace,
    required this.qrCodeURL,
    required this.promoPictureUrl,
    required this.organisationLogoURL,
    required this.tags,
  });

  final String guid;
  final String name;
  final String ein;
  final String collectGroupId;
  final String description;
  final String namespace;
  final String qrCodeURL;
  final String promoPictureUrl;
  final String organisationLogoURL;
  final List<Tag> tags;

  @override
  List<Object?> get props => [
        guid,
        name,
        ein,
        collectGroupId,
        description,
        namespace,
        qrCodeURL,
        promoPictureUrl,
        organisationLogoURL,
        tags,
      ];

  factory Organization.fromMap(Map<String, dynamic> map) {
    ;

    return Organization(
      guid: map['guid'] ?? '',
      name: map['name'] ?? '',
      ein: map['ein'] ?? '',
      collectGroupId: map['collectGroupId'] ?? '',
      description: map['description'] ?? '',
      namespace: map['namespace'] ?? '',
      qrCodeURL: map['qrCodeURL'] ?? '',
      promoPictureUrl: map['promoPictureUrl'] ?? '',
      organisationLogoURL: map['organisationLogoURL'] ?? '',
      tags: (json.decode(map['tags']) as List<dynamic>)
          .map((map) => Tag.fromMap(map))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'guid': guid,
      'name': name,
      'country': country,
      'telNr': telephoneNumber,
      'ein': ein,
      'description': description,
      'qrCodeURL': qrCodeURL,
      'organizationLogoURL': pictureURL,
    };
  }
}
