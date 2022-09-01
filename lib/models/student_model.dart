// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Student {
  final String? id;
  final String? firstname;
  final String? lastname;
  final String? createdAt;
  final String? avatar;
  Student({
    this.id,
    this.firstname,
    this.lastname,
    this.createdAt,
    this.avatar,
  });

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
        id: map['id'],
        firstname: map['firstname'],
        lastname: map['lastname'],
        createdAt: map['createdAt'],
        avatar: map['avatar']);
  }
 
  @override
  String toString() {
    return 'Student(id: $id, firstname: $firstname, lastname: $lastname, createdAt: $createdAt, avatar: $avatar)';
  }

  @override
  bool operator ==(covariant Student other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstname == firstname &&
        other.lastname == lastname &&
        other.createdAt == createdAt &&
        other.avatar == avatar;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstname.hashCode ^
        lastname.hashCode ^
        createdAt.hashCode ^
        avatar.hashCode;
  }
}
