import 'package:ai_grammer_app/models/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteController with ChangeNotifier {
  Future<Database> createDatabaseConnection() async {
    return openDatabase(
      join(await getDatabasesPath(), "chatMessage.db"),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
            create Table Ai_chat(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                message TEXT NOT NULL,
                isUser INTEGER NOT NULL,
                isCorrectCheck INTEGER NOT NULL,
                isLoading INTEGER NOT NULL
            )
        ''');
      },
    );
  }

  Future<void> addData({required Map<String, dynamic> json}) async {
    Database? database = await createDatabaseConnection();

    await database.insert("Ai_chat", json);

    notifyListeners();
  }

  List<ChatMessage> messages = [];

  Future<void> getAllMessage() async {
    final db = await createDatabaseConnection();

    final result = await db.query("Ai_chat", orderBy: "id ASC");

    messages = result.map((e) => ChatMessage.fromMap(e)).toList();

    notifyListeners();
  }

  Future<void> deleteChat({required int id}) async {
    Database? database = await createDatabaseConnection();

    await database.delete("Ai_chat", where: "id = ?", whereArgs: [id]);

    await getAllMessage();

    notifyListeners();
  }
}
