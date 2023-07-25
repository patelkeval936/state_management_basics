import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Chapter4(),
    );
  }
}

final sliderData = SliderData();

class SliderInheritedNotifier extends InheritedNotifier<SliderData> {
  SliderInheritedNotifier({
    Key? key,
    required SliderData sliderData,
    required Widget child}) : super(
      key: key,
      notifier: sliderData,
      child: child);

  static double of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SliderInheritedNotifier>()?.
    notifier?._value ?? 0.0;
  }
}

class Chapter4 extends StatelessWidget {
  const Chapter4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifiers'),
      ),
      body: SliderInheritedNotifier(
        sliderData: sliderData,
        child: Builder(builder: (context) {
          return Column(
            children: [
              Slider(
                value: SliderInheritedNotifier.of(context),
                onChanged: (value) {
                    sliderData.value = value;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: Opacity(
                      opacity: SliderInheritedNotifier.of(context),
                      child: Container(
                        color: Colors.yellow,
                        height: 100,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Opacity(
                      opacity: sliderData._value,
                      child: Container(
                        color: Colors.blue,
                        height: 100,
                      ),
                    ),
                  )
                ],
              )
            ],
          );
        }),
      ),
    );
  }
}

class SliderData extends ChangeNotifier {
  double _value = 0.0;
  double get value => _value;
  set value(double newValue) {
    _value = newValue;
    notifyListeners();
  }
}
