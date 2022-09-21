// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:rpgaming/src/enums/gender_person.dart';

class UserInfo {
  String id;
  String account_id;
  final DateTime created_at;
  String? name;
  String? last_name;
  String? nickname;
  DateTime? birthday;
  GenderPerson? gender;
  String? gender_value;
  String? avatar_url;
  String? name_provider;
  DateTime updated_at;

  UserInfo({
    required this.id,
    required this.account_id,
    required this.created_at,
    required this.updated_at,
    this.name,
    this.last_name,
    this.nickname,
    this.birthday,
    this.gender,
    this.gender_value,
    this.avatar_url,
    this.name_provider,
  });

  UserInfo copyWith({
    String? id,
    DateTime? created_at,
    DateTime? updated_at,
    String? name,
    String? last_name,
    String? nickname,
    DateTime? birthday,
    GenderPerson? gender,
    String? gender_value,
    String? avatar_url,
    String? nameProvider,
    String? provider_token,
  }) {
    return UserInfo(
      id: id ?? this.id,
      account_id: account_id,
      created_at: created_at ?? this.created_at,
      name: name ?? this.name,
      last_name: last_name ?? this.last_name,
      nickname: nickname ?? this.nickname,
      birthday: birthday ?? this.birthday,
      gender: gender ?? this.gender,
      gender_value: gender_value ?? this.gender_value,
      avatar_url: avatar_url ?? this.avatar_url,
      name_provider: name_provider ?? this.name_provider,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'account_id': account_id,
      'created_at': created_at.toIso8601String(),
      'name': name,
      'last_name': last_name,
      'nickname': nickname,
      'birthday': birthday?.toIso8601String(),
      'gender': toMapEnumGenderPerson(gender),
      'gender_value': gender_value,
      'avatar_url': avatar_url,
      'name_provider': name_provider,
      'updated_at': updated_at.toIso8601String()
    };
  }

  factory UserInfo.fromMap(map) {
    return UserInfo(
      id: map['id'] as String,
      account_id: map['account_id'] as String,
      created_at: DateTime.parse(map['created_at']),
      updated_at: DateTime.parse(map['updated_at']),
      name: map['name'] != null ? map['name'] as String : null,
      last_name: map['last_name'] != null ? map['last_name'] as String : null,
      nickname: map['nickname'] != null ? map['nickname'] as String : null,
      birthday: map['birthday'] != null ? DateTime.parse(map['birthday']) : null,
      gender: map['gender'] != null ? fromMapEnumGenderPerson(map['gender']) : null,
      gender_value: map['gender_value'] != null ? map['gender_value'] as String : null,
      avatar_url: map['avatar_url'] != null ? map['avatar_url'] as String : null,
      name_provider: map['name_provider'] != null ? map['name_provider'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfo.fromJson(String source) => UserInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserInfo(id: $id, id: $account_id, created_at: $created_at, name: $name, last_name: $last_name, nickname: $nickname, birthday: $birthday, birthday: $updated_at, gender: $gender, gender_value: $gender_value, avatar_url: $avatar_url, nameProvider: $name_provider)';
  }

  @override
  bool operator ==(covariant UserInfo other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.account_id == account_id &&
      other.created_at == created_at &&
      other.name == name &&
      other.last_name == last_name &&
      other.nickname == nickname &&
      other.birthday == birthday &&
      other.gender == gender &&
      other.gender_value == gender_value &&
      other.avatar_url == avatar_url &&
      other.name_provider == name_provider &&
      other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      account_id.hashCode ^
      created_at.hashCode ^
      name.hashCode ^
      last_name.hashCode ^
      nickname.hashCode ^
      birthday.hashCode ^
      gender.hashCode ^
      gender_value.hashCode ^
      avatar_url.hashCode ^
      name_provider.hashCode ^
      updated_at.hashCode;
  }
}
