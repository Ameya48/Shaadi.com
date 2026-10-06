// ============================================================
// interest_model.dart - Interest Request & Invitation Model
// ============================================================

import 'profile_model.dart';

class InterestModel {
  final ProfileModel profile;
  String status; // 'Pending', 'Accepted', 'Declined', 'Shortlisted'
  final String date;
  final String? message; // suitor personal note
  final bool isHighKundaliMatch;

  InterestModel({
    required this.profile,
    this.status = 'Pending',
    required this.date,
    this.message,
    this.isHighKundaliMatch = true,
  });
}
