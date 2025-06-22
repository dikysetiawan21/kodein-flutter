import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'add_task_page.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          // Header biru
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10,
              left: 20,
              right: 20,
              bottom: 24,
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Tasks",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    Material(
                      color: Colors.blue.shade100,
                      shape: const CircleBorder(),
                      child: IconButton(
                        icon: const Icon(Icons.search, color: Colors.white, size: 28),
                        onPressed: () {},
                        tooltip: 'Cari Tugas',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Daftar tugas dari Hive
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: Hive.box('tasks').listenable(),
              builder: (context, Box box, _) {
                final tasks = box.values.toList();
                if (tasks.isEmpty) {
                  return Center(
                    child: Text(
                      "Belum ada tugas.",
                      style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  itemCount: tasks.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: (task['done'] as bool) ? Colors.green : Colors.orange,
                          child: Icon(
                            (task['done'] as bool) ? Icons.check : Icons.pending,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          task['title'] ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: (task['done'] as bool) ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        subtitle: Text(
                          task['desc'] ?? '',
                          style: TextStyle(
                            color: Colors.grey[700],
                            decoration: (task['done'] as bool) ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () {
                            box.deleteAt(index);
                          },
                        ),
                        onTap: () {},
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskPage()),
          );
        },
        backgroundColor: Colors.blue,
        tooltip: 'Tambah Task',
        elevation: 4,
        child: const Icon(Icons.add, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
