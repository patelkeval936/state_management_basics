import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Chapter5MultiProvider(),
    );
  }
}

String now() => DateTime.now().toIso8601String();

class Seconds {
  final String value;
  Seconds() : value = now();
}

class Minutes {
  final String value;
  Minutes() : value = now();
}

class Chapter5MultiProvider extends StatefulWidget {
  const Chapter5MultiProvider({super.key});

  @override
  State<Chapter5MultiProvider> createState() => _Chapter5MultiProviderState();
}

class _Chapter5MultiProviderState extends State<Chapter5MultiProvider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider : Multi Providers'),
      ),
      body: MultiProvider(
        providers: [
          StreamProvider<Seconds>.value(value: Stream.periodic(const Duration(seconds: 1), (_) => Seconds()), initialData: Seconds()),
          StreamProvider<Minutes>.value(value: Stream.periodic(const Duration(seconds: 2), (_) => Minutes()), initialData: Minutes()),
        ],
        child: const Column(
          children: [Expanded(child: SecondsWidget()), Expanded(child: MinutesWidget())],
        ),
      ),
    );
  }
}

class SecondsWidget extends StatelessWidget {
  const SecondsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final seconds = context.watch<Seconds>();
    return Container(
      color: Colors.orange,
      height: 100,
      child: Center(child: Text(seconds.value,style: TextStyle(fontSize: 20),)),
    );
  }
}

class MinutesWidget extends StatelessWidget {
  const MinutesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final minutes = context.watch<Minutes>();
    return Container(
      color: Colors.red,
      height: 100,
      child: Center(child: Text(minutes.value,style: TextStyle(fontSize: 20))),
    );
  }
}
