import 'package:flutter/material.dart';
import '../services/shared_service.dart';
import './pages/home_page.dart';
import './pages/setting_page.dart';
import './pages/undefined.dart';

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
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.dnd_forwardslash),
            label: "Undefined",
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
        UnDefinedPage(),
        SettingPage(),
      ][currentPageIndex],
      floatingActionButton: FloatingActionButton.extended(
        elevation: 5,
          onPressed: () {},
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
