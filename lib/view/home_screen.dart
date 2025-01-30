// lib/view/home_screen.dart
import 'package:flutter/material.dart';
import 'package:notes_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import 'new_note_screen.dart';
import 'note_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Notes'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Consumer<NoteProvider>(
        builder: (context, noteProvider, child) {
          final notes = noteProvider.notes;
          if (notes.isEmpty) {
            return Center(
              child:
                  Text('No notes yet.', style: TextStyle(color: Colors.white)),
            );
          }
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return Card(
                color: Colors.grey[900],
                child: ListTile(
                  title:
                      Text(note.title, style: TextStyle(color: Colors.white)),
                  subtitle: Text(
                    note.content,
                    style: TextStyle(color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NoteScreen(note: note)),
                    );
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => noteProvider.deleteNote(note.noteId),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewNoteScreen()),
          );
        },
      ),
    );
  }
}
