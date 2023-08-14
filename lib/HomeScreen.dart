// ignore_for_file: file_names

import 'package:cpssoft_test/screens/user_add.dart';
import 'package:flutter/material.dart';

import 'screens/user_list.dart';
// import 'package:giffy_dialog/giffy_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required int selectedIndex});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  var deliveryList = [];
  bool isValid = false;

  get bottomNavigationBar => null;

  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const UserList(),
    const UserAdd(),
  ];

  void _onItemTapped(int index) {
    // globals.deliveryPage = index;
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Delivery List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt),
            label: 'Add User',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[700],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
