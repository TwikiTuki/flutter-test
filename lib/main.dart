import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: Layout(),
      ),
    );
  }
}

class Layout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    Widget page = CounterPage();
    switch (appState.currentPage) {
      case 0:
        page = CounterPage();
        print("page is counter");
        break;
      case 1:
        page = ChangeNotifierProvider(create: (context) => NewEntryPageState(),
          child: NewEntryPage()
        );
        print("page is counter");
        break;
    }
    return LayoutBuilder(builder: (context, constraints) { 
      return Scaffold(
        appBar: AppBar(title: const Text('This is a test app')),
        body:
          Row(
            children: [SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 600,
                selectedIndex: appState.currentPage,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('CounterPage'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.add_box),
                    label: Text('NewEntry'),
                  ),
                ],
                onDestinationSelected: (value) {
                  print('selected: $value');
                  appState.setCurrentPage(value);
                }
              ),
            ),
            Container(child: page),
          ]),
        // Container(child: MyHomePage()),
        bottomNavigationBar: Text('This is the bottom of the app'),
      );
    });
    throw UnimplementedError();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container (
        padding: EdgeInsets.all(20),
        color: Colors.redAccent,
        width: double.infinity,
        height: double.infinity,
        child: Column( children: [
          CounterPage(),
        ]
      ),
    );
  }
}

class AppState extends ChangeNotifier {
  int clicks = 0;
  int currentPage = 0;
  var history = <String>["sdaf", "fasd", "kokow"];
  var entries = <Entry>[];

  void setCurrentPage(int page) {
    this.currentPage = page;
    notifyListeners();
  }

  void incrementClick() {
    this.clicks += 1;
    notifyListeners();
  }

  void historyAdd(String value){
    history.add(value);
    notifyListeners();
  }

  void historyRemove(String value){
    history.remove(value);
    notifyListeners();
  }

  void addEntry(Entry value){
    entries.add(value);
    notifyListeners();
  }

  void removeEntry(Entry value){
    entries.remove(value);
    notifyListeners();
  }
}

class NewEntryPageState extends ChangeNotifier {
  String name = "";
  int proteins = 0;
  int fat = 0;
  int carbohydrates = 0;

  String getName() {
    return this.name;
  }

  void setName(String value) {
    this.name = value;
    notifyListeners();
  }

  void setProteins(int value) {
    this.proteins = value;
    notifyListeners();
  }

  void setFat(int value) {
    this.fat = value;
    notifyListeners();
  }

  void setCarbohydrates(int value) {
    this.carbohydrates = value;
    notifyListeners();
  }

}

class Entry {
  String name = "";
  int proteins = 0;
  int fat = 0;
  int carbohydrates = 0;

  Entry(String name, int proteins, int fat, int carbohydrates) {
    this.name = name;
    this.proteins = proteins;
    this.fat = fat;
    this.carbohydrates = carbohydrates;
  }
}

class NewEntryPage extends StatelessWidget {
  @override 
  build(BuildContext context) {
    var pageState = context.watch<NewEntryPageState>();
    return  Column (
      children: [
        Text("sdaaaaaaaaaaaaf"),
        Text(pageState.name),
        NewEntryPageInputField(label: "NAME"),
        NewEntryPageInputField(label: "PROTEINS"),
        
      ]
    );
  }
}

class NewEntryPageInputField extends StatelessWidget {
  String label = "";

  NewEntryPageInputField({String label = ""}){
    this.label = label;
  }

  @override
  Widget build(BuildContext context){
    var pageState = context.watch<NewEntryPageState>();
    return SizedBox(
      width: 500,
      child: Container( color: Colors.green,
        padding: EdgeInsets.all(30),
        child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [ Text(label,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 10),
            SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white70,
                ),
                onSubmitted: (value) => pageState.setName(value),
              ),
            )
        ])
      ),
    );
  }
}



class CounterPage extends StatelessWidget {
  @override
  build(BuildContext context) {
    var appState = context.watch<AppState>();
    var clicks = appState.clicks;
    var elements = <Widget>[];
    final TextEditingController controller = new TextEditingController();
    for (var elem in appState.history){
      elements.add(
        Row (
          children: [
            Text(elem),
            IconButton(icon: Icon(Icons.delete), onPressed: ()=>{appState.historyRemove(elem)})
          ]
        )
      );
    }
    return 
      Align(
        alignment: Alignment.topCenter,
        child:
        Column( 
          children: [
            Column(children:  elements),
            Row (
              children: [
                Text('Hellow you clicked $clicks times'), 
                IconButton(
                  icon: Icon(Icons.arrow_circle_down_rounded),
                  onPressed: () {
                    print("clicked on increment");
                    appState.incrementClick();
                  },
                ) 
              ]
            ),
            Row (children: [SizedBox(
              width: 300,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.send),
                  counterText: "wololooo",
                  filled: true,
                  fillColor: Colors.blue,
                  hintText: "woko hint"
                ),
                onSubmitted: (String content) async {
                  appState.historyAdd(content);
                  controller.clear();
                  print("You entered $content");
                }),
              ),
            ])
          ]
        ),
      );
  }
}