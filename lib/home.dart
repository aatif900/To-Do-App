import 'package:flutter/material.dart';
import 'package:to_do_app/constraints/colors.dart';
import 'package:to_do_app/model/todo.dart';
import 'package:to_do_app/widgts/todo_item.dart';

class Home extends StatefulWidget {
   Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
final todosList= ToDo.todoList();
List<ToDo> _find=[];
final _todoController= TextEditingController();
@override
  void initState() {
    // TODO: implement initState
    _find=todosList;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGC,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [Container(margin: EdgeInsets.only(top: 50,bottom: 20),
                    child:Text('All Tasks',
                    style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600),) ,),
                    for(ToDo todo in _find.reversed)
                    toDoItem(
                      todo: todo,
                      onToDochanged: _handle,
                      onDeleteItem: _delete,
                    ),

                    ],
                  ),
                )
              ],
            ),
          
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(child:Container(
              
              margin: EdgeInsets.only(bottom: 20,right: 20,left: 20),
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              decoration:  BoxDecoration(
              color: Colors.white,
              boxShadow:  const  [BoxShadow(color:Colors.grey,
              blurRadius: 10.0,
              offset: Offset(0.0, 0.0),
              spreadRadius: 0.0,
              )],
              borderRadius: BorderRadius.circular(10),
              
              ),
              child:TextField(
                controller: _todoController,
                decoration: const InputDecoration(
                  hintText: 'New Task',
                  border: InputBorder.none,
                ),
              ),
              )
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20,right: 20),
                child: ElevatedButton(onPressed:() {
                  add(_todoController.text);
                }, child: Text('+',
                style:  TextStyle(fontSize: 40,color: Colors.red),),
                style: ElevatedButton.styleFrom(
                minimumSize: Size(60, 60),
                elevation: 10,
                backgroundColor: tdBlue,
                ),
                
                )
              )

            ],),
          )
        ],
      ),
    
    );
  }

void _handle(ToDo todo){
  setState(() {
    todo.isDone=!todo.isDone;
  });
  
}

void _delete(String id){
  setState(() {
    todosList.removeWhere((item)=>item.id==id);
  });
  
}
void add(String toDo){
  setState(() {
    todosList.add(ToDo(id: DateTime.now().millisecondsSinceEpoch.toString(), todoText: toDo));
  });
  _todoController.clear();
}

void run(String enteredkeyword){
  List<ToDo> results=[];
  if(enteredkeyword.isEmpty){
    results=todosList;
  }else{
    results=todosList.where((item)=>item.todoText!.toLowerCase().contains(enteredkeyword.toLowerCase())).toList();
  }
  setState(() {
    _find=results;
  });
}

Widget searchBox(){
  return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration:
             BoxDecoration(
              color:const Color.fromARGB(255, 234, 213, 213),
              borderRadius: BorderRadius.circular(20),
             ),
             child: TextField(
            onChanged: (value) => run(value),
            decoration:
            InputDecoration(contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(Icons.search,color: tdBlack,size: 20,),
            prefixIconConstraints: BoxConstraints(maxHeight: 20,minWidth: 25),
            border: InputBorder.none,
            hintText: 'Search Tasks',
            hintStyle: TextStyle(color: tdGrey),
             ),
             
             ),
             );
}

  AppBar _buildAppBar() {
    return AppBar(
      elevation:0,
      backgroundColor: tdBGC,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        const Icon(Icons.menu,color: tdBlack,size: 30,),
        Container(height: 60,width: 60,child:ClipRRect(borderRadius: BorderRadius.circular(60),
        child: Image.asset('assets/images/pic1.png'),
        ),
        )],
        
        ),
    );
  }
}