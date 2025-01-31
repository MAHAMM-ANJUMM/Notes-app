import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/note_model.dart';

class NoteViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<NoteModel> _notes = []; // Store notes locally
  List<NoteModel> get notes => _notes;

  // Fetch Notes
  Stream<List<NoteModel>> fetchNotes() {
    return _firestore
        .collection('notes')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (doc) => NoteModel.fromMap(doc.data()..['noteId'] = doc.id),
            )
            .toList());
  }

  // Add Note
  Future<void> addNote(String title, String content) async {
    try {
      final docRef = _firestore.collection('notes').doc();
      final newNote = NoteModel(
        noteId: docRef.id,
        title: title,
        content: content,
        createdAt: Timestamp.now(),
      );

      await docRef.set(newNote.toMap());

      _notes.insert(0, newNote); // Add to local list
      notifyListeners(); // Notify UI
    } catch (e) {
      print('Error adding note: $e');
    }
  }

  // Update Note
  Future<void> updateNote(String noteId, String title, String content) async {
    try {
      await _firestore.collection('notes').doc(noteId).update({
        'title': title,
        'content': content,
      });

      int index = _notes.indexWhere((note) => note.noteId == noteId);
      if (index != -1) {
        _notes[index] = NoteModel(
          noteId: noteId,
          title: title,
          content: content,
          createdAt: _notes[index].createdAt,
        );
      }

      notifyListeners();
    } catch (e) {
      print('Error updating note: $e');
    }
  }

  // Delete Note
  Future<void> deleteNote(String noteId) async {
    try {
      await _firestore.collection('notes').doc(noteId).delete();
      _notes.removeWhere((note) => note.noteId == noteId);
      notifyListeners();
    } catch (e) {
      print('Error deleting note: $e');
    }
  }
}
