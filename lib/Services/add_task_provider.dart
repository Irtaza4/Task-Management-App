import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class AddTaskProvider with ChangeNotifier{
  final DatabaseReference _ref = FirebaseDatabase.instance.ref('task');
   List<Map<String,dynamic>> _Tasks=[];
   List<Map<String,dynamic>> get Tasks => _Tasks;

  Future<void> addTasks(String title, String description)async{
    await _ref.child(DateTime.now().millisecondsSinceEpoch.toString()).set(
        {
          "title" : title,
          "description":description,
          "isCompleted": false,

        });

  }
  AddTaskProvider(){
    fetchTasks();
  }
  Future<void> fetchTasks() async{
    _ref.onValue.listen((event){
      final data = event.snapshot.value as Map<dynamic,dynamic>?;
      if(data!=null){
        _Tasks= data.entries.map((e)=>{
          "id":e.key,
          "title":e.value['title'],
          "description": e.value['description'],
          "isCompleted": e.value['isCompleted'] ?? false,
        }).toList();
        notifyListeners();
      }

    });
  }

  Future<void> updatedTask(String id, Map<String,dynamic> updatedTask)async{
    await _ref.child(id).update(updatedTask);
  }
  Future<void> deleteTask(String id) async {
    try {
      await _ref.child(id).remove(); // Remove from Firebase
      _Tasks.removeWhere((task) => task['id'] == id); // Remove from local list
      notifyListeners(); // Notify UI about the change
    } catch (error) {
      if (kDebugMode) {
        print("Failed to delete task: $error");
      }
    }
  }
}