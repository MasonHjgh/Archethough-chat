import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(this.id, {required this.username});

  final String id;
  final String username;

  @override
  List<Object> get props => [id];

  static const empty = User('-', username: "");

  Map<String, dynamic> toJson() {
    return {"id": id, "name": username};
  }

  static fromJson(Map<String, dynamic> map) {
    return User(map['id'] ?? "-", username: map['name'] ?? "");
  }
}
