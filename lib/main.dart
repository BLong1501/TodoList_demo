
import 'package:app_dacs/model/items.dart' ;
import 'package:app_dacs/widget/model_button.dart';
import 'package:flutter/material.dart';
import 'package:app_dacs/widget/card_body_widget.dart';

void main(List<String> args) {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<DataItems> items = [
    // DataItems(id: '1', name: "Đánh răng"),
    // DataItems(id: '2', name: "Rửa mặt"),
    // DataItems(id: '3', name: "Ăn sáng"),
    // DataItems(id: '4', name: "Đi học"),
    // DataItems(id: '4', name: "Đi học"),
  ];

  void _handleAddTask(String name){
     final newItem = DataItems(id: DateTime.now().toString() ,name:name );
    
      setState(() {
       items.add(newItem);
       print(newItem.id);
      });     
      

  }

  void _deleteTask(String id){ 
    setState(() {
      items.removeWhere((item) => item.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      
      appBar: AppBar(
        title: const Text(
          'ToDoList',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        shadowColor: const Color.fromARGB(255, 189, 148, 148), // màu bóng
        elevation: 5, // độ cao -> bóng rõ hơn
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: items.map((item) =>  CardBody(
            index:items.indexOf(item),
            item: item,
             deleteTask: _deleteTask)).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            isScrollControlled: true,
            context: context,
            builder: (BuildContext content) {
              return ModelButton( addTask: _handleAddTask);
            },
          );
        },
        child: Icon(Icons.add, size: 30),
      ),
    );
  }
}


