import 'package:equatable/equatable.dart';

class Tag extends Equatable {
  const Tag({
    required this.key,
    required this.text,
    required this.pictureUrl,
    required this.type,
  });

  final String key;
  final String text;
  final String pictureUrl;
  final TagType type;

  @override
  List<Object?> get props => [
        key,
        text,
        pictureUrl,
        type,
      ];

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      key: map['key'] ?? '',
      text: map['text'] ?? '',
      pictureUrl: map['pictureUrl'] ?? '',
      type: TagType.values.firstWhere(
        (element) => element.name == map['type'],
        orElse: () => TagType.interest,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'text': text,
      'pictureUrl': pictureUrl,
      'type': type.name,
    };
  }
}

enum TagType { location, interest }
