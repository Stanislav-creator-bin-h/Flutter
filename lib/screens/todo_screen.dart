import 'package:flutter/material.dart';
import '../model/todo_item.dart';
import '../services/storage_service.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final StorageService _storage = StorageService();

  List<TodoItem> _todos = [];

  final TextEditingController _textController = TextEditingController();

  bool _isDarkMode = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    final todos = await _storage.loadTodos();
    final isDarkMode = _storage.loadThemeMode();

    setState(() {
      _todos = todos;
      _isDarkMode = isDarkMode;
      _isLoading = false;
    });
  }

  Future<void> _saveData() async {
    await _storage.saveTodos(_todos);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Збережено успішно'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  void _addTodo() {
    if (_textController.text.trim().isEmpty) return;

    final newTodo = TodoItem(
      id: DateTime.now().toString(),
      title: _textController.text.trim(),
      isCompleted: false,
      createdAt: DateTime.now(),
    );

    setState(() {
      _todos.add(newTodo);
    });

    _textController.clear();
    _saveData();
  }

  void _toggleTodo(TodoItem todo) {
    setState(() {
      final index = _todos.indexWhere((t) => t.id == todo.id);

      if (index != -1) {
        _todos[index] = todo.copyWith(isCompleted: !todo.isCompleted);
      }
    });
    _saveData();
  }

  void _deleteTodo(TodoItem todo) {
    setState(() {
      _todos.removeWhere((t) => t.id == todo.id);
    });
    _saveData();
  }

  void _clearCompleted() {
    setState(() {
      _todos.removeWhere((todo) => todo.isCompleted);
    });
    _saveData();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Мій Todo List')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          decoration: const InputDecoration(
                            hintText: 'Додати нове завдання...',
                            border: OutlineInputBorder(),
                          ),
                          onSubmitted: (_) => _addTodo(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton.filled(
                        icon: const Icon(Icons.add),
                        onPressed: _addTodo,
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '📋 Завдання (${_todos.length})',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                Expanded(
                  child: _todos.isEmpty ? _buildEmptyState() : _buildTodoList(),
                ),

                _buildFooter(),
              ],
            ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.task_alt, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Ще немає завдань!',
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Text(
            'Додай своє перше завдання вище',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: _todos.length,
      itemBuilder: (context, index) {
        final todo = _todos[index];

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ListTile(
            leading: Checkbox(
              value: todo.isCompleted,
              onChanged: (_) => _toggleTodo(todo),
            ),
            title: Text(
              todo.title,
              style: TextStyle(
                decoration: todo.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteTodo(todo),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFooter() {
    final completedCount = _todos.where((t) => t.isCompleted).length;
    final lastSaveTime = _storage.getLastSaveTime();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('✅ Виконано: $completedCount/${_todos.length}'),
              if (lastSaveTime != null)
                Text(
                  '💾 Збережено: $lastSaveTime',
                  style: const TextStyle(fontSize: 12),
                ),
            ],
          ),
          if (completedCount > 0) ...[
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _clearCompleted,
                child: const Text('Очистити виконані'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
