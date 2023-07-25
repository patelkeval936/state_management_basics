import 'package:flutter/material.dart';
import 'package:state_notifier/1_basics.dart';
import 'package:state_notifier/4_inherited_and_change_notifier.dart';
import 'package:state_notifier/6_provider_part_2.dart';
import 'package:state_notifier/7_multi_provider.dart';
import '2_inherited_widget.dart';
import '3_inherited_model.dart';
import '5_provider.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('State Management'),
            centerTitle: true,
          ),
          body : Builder(
            builder: (context) {
              return Center(
                child: Column(children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Chapter1(),
                        ));
                      },
                      child: const Text('Value Notifier')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Chapter2(),
                        ));
                      },
                      child: const Text('Inherited Widget')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Chapter3(),
                        ));
                      },
                      child: const Text('Inherited Model')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Chapter4(),
                        ));
                      },
                      child: const Text('Inherited and Change Notifier')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Chapter5(),
                        ));
                      },
                      child: const Text('Provider')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Chapter5Part2(),
                        ));
                      },
                      child: const Text('Provider Methods')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Chapter5MultiProvider(),
                        ));
                      },
                      child: const Text('Multi Provider')),
                ],),
              );
            }
          ),
        ),
      ),
    );
  }
}


