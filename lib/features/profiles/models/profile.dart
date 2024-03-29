import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:givt_app_kids_web/features/profiles/models/wallet.dart';

class Profile extends Equatable {
  const Profile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.nickname,
    required this.comment,
    required this.wallet,
    required this.pictureURL,
  });

  const Profile.empty()
      : this(
            id: '',
            firstName: '',
            lastName: '',
            nickname: '',
            comment: '',
            wallet: const Wallet.empty(),
            pictureURL: '');

  final String id;
  final String firstName;
  final String lastName;
  final String nickname;
  final String comment;
  final Wallet wallet;
  final String pictureURL;

  //temporary workaround solution
  Color get backgroundColorByImage {
    if (pictureURL.contains('monster1')) {
      return const Color(0xFFA7CB42);
    } else if (pictureURL.contains('monster2')) {
      return const Color(0xFFAD81E1);
    } else if (pictureURL.contains('monster3')) {
      return const Color(0xFF69A9D3);
    } else if (pictureURL.contains('monster4')) {
      return const Color(0xFFFEAD1D);
    } else {
      return Colors.transparent;
    }
  }

  @override
  List<Object?> get props =>
      [id, firstName, lastName, nickname, comment, wallet, pictureURL];

  factory Profile.fromMap(Map<String, dynamic> map) {
    final pictureMap = map['picture'];
    return Profile(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'] ?? '',
      nickname: map['nickname'] ?? '',
      comment: map['comment'] ?? '',
      wallet: Wallet.fromMap(map['wallet']),
      pictureURL: pictureMap['pictureURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'nickname': nickname,
      'comment': comment,
      'wallet': wallet.toJson(),
      'picture': {
        'pictureURL': pictureURL,
      }
    };
  }
}
