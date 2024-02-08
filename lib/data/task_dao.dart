import 'package:sqflite/sqflite.dart';
import 'package:teste_drive/components/task.dart';
import 'package:teste_drive/data/database.dart';

class TaskDao {
  
  static const String tableSql = 'CREATE TABLE $_tableName('
    '$_name TEXT, '
    '$_difficulty INTEGER, '
    '$_image TEXT)';

  static const String _tableName = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  save(Task task) async {
    print("Acessando o save");
    final Database db = await getDatabase();

    var itemExists = await find(task.name);

    Map<String, dynamic> taskMap = toMap(task); 
    if(itemExists.isEmpty){
      print("Tarefa não existia");
    return await db.insert(
        _tableName, 
        taskMap
      );
    }
   else{
      print("Tarefa existia");
      return await db.update(
        _tableName, 
        taskMap, 
        where: '$_name = ?', 
        whereArgs: [task.name]);
    }
  }

  Future<List<Task>> findAll() async {
    print("Acessando o findAll");
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    print("Procurando dados no DB... Encontrado: $result");

    return toList(result);
  }

  List<Task> toList(List<Map<String, dynamic>> taskList){
    print("Convertendo para lista");

    final List<Task> tasks = [];

    for(Map<String, dynamic> task in taskList){
      final Task newTask = Task(task[_name], task[_image], task[_difficulty]);
      tasks.add(newTask);
    }

    print("Lista de tarefas: $tasks");
    return tasks;
  }

  Map<String, dynamic> toMap(Task task){
    print("Convertendo task em map");
    final Map<String, dynamic> emptyMap = Map();
    emptyMap[_name] = task.name;
    emptyMap[_difficulty] = task.difficulty;
    emptyMap[_image] = task.photo;
    print("Objetos: $emptyMap");

    return emptyMap;
  }

  Future<List<Task>> find(String taskName) async {
    print("Acessando o find");
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName, where: '$_name = ?', whereArgs: [taskName]);
    print("Tareaf encontrada: ${toList(result)}");

    return toList(result);
  }

  delete(String taskName) async {
      print("Deletando tarefa");
      final Database db = await getDatabase();
      return db.delete(_tableName, where: '$_name = ?', whereArgs: [taskName]);
   }
}
