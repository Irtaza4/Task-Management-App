
import 'package:final_project_internship/Services/add_task_provider.dart';
import 'package:final_project_internship/UI/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTasks extends StatefulWidget {
  const AddTasks({super.key});

  @override
  State<AddTasks> createState() => _AddTasksState();
}

class _AddTasksState extends State<AddTasks> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Tasks"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text("Enter Your Task Title",style: TextStyle(
                color: Colors.grey.shade600,fontWeight: FontWeight.bold,fontSize: 12),),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextFormField(
            controller: titleController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                label: Text("Title"),
                border: OutlineInputBorder()
              ),
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text("Enter Your Task Description",style: TextStyle(
                color: Colors.grey.shade600,fontWeight: FontWeight.bold,fontSize: 12),),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextFormField(
              controller: descriptionController,
              keyboardType: TextInputType.text,
              maxLines: 3,
              decoration: InputDecoration(
                  label: Text("Description"),
                  border: OutlineInputBorder()
              ),
            ),
          ),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: ()async{
            final title = titleController.text.trim();
            final description=descriptionController.text.trim();

            if(title.isNotEmpty && description.isNotEmpty){
              await Provider.of<AddTaskProvider>(context,listen: false).addTasks(title, description);
              titleController.clear();
              descriptionController.clear();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Task Added")));
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
            }
            else{
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Please fill all the fields!"))
              );
            }
          }, child: Text("Add Task"))

        ],
      ),
    );
  }
}
