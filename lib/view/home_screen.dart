import 'package:flutter/material.dart';
import 'package:notes_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import 'new_note_screen.dart';
import 'note_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text('Notes', style: TextStyle(color: Colors.cyan)),
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
        actions: [
          IconButton(
            icon: Icon(
                themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: themeProvider.isDarkMode ? Colors.cyan : Colors.black),
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
      ),
      body: Consumer<NoteProvider>(
        builder: (context, noteProvider, child) {
          final notes = noteProvider.notes;
          if (notes.isEmpty) {
            return Center(
              child: Text('No notes yet.',
                  style: TextStyle(color: Colors.cyanAccent)),
            );
          }
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: themeProvider.isDarkMode
                        ? Colors.grey
                        : Colors.white, // Border color
                    width: 2.0, // Border width
                  ),
                  borderRadius:
                      BorderRadius.circular(20.0), // Optional: Rounds corners
                ),
                margin: EdgeInsets.symmetric(
                    vertical: 4.0, horizontal: 8.0), // Optional: Adds spacing
                child: Card(
                  color: themeProvider.isDarkMode ? Colors.black : Colors.white,
                  elevation: 4, // Adds shadow effect
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8.0), // Matches the container border radius
                  ),
                  child: ListTile(
                    title:
                        Text(note.title, style: TextStyle(color: Colors.cyan)),
                    subtitle: Text(
                      note.content,
                      style: TextStyle(color: Colors.cyan),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NoteScreen(note: note),
                        ),
                      );
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.blueGrey),
                      onPressed: () => noteProvider.deleteNote(note.noteId),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        child: Icon(
          Icons.add,
          color: themeProvider.isDarkMode ? Colors.black : Colors.white,
        ),
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
