import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter ToDo',
      home: MyToDo(),
    );
  }
}

class MyToDo extends StatefulWidget {
  const MyToDo({super.key});

  @override
  State<MyToDo> createState() => _MyToDoState();
}

class _MyToDoState extends State<MyToDo> {
  final TextEditingController _controller = TextEditingController();
  final List<Widget> widgets = [];

  @override
  void initState() {
    super.initState();
  }

  void _addTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        widgets.add(buildTaskRow(_controller.text));
        _controller.clear(); // 입력 필드 초기화
      });
    }
  }

  

  Widget deleteButton() {
    return IconButton(
      onPressed: (){widgets.removeAt(2);
    }
    , icon: Icon(Icons.close));
  }

  Widget buildTaskRow(String taskText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const MyButton(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(taskText),
          ),
          deleteButton(),
        ],
      ),
    );
  }

  Widget buildInputField() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.calendar_today, size: 30.0),
          const SizedBox(width: 20),
          SizedBox(
            width: 250,
            child: TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'What is your Task?',
                labelText: 'Enter your Task',
              ),
            ),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: _addTask,
            child: const Text('Add Task'),
          ),
        ],
      ),
    );
  }

  Widget buildTaskList() {
    return Expanded(
      child: ListView.builder(
        itemCount: widgets.length,
        itemBuilder: (context, index) {
          return widgets[index];
        },
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Woomin ToDo")),
      body: Column(
        children: [
          buildInputField(),
          buildTaskList(),
        ],
      ),
    );
  }
}

class MyButton extends StatefulWidget {
  const MyButton({super.key});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool initValue = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: initValue,
      onChanged: (bool? newValue) {
        setState(() {
          initValue = newValue ?? false;
        });
      },
    );
  }
}
