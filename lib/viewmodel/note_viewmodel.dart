import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/note_model.dart';

class NoteViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch Notes
  Stream<List<NoteModel>> fetchNotes() {
    return _firestore
        .collection('notes')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => NoteModel.fromMap(doc.data()))
              .toList(),
        );
  }

  // Add Note
  Future<void> addNote(String title, String content) async {
    final docRef = _firestore.collection('notes').doc();
    final newNote = NoteModel(
      noteId: docRef.id,
      title: title,
      content: content,
      createdAt: Timestamp.now(),
    );
    await docRef.set(newNote.toMap());
  }

  // Update Note
  Future<void> updateNote(String noteId, String title, String content) async {
    await _firestore.collection('notes').doc(noteId).update({
      'title': title,
      'content': content,
    });
  }

  // Delete Note
  Future<void> deleteNote(String noteId) async {
    await _firestore.collection('notes').doc(noteId).delete();
  }
}
