import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Chapter3(),
    );
  }
}

class Chapter3 extends StatefulWidget {
  const Chapter3({super.key});

  @override
  State<Chapter3> createState() => _Chapter3State();
}

class _Chapter3State extends State<Chapter3> {
  var color1 = Colors.yellow;
  var color2 = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inherited Model'),
      ),
      body: AvailableColorWidget(
          color1: color1,
          color2: color2,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          color2 = colors.getRandomElement();
                        });
                      },
                      child: const Text('Change Color 2')),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          color1 = colors.getRandomElement();
                        });
                      },
                      child: const Text('Change Color 1')),

                ],
              ),
              const ColorWidget(color: AvailableColors.one),
              const ColorWidget(color: AvailableColors.two)
            ],
          )),
    );
  }
}

enum AvailableColors { one, two }

class AvailableColorWidget extends InheritedModel<AvailableColors> {
  final MaterialColor color1;
  final MaterialColor color2;

  const AvailableColorWidget({Key? key, required this.color1, required this.color2, required Widget child}) : super(key: key, child: child);

  static AvailableColorWidget of(BuildContext context, AvailableColors aspect) {
    return InheritedModel.inheritFrom<AvailableColorWidget>(context, aspect: aspect)!;
  }

  @override
  bool updateShouldNotify(covariant AvailableColorWidget oldWidget) {
    print('update should notify');
    return color1 != oldWidget.color1 || color2 != oldWidget.color2;
  }

  @override
  bool updateShouldNotifyDependent(
    covariant AvailableColorWidget oldWidget,
    Set<AvailableColors> dependencies,
  ) {
    print('update should notify dependent');

    if (dependencies.contains(AvailableColors.one) && color1 != oldWidget.color1) {
      print('   update should notify dependent 1');
      return true;
    }

    if (dependencies.contains(AvailableColors.two) && color2 != oldWidget.color2) {
      print('   update should notify dependent 2');
      return true;
    }

    print('   update should notify dependent : none');
    return false;
  }
}

class ColorWidget extends StatelessWidget {
  final AvailableColors color;

  const ColorWidget({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    print('$color rebuilt');

    final provider = AvailableColorWidget.of(context, color);

    return Container(
      height: 100,
      color: color == AvailableColors.one ? provider.color1 : provider.color2,
    );
  }
}

final List<MaterialColor> colors = [Colors.grey, Colors.blue, Colors.green, Colors.red, Colors.purple, Colors.orange, Colors.teal, Colors.red];

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(Random().nextInt(length));
}
