import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Database> _connection() async {
    final pathDB = await getDatabasesPath();
    final localDB = path.join(pathDB, 'local_db.db');

    Database db = await openDatabase(
      localDB,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, name VARCHAR(255), age INTEGER)',
        );
      },
    );

    debugPrint(db.toString());

    return db;
  }

  void _insert() async {
    final db = await _connection();

    int id = await db.insert('users', {'name': 'MacLOVIN', 'age': 43});

    debugPrint('id: $id');
  }

  Future<List<Map<String, dynamic>>> _getUsers() async {
    final db = await _connection();

    final List<Map<String, dynamic>> users = await db.query('users');

    for (var user in users) {
      debugPrint('usuário: $user');
    }

    return users;
  }

  Future<Map<String, dynamic>> _getUser(int id) async {
    final db = await _connection();

    final user = await db.query(
      'users',
      where: 'id = $id',
    );

    debugPrint('usuário: ${user.first}');

    return user.first;
  }

  void _updateUser(int id) async {
    final db = await _connection();

    final user = await db.update(
      'users',
      {'name': 'MacLovin', 'age': 43},
      where: 'id = $id',
    );

    debugPrint('usuário atualizado: $user');
  }

  void _deleteUser(int id) async {
    final db = await _connection();

    final user = await db.delete(
      'users',
      where: 'id = $id',
    );

    debugPrint('usuário removido: $user');
  }

  @override
  Widget build(BuildContext context) {
    // _insert();
    // _getUsers();
    // _getUser(3);
    // _updateUser(3);
    // _deleteUser(2);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter com sqflite'),
        centerTitle: false,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: const Column(
          children: [
            Text('Hello'),
          ],
        ),
      ),
    );
  }
}
