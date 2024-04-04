import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(this.id, {required this.userfullname,required this.useremail,required this.userhandle,required this.accesstoken});

  final String id;
  final String userfullname;
  final String useremail;
  final String userhandle;
  final String accesstoken;
  

  @override
  List<Object> get props => [id];

  static const empty = User('', userfullname: "", useremail: "", userhandle: "" ,accesstoken: "");

  Map<String, dynamic> toJson() {
    return {"id": id, "userFullName": userfullname , "userEmail": useremail, "userHandle": userhandle, "access_token": accesstoken};
  }

  static fromJson(Map<String, dynamic> map) {
    return User(map['id'] ?? "-", userfullname: map['userFullName'] , useremail: map['userEmail'], userhandle: map['userHandle'], accesstoken: map['access_token'] ?? "");
  }
}
