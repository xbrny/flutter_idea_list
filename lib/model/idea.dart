import 'package:cloud_firestore/cloud_firestore.dart';

class Idea {
  String id;
  String title;
  String content;
  String userId;
  DateTime createdAt;

  Idea({this.id, this.title, this.content, this.userId, this.createdAt});

  factory Idea.empty() => Idea(
        id: '',
        title: '',
        content: '',
        userId: '',
      );

  factory Idea.fromMap(Map<String, dynamic> map) => Idea(
        id: map['id'],
        title: map['title'],
        content: map['content'],
        userId: map['userId'],
        createdAt: map['createdAt'] == null
            ? null
            : DateTime.parse(map['createdAt'] as String),
      );

  factory Idea.fromSnapshot(DocumentSnapshot documentSnapshot) =>
      Idea.fromMap(documentSnapshot.data)..id = documentSnapshot.documentID;

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'title': this.title,
      'content': this.content,
      'userId': this.userId,
      'createdAt': this.createdAt?.toIso8601String(),
    };
  }
}
