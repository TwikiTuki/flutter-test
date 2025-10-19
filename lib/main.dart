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
        print("page is New Entry Page");
        break;
      case 2:
          page = EntriesList();
        print("Entries List");
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
                    label: Text('Counter Page'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.add_box),
                    label: Text('New Entry'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.add_box),
                    label: Text('Etnries List'),
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

  List<Entry> getEntries() {
    return this.entries;
  }

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

  String toString(){
    return "name: $name proteins: $proteins fat: $fat carbohydrates: $carbohydrates";
  }
}

class NewEntryPage extends StatelessWidget {
  final nameTextConroller = new TextEditingController();
  final proteinsTextConroller = new TextEditingController();
  final fatTextConroller = new TextEditingController();
  final carbohydratesTextConroller = new TextEditingController();
  @override 
  build(BuildContext context) {
    var pageState = context.watch<NewEntryPageState>();
    var appState = context.watch<AppState>();
    void onAddButtonPressed() {
      var entry = new Entry(
        pageState.name, 
        pageState.proteins, 
        pageState.fat, 
        pageState.carbohydrates, 
      );
      pageState.name = "";
      pageState.proteins = 0;
      pageState.fat = 0;
      pageState.carbohydrates = 0;
      print(entry.toString());
      appState.addEntry(entry);

      nameTextConroller.clear();
      proteinsTextConroller.clear();
      fatTextConroller.clear();
      carbohydratesTextConroller.clear();
    };
    return  Column (
      children: [
        NewEntryPageInputField(label: "NAME", onChange: (value)=>{pageState.setName(value)}, controller: this.nameTextConroller ,),
        NewEntryPageInputField(label: "PROTEINS", onChange: (value)=>{pageState.setProteins(int.tryParse(value) ?? 0)}, controller:  this.proteinsTextConroller,),
        NewEntryPageInputField(label: "FAT", onChange: (value)=>{pageState.setFat(int.tryParse(value) ?? 0)}, controller:  this.fatTextConroller,),
        NewEntryPageInputField(label: "CARBOHYDRATES", onChange: (value)=>{pageState.setCarbohydrates(int.tryParse(value) ?? 0)}, controller:  this.carbohydratesTextConroller,),
        
          SizedBox( width:500, 
          child:Container( color: Colors.orangeAccent, 
            padding: EdgeInsets.all(30),
            child: Align( alignment: Alignment.centerRight,
              child: FloatingActionButton(onPressed: onAddButtonPressed,
                child: Icon(Icons.add), 
              ),
            )
          ),
        ),
      ]
    );
  }
}

class NewEntryPageInputField extends StatelessWidget {
  String label = "";
  void Function(Object) onChange = (val)=>();
  TextEditingController? controller;

  static void dummyFunc(){}

  NewEntryPageInputField({String label = "", onChange, controller}){
    if (controller == null) {
      throw Exception("wololooo");
    }
    this.label = label;
    this.onChange = onChange;
    this.controller = controller;
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
                onSubmitted:  onChange, //(value) => pageState.setName(value),
                onChanged:  onChange, //(value) => pageState.setName(value),
                controller: controller,
              ),
            )
        ])
      ),
    );
  }
}

class EntriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    var entries = <Widget>[];
    appState.addEntry(new Entry("fasd", 9, 9, 9));

    for (Entry entry in appState.getEntries()) {
      entries.add(Row(children: [
        Text("name: "),
        Text(entry.name),
        SizedBox(width: 10),
        Text("protein: "),
        Text(entry.proteins.toString()),
        SizedBox(width: 10),
        Text("protein: "),
        Text("fat: "),
        Text(entry.fat.toString()),
        SizedBox(width: 10),
        Text("protein: "),
        Text("carbohidrates: "),
        Text(entry.carbohydrates.toString()),
      ],));
    }
    return Column(
      children: entries,
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