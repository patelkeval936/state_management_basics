import 'package:flutter/material.dart';
import 'dart:math' as math;

class Contact {
  final String id;
  final String name;

  Contact(this.name) : id = math.Random().nextInt(1000).toString();
}

class ContactBook extends ValueNotifier<List<Contact>> {

  ContactBook._sharedInstance() : super([]);

  static final ContactBook _shared = ContactBook._sharedInstance();

  factory ContactBook() => _shared;

  int get length => value.length;

  void add({required Contact contact}) {
    List<Contact> l = new List.from(value);
    l.add(contact);
    value = l;
  }

  void remove({required Contact contact}) {
    value.remove(contact);
    notifyListeners();
  }

  Contact? contact({required int index}) {
    return value.length > index ? value[index] : null;
  }
}

class Chapter1 extends StatefulWidget {
  const Chapter1({super.key});

  @override
  State<Chapter1> createState() => _Chapter1State();
}

class _Chapter1State extends State<Chapter1> {
  final contactBook = ContactBook();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: ValueListenableBuilder(
        valueListenable: contactBook,
        builder: (context, value, child) {
          print(value);
          List l = value;
          return ListView.builder(
            itemCount: l.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: ValueKey(l[index].id), 
                onDismissed: (direction) {
                  l.remove(l[index]);
                },
                child : ListTile(
                  title: Text(l[index].name),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NewContactScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NewContactScreen extends StatefulWidget {
  const NewContactScreen({super.key});

  @override
  State<NewContactScreen> createState() => _NewContactScreenState();
}

class _NewContactScreenState extends State<NewContactScreen> {
  TextEditingController controller = TextEditingController(text: 'name : ');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Contact'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextField(
              autofocus: true,
              controller: controller,
              decoration: InputDecoration(hintText: 'type something...'),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                final contact = Contact(controller.text);
                ContactBook().add(contact: contact);
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
          )
        ],
      ),
    );
  }
}
