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
    return const MaterialApp(
      home: Chapter5(),
    );
  }
}

class Chapter5 extends StatefulWidget {
  const Chapter5({super.key});

  @override
  State<Chapter5> createState() => _Chapter5State();
}

class _Chapter5State extends State<Chapter5> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return BreadCrumbProvider();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Provider'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Consumer<BreadCrumbProvider>(
                builder: (context, value, child) {
                return BreadCrumbWidget(breadCrumbs: value.items);
              },),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const NewBreadCrumb(),
                    ));
                  },
                  child: const Text('Add New Bread Crumb')),
              ElevatedButton(
                  onPressed: () {
                    context.read<BreadCrumbProvider>().reset();
                  },
                  child: const Text('Reset')),
            ],
          ),
        ),
      ),
    );
  }
}



class NewBreadCrumb extends StatefulWidget {
  const NewBreadCrumb({super.key});

  @override
  State<NewBreadCrumb> createState() => _NewBreadCrumbState();
}

class _NewBreadCrumbState extends State<NewBreadCrumb> {
  TextEditingController controller = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    // var value = context.watch<BreadCrumbProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Bread Crum'),
      ),
      body: Column(
        children: [
          // Text('${value._items}'),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextField(
              autofocus: true,
              controller: controller,
              decoration: const InputDecoration(hintText: 'type something...'),
            ),
          ),
          ElevatedButton(
            onPressed: () {

              context.read<BreadCrumbProvider>().add(BreadCrumb(false, controller.text));
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          )
        ],
      ),
    );
  }
}

class BreadCrumbWidget extends StatelessWidget {
  final List<BreadCrumb> breadCrumbs;
  const BreadCrumbWidget({super.key, required this.breadCrumbs});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ...breadCrumbs
            .map((e) => Text(
                  e.title,
                  style: TextStyle(color: e.isActive ? Colors.blue : Colors.black),
                ))
            .toList()
      ],
    );
  }
}

class BreadCrumb {
  bool isActive;
  final String name;
  final String uuid;

  void activate() {
    isActive = true;
  }

  String get title => name + (isActive ? ' > ' : '');

  @override
  bool operator ==(covariant BreadCrumb other) {
    return uuid == other.uuid;
  }

  BreadCrumb(this.isActive, this.name) : uuid = const Uuid().v4();

  @override
  int get hashCode => uuid.hashCode;
}

class BreadCrumbProvider extends ChangeNotifier {
  final List<BreadCrumb> _items = [];
  get items => _items;

  void add(BreadCrumb breadCrumb) {
    for (final item in _items) {
      item.activate();
    }
    _items.add(breadCrumb);
    notifyListeners();
  }

  void reset() {
    _items.clear();
    notifyListeners();
  }
}
