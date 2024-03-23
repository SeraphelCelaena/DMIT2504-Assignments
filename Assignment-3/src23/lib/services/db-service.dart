// ignore_for_file: todo, avoid_print, library_prefixes, avoid_function_literals_in_foreach_calls, file_names, unused_import

import 'package:path/path.dart' as pathPackage;
import 'package:sqflite/sqflite.dart' as sqflitePackage;

class SQFliteDbService {
  late sqflitePackage.Database db;
  late String path;

  Future<void> getOrCreateDatabaseHandle() async {
    try {
      //TODO: Put your code here to complete this method.
      var databasesPath = await sqflitePackage.getDatabasesPath();
      path = pathPackage.join(databasesPath, 'stocks.db');
      db = await sqflitePackage.openDatabase(path, version: 1,
          onCreate: (sqflitePackage.Database db, int version) async {
        await db.execute(
          'CREATE TABLE Stocks (id INTEGER PRIMARY KEY, name TEXT, symbol TEXT, currentPrice REAL)',
        );
      });
    } catch (e) {
      print('SQFliteDbService getOrCreateDatabaseHandle: $e');
    }
  }

  Future<void> printAllStocksInDbToConsole() async {
    try {
      //TODO: Put your code here to complete this method.
      List<Map> list = await db.rawQuery('SELECT * FROM Stocks');
      list.forEach((element) {
        print(element);
      });
    } catch (e) {
      print('SQFliteDbService printAllStocksInDbToConsole: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllStocksFromDb() async {
    try {
      //TODO: Put your code here to complete this method.
      // Replace this return with valid data.
      List<Map<String, dynamic>> list = await db.rawQuery('SELECT * FROM Stocks');
      return list;
    } catch (e) {
      print('SQFliteDbService getAllStocksFromDb: $e');
      return <Map<String, dynamic>>[];
    }
  }

  Future<void> deleteDb() async {
    try {
      //TODO: Put your code here to implement this method.
      await sqflitePackage.deleteDatabase(path);
    } catch (e) {
      print('SQFliteDbService deleteDb: $e');
    }
  }

  Future<void> insertStock(Map<String, dynamic> stock) async {
    try {
      //TODO:
      //Put code here to insert a stock into the database.
      //Insert the Stock into the correct table.
      //Also specify the conflictAlgorithm.
      //In this case, if the same stock is inserted
      //multiple times, it replaces the previous data.
      await db.insert('Stocks', stock,
          conflictAlgorithm: sqflitePackage.ConflictAlgorithm.replace);
    } catch (e) {
      print('SQFliteDbService insertStock: $e');
    }
  }

  Future<void> updateStock(Map<String, dynamic> stock) async {
    try {
      //TODO:
      //Put code here to update stock info.
      await db.update('stocks.db', stock,
          where: 'id = ?', whereArgs: [stock['id']]);
    } catch (e) {
      print('SQFliteDbService updateStock: $e');
    }
  }

  Future<void> deleteStock(Map<String, dynamic> stock) async {
    try {
      //TODO:
      //Put code here to delete a stock from the database.
      await db.delete('stocks.db', where: 'id = ?', whereArgs: [stock['id']]);
    } catch (e) {
      print('SQFliteDbService deleteStock: $e');
    }
  }
}
