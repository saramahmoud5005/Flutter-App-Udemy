
import 'dart:ffi';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/archived_tasks/archived_tasks_screen.dart';
import 'package:flutter_app/models/done_tasks/done_tasks_screen.dart';
import 'package:flutter_app/models/new_tasks/new_tasks_screen.dart';
import 'package:flutter_app/shared/components/components.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../shared/components/constants.dart';

class HomeLayout extends StatefulWidget {

  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {

  int currentIndex = 0;
  List<Widget> screen = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  late Database database;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool isBottomSheetShown =false;
  IconData fabIcon = Icons.edit;
  var titleController =TextEditingController();
  var timeController =TextEditingController();
  var dateController =TextEditingController();

  @override
  void initState(){
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
            'Todo App'
        ),
      ),
      body: ConditionalBuilder(
        condition: tasks.length>0,
        builder: (context)=> screen[currentIndex],
        fallback: (context)=> Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          fabIcon,
        ),
        onPressed: (){
          if(isBottomSheetShown){
            if(formKey.currentState!.validate()){
              insertToDatabase(
                title: titleController.text,
                time: timeController.text,
                date: dateController.text,
              ).then((value){
                Navigator.pop(context);
                isBottomSheetShown=false;
                setState((){
                  fabIcon=Icons.edit;
                });
              });

            }

          }
          else{
            scaffoldKey.currentState?.showBottomSheet(
                  (context) =>Container(
                    color: Colors.grey[100],
                    padding: EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          defaultFormField(
                              controller: titleController,
                              type: TextInputType.text,
                              validate: (value){
                                if(value!.isEmpty){
                                  return 'title must not be empty';
                                }
                                return null;
                              },
                              label: 'Task Title',
                              prefix: Icons.title,
                              suffixPressed: (){},
                          ),
                          SizedBox(height: 8.0,),
                          defaultFormField(
                            controller: timeController,
                            type: TextInputType.datetime,
                            validate: (value){
                              if(value!.isEmpty){
                                return 'time must not be empty';
                              }
                              return null;
                            },
                            label: 'Task Time',
                            prefix: Icons.timelapse,
                            suffixPressed: (){},
                            onTap: (){
                              showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now()
                              ).then((value) {
                                timeController.text = (value?.format(context)).toString();
                                print(value?.format(context));
                              });
                            },
                          ),
                          SizedBox(height: 8.0,),
                          defaultFormField(
                            controller: dateController,
                            type: TextInputType.datetime,
                            validate: (value){
                              if(value!.isEmpty){
                                return 'date must not be empty';
                              }
                              return null;
                            },
                            label: 'Task Date',
                            prefix: Icons.timelapse,
                            suffixPressed: (){},
                            onTap: (){
                              showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.parse('2024-12-01')
                              ).then((value){
                                dateController.text = DateFormat().add_yMMMd().format(value!);
                                });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
            ).closed.then((value){
              isBottomSheetShown=false;
              setState((){
                fabIcon=Icons.edit;
              });
            });
            isBottomSheetShown=true;
            setState((){
              fabIcon=Icons.add;
            });
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index){
          setState((){
            currentIndex = index;
          });
        },
        items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
            ),
          label: 'Tasks',
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.check_circle_outline,
            ),
          label: 'Done',
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.archive_outlined,
            ),
          label: 'Archived',
        ),
      ],),
    );
  }

  void createDatabase() async{
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database,version) async{
        print('database created');
        await database.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)').then((value) {
          print('table created');
        }).catchError((error){
          print('Error when creating table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database).then((value) {
          setState((){
            tasks = value;
            print(tasks);
          });

        });
        print('database opened');
      },
    );
  }

  Future insertToDatabase({
    required String title,
    required String time,
    required String date,
}) async{
     return await database.transaction((txn) async{
      await txn.rawInsert('INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","status")').then((value){
        print('raw inserted');
      }).catchError((error){});
    });
  }

  Future<List<Map>> getDataFromDatabase(database) async{
     return await database.rawQuery('SELECT * FROM tasks');
  }
}
