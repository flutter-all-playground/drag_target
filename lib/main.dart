import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drag Target',
      theme: ThemeData.dark().copyWith(
        backgroundColor: const Color.fromARGB(255, 18, 32, 74),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color caughtColor = Colors.red;
  bool _itemVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drag Target'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Draggable(
              data: Colors.orange,
              onDraggableCanceled: (velocity, offset) {},
              feedback: Container(
                height: 150,
                width: 150,
                color: Colors.orange.withOpacity(0.5),
                child: const Center(
                  child: Text(
                    'Moving..',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              childWhenDragging: Container(
                height: 100,
                width: 100,
                color: Colors.grey,
              ),
              child: Visibility(
                visible: _itemVisible,
                child: Container(
                  height: 100,
                  width: 100,
                  color: Colors.orange,
                  child: const Center(child: Text('Box')),
                ),
              ),
            ),
            DragTarget(
              onAccept: (Color data) {
                caughtColor = data;
                setState(() {
                  _itemVisible = false;
                });
              },
              onLeave: (data) {
                caughtColor = Colors.red;
                setState(() {
                  _itemVisible = true;
                });
              },
              builder: (context, acceptData, rejectedData) {
                return Container(
                  height: 200,
                  width: 200,
                  color: acceptData.isEmpty ? caughtColor : Colors.grey,
                  child: const Center(
                    child: Text('Drag Here'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
