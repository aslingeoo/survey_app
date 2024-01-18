import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class user{
  String? uid;
  String? email;
  String? loginTime;
  String? lang;

  user({this.uid, this.email, this.loginTime, this.lang});

  user.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    loginTime = json['loginTime'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['email'] = email;
    data['loginTime'] = loginTime;
    data['lang'] = lang;
    return data;
  }
}