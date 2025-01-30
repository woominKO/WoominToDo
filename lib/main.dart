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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Woomin ToDo")),
      body: Column(
        children: [
          buildInputField(),
          buildTaskList(widgets: widgets),
        ],
      ),
    );
  }
}

class buildTaskList extends StatefulWidget {
  const buildTaskList({
    super.key,
    required this.widgets,
  });

  final List<Widget> widgets;

  @override
  State<buildTaskList> createState() => _buildTaskListState();
}

class _buildTaskListState extends State<buildTaskList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.widgets.length,
        itemBuilder: (context, index) {
          // return widgets[index];
          return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.widgets[index],
                  IconButton(
                    onPressed: () {
                      setState(() { //setstate쓰니까 잘 작동함, 안쓸때는  RangeError: Value not in range: 1 라고 떴음, 따로 때서 stateful widget으로 만들었더니 작동했음
                        widget.widgets.removeAt(index);
                      });
                    
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              );
        },
    )
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
