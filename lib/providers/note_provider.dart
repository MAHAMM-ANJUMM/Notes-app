import 'package:flutter/material.dart';
import '../model/note_model.dart';
import '../viewmodel/note_viewmodel.dart';

class NoteProvider with ChangeNotifier {
  final NoteViewModel _noteViewModel = NoteViewModel();
  List<NoteModel> _notes = [];

  NoteProvider() {
    _noteViewModel.fetchNotes().listen((notes) {
      _notes = notes;
      notifyListeners();
    });
  }

  List<NoteModel> get notes => _notes;

  Future<void> addNote(String title, String content) async {
    await _noteViewModel.addNote(title, content);
  }

  Future<void> updateNote(String noteId, String title, String content) async {
    await _noteViewModel.updateNote(noteId, title, content);
  }

  Future<void> deleteNote(String noteId) async {
    await _noteViewModel.deleteNote(noteId);
  }
}
