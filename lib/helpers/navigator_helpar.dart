import 'package:calculator_flutter/screens/bmi_calc_screen.dart';
import 'package:calculator_flutter/screens/calculator_screen.dart';
import 'package:calculator_flutter/screens/unit_converter_screen.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavExampleState();
}

class _BottomNavExampleState extends State<BottomNav> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Center(child: CalculatorScreen()),
    Center(child: ConverterScreen()),
    Center(child: BMIScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Calculate And More")),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: "Calc"),
          BottomNavigationBarItem(
            icon: Icon(Icons.change_circle),
            label: "Conert",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.health_and_safety),
            label: "BMI",
          ),
        ],
      ),
    );
  }
}
