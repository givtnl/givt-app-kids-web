import 'package:equatable/equatable.dart';

class DecisionResponse extends Equatable {
  const DecisionResponse({
    required this.isError,
    required this.errorMessage,
    required this.detailResponse,
  });

  final bool isError;
  final String errorMessage;
  final DetailResponse detailResponse;
  @override
  List<Object?> get props => [
        isError,
        errorMessage,
        detailResponse,
      ];

  factory DecisionResponse.fromMap(Map<String, dynamic> map) {
    var holder = map['item'];
    return DecisionResponse(
      isError: map['isError'] ?? true,
      errorMessage: map['errorMessage'] ?? '',
      detailResponse: DetailResponse.fromMap(holder['transactionDetail']),
    );
  }
}

class DetailResponse extends Equatable {
  const DetailResponse({
    required this.userId,
    required this.amount,
    required this.donationDate,
    required this.status,
  });

  final String userId;
  final double amount;
  final String donationDate;
  final String status;

  @override
  List<Object?> get props => [userId, amount, donationDate, status];

  factory DetailResponse.fromMap(Map<String, dynamic> map) {
    return DetailResponse(
      userId: map['userId'],
      amount: map['amount'],
      donationDate: map['donationDate'],
      status: map['status'],
    );
  }
}
