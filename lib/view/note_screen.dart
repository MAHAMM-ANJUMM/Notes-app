import 'package:flutter/material.dart';
import '../viewmodel/note_viewmodel.dart';
import '../model/note_model.dart';

class NoteScreen extends StatefulWidget {
  final NoteModel note;

  NoteScreen({required this.note});

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  final NoteViewModel _noteViewModel = NoteViewModel();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Edit Note'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              await _noteViewModel.deleteNote(widget.note.noteId);
              Navigator.pop(context);
            },
          ),
        ],
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
                      await _noteViewModel.updateNote(
                        widget.note.noteId,
                        _titleController.text,
                        _contentController.text,
                      );
                      setState(() => _isLoading = false);
                      Navigator.pop(context);
                    },
                    child: Text('Save Changes'),
                  ),
          ],
        ),
      ),
    );
  }
}
