import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Tag extends Equatable {
  const Tag({
    required this.key,
    required this.area,
    required this.color,
    required this.displayText,
    required this.pictureUrl,
    required this.type,
  });

  final String key;
  final String area;
  final Color color;
  final String displayText;
  final String pictureUrl;
  final TagType type;

  @override
  List<Object?> get props => [
        key,
        displayText,
        pictureUrl,
        type,
      ];

  const Tag.empty()
      : this(
            key: '',
            area: '',
            color: Colors.amber,
            displayText: 'Empty Tag',
            pictureUrl: '',
            type: TagType.INTERESTS);

  factory Tag.fromMap(Map<String, dynamic> map) {
    Color _getColor(String area) {
      switch (area) {
        case "ENVIRONMENT":
          return Color(0xFF00845A);
        case 'HEALTH':
          return Color(0xFF7AAA35);
        case 'EDUCATION':
          return Color(0xFF54A1EE);
        case 'BASIC':
          return Color(0xFFFAB63E);
        case 'DISASTER':
          return Color(0xFFF99370);
        default:
          {
            return Color(0xFF285C92);
          }
      }
    }

    return Tag(
      key: map['key'] ?? '',
      area: map['area'] ?? '',
      color: _getColor(map['area']),
      displayText: map['displayText'] ?? '',
      pictureUrl: map['pictureUrl'] ?? '',
      type: TagType.values.firstWhere(
        (element) => element.name == map['type'],
        orElse: () => TagType.INTERESTS,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'area': area,
      'displayText': displayText,
      'pictureUrl': pictureUrl,
      'type': type.name,
    };
  }
}

// ignore: constant_identifier_names
enum TagType { LOCATION, INTERESTS }
