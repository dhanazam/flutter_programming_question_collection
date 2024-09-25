import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? uid;
  final String? email;
  final String? password;
  final String? displayName;
  final int? age;

  static const empty = User(
    uid: '',
  );

  const User({
    this.uid,
    this.email,
    this.password,
    this.displayName,
    this.age,
  });

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [
        uid,
        email,
        password,
        displayName,
        age,
      ];
}
