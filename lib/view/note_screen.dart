import 'package:flutter/material.dart';
import 'package:notes_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import '../viewmodel/note_viewmodel.dart';
import '../model/note_model.dart';

class NoteScreen extends StatefulWidget {
  final NoteModel note;

  const NoteScreen({super.key, required this.note});

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
  }

  @override
  Widget build(BuildContext context) {
    final noteViewModel = Provider.of<NoteViewModel>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text(
          'Edit Note',
          style: TextStyle(color: Colors.cyan),
        ),
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.blueGrey),
            onPressed: () async {
              setState(() => _isLoading = true);
              try {
                await noteViewModel.deleteNote(widget.note.noteId);
                Navigator.pop(context);
              } catch (e) {
                _showErrorSnackBar(context, 'Error deleting note');
              } finally {
                setState(() => _isLoading = false);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField(
              controller: _titleController,
              label: 'Title',
              context: context,
            ),
            SizedBox(height: 12),
            _buildTextField(
              controller: _contentController,
              label: 'Content',
              context: context,
              maxLines: 5,
            ),
            SizedBox(height: 20),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: () async {
                      setState(() => _isLoading = true);
                      try {
                        await noteViewModel.updateNote(
                          widget.note.noteId,
                          _titleController.text,
                          _contentController.text,
                        );
                        Navigator.pop(context);
                      } catch (e) {
                        _showErrorSnackBar(context, 'Error saving changes');
                      } finally {
                        setState(() => _isLoading = false);
                      }
                    },
                    child: Text('Save Changes',
                        selectionColor: themeProvider.isDarkMode
                            ? Colors.black
                            : Colors.white,
                        style: TextStyle(color: Colors.cyan)),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required BuildContext context,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(color: Colors.cyan),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.blueGrey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.cyanAccent),
        ),
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}
