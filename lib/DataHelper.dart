// import 'dart:async';
// import 'dart:io' as io;
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';
// import 'diary.dart';

// class DBHelper {
//   static Database _db;
//   static const String ITEMNAME = 'item';
//   static const String ITEMPRICE = 'itemPrice';
//   static const String TABLE = 'diary';
//   static const String DB_NAME = 'diary.db';

//   Future<Database> get db async {
//     if (_db != null) {
//       return _db;
//     }
//     _db = await initDb();
//     return _db;
//   }

//   initDb() async {
//     io.Directory documnetsDirectory = await getApplicationDocumentsDirectory();
//     String Path = join(documnetsDirectory.path, DB_NAME);
//     var db = await openDatabase(Path, version: 1, onCreate: _onCreate);
//   }

//   _onCreate(Database db, int version) async {
//     await db.execute("CREATE TABLE $TABLE ($ITEMPRICE INTEGER, $ITEMNAME TEXT");
//   }

//   Future<DiaryItem> save(DiaryItem diary) async {
//     var dbClient = await db;
//     diary.itemPrice = await dbClient.insert(TABLE, diary.toMap());
//     return diary;

//     await dbClient.transaction((txn) async {
//       var query =
//           "INSERT INTO $TABLE ($ITEMNAME) VALUES ('" + diary.items + "')";
//       return await txn.rawInsert(query);
//     });
//   }

//   Future<List<DiaryItem>> getDiaries() async {
//     var dbClient = await db;
//     List<Map> maps =
//         await dbClient.query(TABLE, columns: [ITEMNAME, ITEMPRICE]);
//     //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
//     List<DiaryItem> diary = [];
//     if (maps.length > 0) {
//       for (int i = 0; i < maps.length; i++) {
//         diary.add(DiaryItem.fromMap(maps[i]));
//       }
//     }
//     return diary;
//   }

//   Future<int> delete(int id) async {
//     var dbClient = await db;
//     return await dbClient
//         .delete(TABLE, where: '$ITEMNAME = ?', whereArgs: [ITEMNAME]);
//   }

//   Future<int> update(DiaryItem diary) async {
//     var dbClient = await db;
//     return await dbClient.update(TABLE, diary.toMap(),
//         where: '$ITEMNAME = ?', whereArgs: [diary.items]);
//   }

//   Future close() async {
//     var dbClient = await db;
//     dbClient.close();
//   }
// }
