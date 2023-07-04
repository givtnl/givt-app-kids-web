import 'package:equatable/equatable.dart';

class Tag extends Equatable {
  const Tag({
    required this.key,
    required this.displayText,
    required this.pictureUrl,
    required this.type,
  });

  final String key;
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

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      key: map['key'] ?? '',
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
      'displayText': displayText,
      'pictureUrl': pictureUrl,
      'type': type.name,
    };
  }
}

// ignore: constant_identifier_names
enum TagType { LOCATION, INTERESTS }
