import 'package:flutter/material.dart';
import 'dart:math' as math;

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: ApiProvider(
          api: Api(),
          child: const Chapter2(),
      ),
    );
  }
}

class Chapter2 extends StatefulWidget {
  const Chapter2({super.key});

  @override
  State<Chapter2> createState() => _Chapter2State();
}

class _Chapter2State extends State<Chapter2> {

  ValueKey _textKey = ValueKey<String?>(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inherited Widget'),),
      body: GestureDetector(
        onTap: ()async{
          final api = ApiProvider.of(context).api;
          String? dateTime = await api.getDateAndTime();

          setState(() {
            _textKey = ValueKey(dateTime);
          });

        },
        child:  Center(child: DateTimeWidget(key: _textKey,),),
      ),
    );
  }
}

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final api = ApiProvider.of(context).api;
    return Text(api.dateTime ?? 'Tap Anywhere on Screen');
  }

}


class ApiProvider extends InheritedWidget {
  final Api api;
  final String id;

  ApiProvider({super.key, required this.api,required super.child}) : id = math.Random().nextInt(1000).toString();

  @override
  bool updateShouldNotify(covariant ApiProvider oldWidget) {
    return true;
  }

  static ApiProvider of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<ApiProvider>()!;
  }

}

class Api{
  String? dateTime;

  Future<String> getDateAndTime(){
    return Future.delayed(const Duration(seconds: 1),(){
      return DateTime.now().toIso8601String();
    }).then((value) {
      dateTime = value;
      return value;
    });
  }

}