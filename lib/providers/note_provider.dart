import 'package:flutter/material.dart';
import 'package:notes_app/viewmodel/note_viewmodel.dart';
import '../model/note_model.dart';
import 'dart:async';

class NoteProvider with ChangeNotifier {
  final NoteViewModel _noteViewModel = NoteViewModel();
  List<NoteModel> _notes = [];
  StreamSubscription<List<NoteModel>>? _noteSubscription;

  List<NoteModel> get notes => _notes;

  NoteProvider() {
    _noteSubscription = _noteViewModel.fetchNotes().listen((notes) {
      _notes = notes;
      notifyListeners(); // Notify UI when notes update
    });
  }

  @override
  void dispose() {
    _noteSubscription
        ?.cancel(); // Cancel subscription when provider is disposed
    super.dispose();
  }

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
