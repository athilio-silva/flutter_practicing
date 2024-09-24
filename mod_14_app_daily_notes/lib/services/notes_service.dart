import 'package:flutter/material.dart';
import 'package:mod_14_app_daily_notes/database/database_helper.dart';
import 'package:mod_14_app_daily_notes/models/note.dart';

class NotesService {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final String _tableName = 'notes';

  void addNote(Note note) async {
    final db = await _databaseHelper.database;

    int id = await db.insert(_tableName, {
      'title': note.title,
      'content': note.content,
      'createdAt': note.createdAt,
      // DateTime.now().toIso8601String(),
    });

    debugPrint('Anotação adicionada com ID: $id');
  }

  Future<List<Note>> getNotes() async {
    final db = await _databaseHelper.database;
    final notes = await db.query(_tableName);
    return notes.map((note) => Note.fromJson(note)).toList();
  }

  Future<Note> getNoteById(int id) async {
    final db = await _databaseHelper.database;
    final note = await db.query(_tableName, where: 'id = ?', whereArgs: [id]);
    return Note.fromJson(note.first);
  }

  Future<void> updateNote(int id, String title, String content) async {
    final db = await _databaseHelper.database;
    await db.update(_tableName, {'title': title, 'content': content},
        where: 'id = ?', whereArgs: [id]);
  }

  void deleteNote(int id) async {
    final db = await _databaseHelper.database;
    int deletedNote = await db.delete(_tableName, where: 'id = ?', whereArgs: [id],);
    debugPrint('Anotação deletada com ID: $deletedNote');
  }
}
