import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {},
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.only(
                top: 60,
                right: 30,
                left: 30,
                bottom: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CircleAvatar(
                    child: Icon(
                      Icons.list,
                      color: Colors.lightBlueAccent,
                      size: 30,
                    ),
                    backgroundColor: Colors.white,
                    radius: 30,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Todoey',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    '12 Tasks',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              )),
          Expanded(
            child: Container(
              child: ListView(
                padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
                children: [
                  Row(
                    children: const [
                      Expanded(
                        child: Text(
                          'Task 1',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(Icons.check_box_outline_blank),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: const [
                      Expanded(
                        child: Text(
                          'Task 1',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.check_box,
                        color: Colors.lightBlueAccent,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: const [
                      Expanded(
                        child: Text(
                          'Task 3',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.check_box,
                        color: Colors.lightBlueAccent,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
