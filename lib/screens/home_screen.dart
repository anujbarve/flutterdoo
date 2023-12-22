import 'package:flutter/material.dart';
import 'package:flutterdoo/models/task.dart';
import 'package:flutterdoo/services/sql_service.dart';
import '../services/shared_service.dart';
import './pages/home_page.dart';
import './pages/setting_page.dart';
import './pages/completed.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {

    print(SharedPreferenceService.isLogin);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent.withOpacity(0.2),
        centerTitle: true,
        title: Text("FlutterDoo"),
      ),
      bottomNavigationBar: NavigationBar(
        elevation: 5,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: "All Tasks",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.check_box),
            icon: Icon(Icons.check_box_outlined),
            label: "Completed Tasks",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: "Settings",
          )
        ],
      ),
      body: [
        HomePage(),
        Completed(),
        SettingPage(),
      ][currentPageIndex],
      floatingActionButton: FloatingActionButton.extended(
        elevation: 5,
          onPressed: () {

          },
          label: Row(
            children: [
              Icon(Icons.add),
              SizedBox(width: 12,),
              Text("New Task")
            ],
          )
      ),
    );
  }
}
