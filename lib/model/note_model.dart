import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  final String noteId;
  final String title;
  final String content;
  final Timestamp createdAt;

  NoteModel({
    required this.noteId,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  // Convert NoteModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'noteId': noteId,
      'title': title,
      'content': content,
      'createdAt': createdAt,
    };
  }

  // Create a NoteModel from Firestore document
  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      noteId: map['noteId'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      createdAt: map['createdAt'] ?? Timestamp.now(),
    );
  }
}
