import 'package:equatable/equatable.dart';

class Organization extends Equatable {
  const Organization({
    required this.guid,
    required this.name,
    required this.country,
    required this.telephoneNumber,
    required this.ein,
    required this.description,
    required this.qrCodeURL,
    required this.pictureURL,
  });

  final String guid;
  final String name;
  final String country;
  final String telephoneNumber;
  final String ein;
  final String description;
  final String qrCodeURL;
  final String pictureURL;

  @override
  List<Object?> get props => [
        guid,
        name,
        country,
        telephoneNumber,
        ein,
        description,
        qrCodeURL,
        pictureURL,
      ];

  factory Organization.fromMap(Map<String, dynamic> map) {
    return Organization(
      guid: map['guid'] ?? '',
      name: map['name'] ?? '',
      country: map['country'] ?? '',
      telephoneNumber: map['telNr'] ?? '',
      ein: map['ein'] ?? '',
      description: map['description'] ?? '',
      qrCodeURL: map['qrCodeURL'],
      pictureURL: map['organizationLogoURL'],
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
