import 'package:flutter/material.dart';
import 'package:mod_14_app_daily_notes/models/note.dart';
import 'package:mod_14_app_daily_notes/services/notes_service.dart';
import 'package:mod_14_app_daily_notes/utils/formatting.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  final NotesService _notesService = NotesService();

  void _buildDialog(BuildContext context, {Note? note}) {
    String textAction = 'Salvar';
    if (note != null) {
      _titleController.text = note.title;
      _contentController.text = note.content;
      textAction = 'Editar';
    } else {
      _titleController.clear();
      _contentController.clear();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Adicionar Anotação'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  hintText: 'Digite o título',
                ),
              ),
              TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  hintText: 'Digite a descrição',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // salvar anotação
                if (note == null) {
                  final note = Note(
                    id: 0,
                    title: _titleController.text,
                    content: _contentController.text,
                    createdAt: DateTime.now().toString(),
                  );
                  _notesService.addNote(note);
                } else {
                  _notesService.updateNote(
                    note.id, 
                    _titleController.text, 
                    _contentController.text
                  );
                }
                Navigator.pop(context);

                _titleController.clear();
                _contentController.clear();

                setState(() {});
              },
              child: Text(textAction),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Note>> notes = _notesService.getNotes();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Anotações',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.lightGreen,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        child: const Icon(Icons.add),
        onPressed: () {
          _buildDialog(context);
        },
      ),
      body: FutureBuilder(
        future: notes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          List<Note> notesList = snapshot.data!;

          if (notesList.isEmpty) {
            return const Center(
              child: Text('Crie sua anotação!'),
            );
          }

          return ListView.builder(
            itemCount: notesList.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(notesList[index].title),
                  subtitle:
                      Text(Formatting.formatDate(notesList[index].createdAt)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          _buildDialog(context, note: notesList[index]);
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          _notesService.deleteNote(notesList[index].id);
                          setState(() {});
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
