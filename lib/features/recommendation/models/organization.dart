import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:givt_app_kids_web/features/recommendation/models/tag.dart';

class Organization extends Equatable {
  const Organization({
    required this.guid,
    required this.collectGroupId,
    required this.name,
    required this.namespace,
    required this.qrCodeURL,
    required this.organisationLogoURL,
    required this.promoPictureUrl,
    required this.shortDescription,
    required this.longDescription,
    required this.tags,
  });

  final String guid;
  final String collectGroupId;
  final String name;
  final String namespace;
  final String qrCodeURL;
  final String organisationLogoURL;
  final String promoPictureUrl;
  final String shortDescription;
  final String longDescription;
  final List<Tag> tags;

  @override
  List<Object?> get props => [
        guid,
        collectGroupId,
        name,
        namespace,
        qrCodeURL,
        organisationLogoURL,
        promoPictureUrl,
        shortDescription,
        longDescription,
        tags,
      ];

  factory Organization.fromMap(Map<String, dynamic> map) {
    return Organization(
      guid: map['guid'],
      collectGroupId: map['collectGroupId'],
      name: map['name'],
      namespace: map['namespace'] ?? '',
      qrCodeURL: map['qrCodeURL'],
      organisationLogoURL: map['organisationLogoURL'],
      promoPictureUrl: map['promoPictureUrl'],
      shortDescription: map['shortDescription'],
      longDescription: map['organisationLogoURL'],
      tags: (json.decode(map['tags']) as List<dynamic>)
          .map((map) => Tag.fromMap(map))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'guid': guid,
      'collectGroupId': collectGroupId,
      'name': name,
      'namespace': namespace,
      'qrCodeURL': qrCodeURL,
      'organisationLogoURL': organisationLogoURL,
      'promoPictureUrl': promoPictureUrl,
      'shortDescription': shortDescription,
      'longDescription': longDescription,
      'tags': jsonEncode(tags),
    };
  }
}
