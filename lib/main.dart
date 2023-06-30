import 'package:flutter/material.dart';
import 'package:todoapp/todo.model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 224, 101, 60)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Todo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController todoController = TextEditingController();

  // String inputTask = "";

  List<TodoModel> todoItems = [
    TodoModel(id: "1", title: "Learn Flutter", status: false),
    TodoModel(id: "2", title: "Built Todo", status: false),
    TodoModel(id: "3", title: "Built Todo List", status: false),
  ];

  void deleteItem(int index) {
    setState(() {
      todoItems.removeAt(index);
    });
  }

  void addNewTask(String title) {
    TodoModel newTodoTask =
        TodoModel(id: DateTime.now().toString(), status: false, title: title);

    setState(() {
      todoItems = [newTodoTask, ...todoItems];
      // todoItems.add(newTodoTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          leading: IconButton(
            onPressed: () {
              
            },
            icon: const Icon(Icons.menu),
            color: const Color.fromARGB(255, 45, 2, 2),
          )),
      body: Container(
        margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: todoController,
                    decoration: InputDecoration(
                      labelText: 'Enter your task',
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                    onPressed: () {
                      if (todoController.text != "") {
                        addNewTask(todoController.text);
                      }
                    },
                    child: const Text('Add'))
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Checkbox(
                      value: todoItems[index].status,
                      onChanged: (value) => setState(() =>
                          todoItems[index].status = !todoItems[index].status),
                    ),
                    title: Text(todoItems[index].title,
                        style: todoItems[index].status == true
                            ? const TextStyle(
                                decoration: TextDecoration.lineThrough)
                            : const TextStyle(decoration: TextDecoration.none)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        deleteItem(index);
                      },
                    ),
                  );
                },
                itemCount: todoItems.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
