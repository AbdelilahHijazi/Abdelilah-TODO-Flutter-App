import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<String> _tasks = [];
  final assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    _loadTasks();
    AssetsAudioPlayer();
    _playMusic();
  }

  @override
  void dispose() {
    assetsAudioPlayer.dispose();
    super.dispose();
  }

  void _playMusic() {
    AssetsAudioPlayer.newPlayer().open(
      Audio("assets/audios/music.mp3"),
      autoStart: true,
      showNotification: true,
    );
  }

  void _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTasks = prefs.getStringList('tasks');
    if (savedTasks != null) {
      setState(() {
        _tasks.addAll(savedTasks);
      });
    }
  }

  void _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tasks', _tasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daily Tasks Abdelilah NoteBook',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 10,
        shadowColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/images/good_morning.gif',
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(5, 20, 5, 20),
                controller: ScrollController(),
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  return ListTile(
                    title: Text(
                      task,
                      style: const TextStyle(
                        fontFamily: 'Amaranth',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Color.fromARGB(255, 247, 247, 161),
                        color: Colors.blue,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        size: 30,
                        weight: 30,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        setState(() {
                          _tasks.removeAt(index);
                          _saveTasks(); // Save tasks after removing one
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          size: 30,
          weight: 30,
        ),
        onPressed: () {
          _showAddTaskDialog(context);
        },
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String newTaskTitle = '';
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding: const EdgeInsets.all(20),
          elevation: 20,
          shadowColor: Colors.lightBlueAccent,
          title: const Text(
            'Add a Task',
            style: TextStyle(
              fontFamily: 'Amaranth',
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          content: TextField(
            style: const TextStyle(
              fontFamily: 'Amaranth',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
            maxLines: 2,
            maxLength: 60,
            autofocus: true,
            onChanged: (value) {
              newTaskTitle = value;
            },
          ),
          actions: [
            ElevatedButton(
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'Amaranth',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text(
                'Add',
                style: TextStyle(
                  fontFamily: 'Amaranth',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                if (assetsAudioPlayer.isPlaying.value == true) {
                  assetsAudioPlayer.stop();
                }
                _tasks.add(newTaskTitle);
                _saveTasks(); // Save tasks after adding one
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
