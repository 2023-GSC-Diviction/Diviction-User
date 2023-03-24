import 'package:diviction_user/model/counselor.dart';
import 'package:diviction_user/model/user.dart';

class Match {
  final int matchId;
  final Counselor counselor;
  final User user;

  Match({required this.matchId, required this.counselor, required this.user});

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
        matchId: json['matchId'],
        counselor: Counselor.fromJson(json['counselor']),
        user: User.fromJson(json['user']));
  }
}
