import 'package:flutter/material.dart';
import 'models/task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Tasks',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> _tasks = [];
  final TextEditingController _inputController = TextEditingController();
  int _nextId = 1;

  @override
  void initState() {
    super.initState();
    _tasks = [
      Task(id: _nextId++, title: 'Buy groceries'),
      Task(id: _nextId++, title: 'Do homework', isDone: true),
      Task(id: _nextId++, title: 'Go for a walk'),
      Task(id: _nextId++, title: 'Read a book'),
    ];
  }

  // --- Logic ---

  void _addNewTask(String title) {
    final trimmed = title.trim();
    if (trimmed.isEmpty) return;

    setState(() {
      _tasks.add(Task(id: _nextId++, title: trimmed));
    });

    _inputController.clear();
    Navigator.pop(context);
  }

  void _markTaskDone(int id) {
    setState(() {
      final task = _tasks.firstWhere((t) => t.id == id);
      task.toggle();
    });
  }

  void _removeTask(int id) {
    setState(() {
      _tasks.removeWhere((t) => t.id == id);
    });

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Task removed'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _openAddDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('New Task'),
        content: TextField(
          controller: _inputController,
          autofocus: true,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(
            hintText: 'Enter task name...',
            border: OutlineInputBorder(),
          ),
          onSubmitted: _addNewTask,
        ),
        actions: [
          TextButton(
            onPressed: () {
              _inputController.clear();
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => _addNewTask(_inputController.text),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  // --- UI ---

  Widget _buildStatsBar() {
    final done = _tasks.where((t) => t.isDone).length;
    final total = _tasks.length;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      color: Colors.indigo.shade50,
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            color: Colors.indigo.shade400,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            '$done of $total tasks completed',
            style: TextStyle(
              fontSize: 15,
              color: Colors.indigo.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.checklist_rounded, size: 72, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No tasks yet!',
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          SizedBox(height: 6),
          Text(
            'Tap + to add your first task',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(Task task) {
    return Dismissible(
      key: Key('task_${task.id}'),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => _removeTask(task.id),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: ListTile(
          leading: Checkbox(
            value: task.isDone,
            onChanged: (_) => _markTaskDone(task.id),
          ),
          title: Text(
            task.title,
            style: TextStyle(
              fontSize: 16,
              decoration: task.isDone ? TextDecoration.lineThrough : null,
              color: task.isDone ? Colors.grey : null,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
            onPressed: () => _removeTask(task.id),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        backgroundColor: Colors.indigo.shade100,
      ),
      body: Column(
        children: [
          _buildStatsBar(),
          Expanded(
            child: _tasks.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 8, bottom: 80),
                    itemCount: _tasks.length,
                    itemBuilder: (_, index) => _buildTaskItem(_tasks[index]),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }
}
