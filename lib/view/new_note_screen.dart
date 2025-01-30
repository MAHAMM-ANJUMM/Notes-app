import 'package:flutter/material.dart';
import 'package:notes_app/viewmodel/note_viewmodel.dart';

class NewNoteScreen extends StatefulWidget {
  @override
  _NewNoteScreenState createState() => _NewNoteScreenState();
}

class _NewNoteScreenState extends State<NewNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final NoteViewModel _noteViewModel = NoteViewModel();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('New Note'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _contentController,
              maxLines: 5,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Content',
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 20),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: () async {
                      setState(() => _isLoading = true);
                      await _noteViewModel.addNote(
                        _titleController.text,
                        _contentController.text,
                      );
                      setState(() => _isLoading = false);
                      Navigator.pop(context);
                    },
                    child: Text('Save Note'),
                  ),
          ],
        ),
      ),
    );
  }
}
