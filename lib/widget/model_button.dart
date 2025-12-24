import 'package:flutter/material.dart';

class ModelButton extends StatelessWidget {
   ModelButton({
    super.key,
    required this.addTask,
  });

final Function addTask;
TextEditingController controller = TextEditingController();
void _handleOnClick(BuildContext context){
  final name = controller.text;
  if(name.isEmpty || name.trim().isEmpty){
     ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Task không được để trống!")),

      );
      return;
  }
  addTask(name);  
  Navigator.of(context).pop();
}
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
    
        color: const Color.fromARGB(255, 115, 100, 118),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(bottom: 10)),
            SizedBox(height: 10),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
    
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 255, 255, 255),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                    width: 2,
                  ),
                ),
                labelText: 'Enter your task',
                contentPadding: EdgeInsets.all(20),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _handleOnClick(context),
                child: Text('Add task'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}