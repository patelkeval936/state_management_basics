import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ObjectProvider();
      },
      //hello
      child: const MaterialApp(
        home: Chapter5Part2(),
      ),
    );
  }
}

class Chapter5Part2 extends StatefulWidget {
  const Chapter5Part2({super.key});

  @override
  State<Chapter5Part2> createState() => _Chapter5Part2State();
}

class _Chapter5Part2State extends State<Chapter5Part2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider : Part 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CheapWidget(),
                )),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ExpensiveWidget(),
                ))
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Expanded(child: ObjectProviderWidget()),
            ),
            ElevatedButton(
                onPressed: () {
                  context.read<ObjectProvider>().start();
                },
                child: const Text('Start')),
            ElevatedButton(
                onPressed: () {
                  context.read<ObjectProvider>().stop();
                },
                child: const Text('Stop')),
          ],
        ),
      ),
    );
  }
}

class ExpensiveWidget extends StatelessWidget {
  const ExpensiveWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final expensiveObject = context.select<ObjectProvider, ExpensiveObject>((value) => value.expensiveObject);
    return Container(
      color: Colors.red,
      height: 200,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Expensive Widget \n\n${expensiveObject.lastUpdated}',
            style: const TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
      ),
    );
  }
}

class CheapWidget extends StatelessWidget {
  const CheapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cheapObject = context.select<ObjectProvider, CheapObject>((value) => value.cheapObject);
    return Container(
      color: Colors.blue,
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            'Cheap Widget \n\n${cheapObject.lastUpdated}',
            style: const TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
      ),
    );
  }
}

class ObjectProviderWidget extends StatelessWidget {
  const ObjectProviderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ObjectProvider>();
    return Container(
      color: Colors.orange,
      height: 200,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Object Provider  \n\n${provider.id}',
            style: const TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
      ),
    );
  }
}

class ExpensiveObject extends BaseObject {}

class CheapObject extends BaseObject {}

class ObjectProvider extends ChangeNotifier {
  late String id;
  late CheapObject _cheapObject;
  late StreamSubscription _cheapObjectStreamSubs;
  late ExpensiveObject _expensiveObject;
  late StreamSubscription _expensiveObjectStreamSubs;

  CheapObject get cheapObject => _cheapObject;
  ExpensiveObject get expensiveObject => _expensiveObject;

  void start() {
    _cheapObjectStreamSubs = Stream.periodic(const Duration(seconds: 1)).listen((event) {
      _cheapObject = CheapObject();
      notifyListeners();
    });

    _expensiveObjectStreamSubs = Stream.periodic(const Duration(seconds: 2, milliseconds: 500)).listen((event) {
      _expensiveObject = ExpensiveObject();
      notifyListeners();
    });
  }

  void stop() {
    _cheapObjectStreamSubs.cancel();
    _expensiveObjectStreamSubs.cancel();
  }

  ObjectProvider()
      : id = const Uuid().v4(),
        _cheapObject = CheapObject(),
        _expensiveObject = ExpensiveObject();

  @override
  void notifyListeners() {
    id = const Uuid().v4();
    super.notifyListeners();
  }
}

class BaseObject {
  final String id;
  final String lastUpdated;

  BaseObject()
      : id = const Uuid().v4(),
        lastUpdated = DateTime.now().toIso8601String();

  @override
  bool operator ==(covariant BaseObject other) {
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
