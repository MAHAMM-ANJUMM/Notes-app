import 'package:flutter/material.dart';
import 'package:notes_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import '../viewmodel/note_viewmodel.dart';

class NewNoteScreen extends StatefulWidget {
  const NewNoteScreen({super.key});

  @override
  _NewNoteScreenState createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final noteViewModel = Provider.of<NoteViewModel>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text('New Note', style: TextStyle(color: Colors.cyan)),
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              style: TextStyle(color: Colors.cyan),
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(color: Colors.blueGrey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyanAccent),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _contentController,
              maxLines: 5,
              style: TextStyle(color: Colors.cyan),
              decoration: InputDecoration(
                labelText: 'Content',
                labelStyle: TextStyle(color: Colors.blueGrey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey),
                ),
              ),
            ),
            SizedBox(height: 20),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: () async {
                      if (_titleController.text.isEmpty ||
                          _contentController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Title and content cannot be empty"),
                            backgroundColor: Colors.blueGrey,
                          ),
                        );
                        return;
                      }

                      setState(() => _isLoading = true);

                      try {
                        await noteViewModel.addNote(
                          _titleController.text,
                          _contentController.text,
                        );

                        Navigator.pop(context); // Close screen after saving
                      } catch (e) {
                        print("Error saving note: $e");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Failed to save note"),
                            backgroundColor: Colors.blueGrey,
                          ),
                        );
                      } finally {
                        setState(() => _isLoading = false);
                      }
                    },
                    child: Text('Save Note'),
                  ),
          ],
        ),
      ),
    );
  }
}
