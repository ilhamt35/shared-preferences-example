import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;
  ThemeData themeData() => (isDark) ? ThemeData.dark() : ThemeData();

  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', isDark);
  }

  Future<bool> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDark') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Shared Preferences'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Switch(
                  value: isDark,
                  onChanged: (value) {
                    setState(() {
                      isDark = value;
                    });
                  }),
              ElevatedButton(
                  onPressed: () {
                    saveData();
                  },
                  child: Text('Save')),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      loadData().then((value) {
                        isDark = value;
                      });
                    });
                  },
                  child: Text('Load'))
            ],
          ),
        ),
      ),
    );
  }
}
