import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/archived_tasks/archived_tasks_screen.dart';
import 'package:flutter_app/models/done_tasks/done_tasks_screen.dart';
import 'package:flutter_app/models/new_tasks/new_tasks_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Todo App'
        ),
      ),
      body: screen[currentIndex],
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: (){},
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
}
