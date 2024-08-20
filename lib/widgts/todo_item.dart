import 'package:flutter/material.dart';
import 'package:to_do_app/constraints/colors.dart';
import 'package:to_do_app/model/todo.dart';

class toDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDochanged;
 final onDeleteItem;
  const toDoItem({super.key, required this.todo, this.onToDochanged, this.onDeleteItem});
  
  @override
  Widget build(BuildContext context) {
    return Container(
    padding: EdgeInsets.all(0),
    margin: EdgeInsets.symmetric(vertical: 12),

    child: ListTile(onTap: () {
      onToDochanged(todo);
    },
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
    tileColor: const Color.fromARGB(255, 234, 213, 213),
    leading: 
    todo.isDone? Icon(Icons.check_box):Icon(Icons.check_box_outline_blank),
    title: Text(todo.todoText!,
    style: TextStyle(fontSize: 16,color: tdBlack,
    decoration: todo.isDone? TextDecoration.lineThrough : null,)),
    trailing: Container(height: 35,width: 35,decoration: BoxDecoration(
    color: tdBlue,borderRadius: BorderRadius.circular(5)
    ),
    child: IconButton(
      color: tdRed ,
      iconSize: 18,
      onPressed: (){
        onDeleteItem(todo.id);
      },
       icon: Icon(Icons.delete)),
    ),
    )
    );
  }
}