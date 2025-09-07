



import 'package:flutter/material.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  bool isMale = true;

  // Height inputs
  final TextEditingController feetController = TextEditingController();
  final TextEditingController inchController = TextEditingController();
  final TextEditingController cmController = TextEditingController();

  int weight = 70; // kg
  int age = 20;

  double? bmiResult;
  String resultText = "";

  double? _getHeightInMeters() {
    if (cmController.text.isNotEmpty) {
      final cm = double.tryParse(cmController.text);
      if (cm != null && cm > 0) return cm / 100;
    }

    if (feetController.text.isNotEmpty || inchController.text.isNotEmpty) {
      final feet = double.tryParse(feetController.text) ?? 0;
      final inch = double.tryParse(inchController.text) ?? 0;
      final cm = feet * 30.48 + inch * 2.54;
      if (cm > 0) return cm / 100;
    }

    return null; // no valid input
  }

  void calculateBMI() {
    final heightInMeter = _getHeightInMeters();
    if (heightInMeter == null || heightInMeter <= 0) {
      setState(() {
        bmiResult = null;
        resultText = "Enter valid height";
      });
      return;
    }

    double bmi = weight / (heightInMeter * heightInMeter);

    setState(() {
      bmiResult = bmi;
      if (bmi < 18.5) {
        resultText = "Underweight";
      } else if (bmi < 25) {
        resultText = "Normal";
      } else if (bmi < 30) {
        resultText = "Overweight";
      } else {
        resultText = "Obese";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BMI Calculator")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Gender Selection
           
            // Height Input
            const Text(
              "HEIGHT",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: feetController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Feet",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: inchController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Inches",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Center(child: Text("OR", style: TextStyle(fontSize: 16))),
            const SizedBox(height: 12),
            TextField(
              controller: cmController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Centimeters",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            // Weight & Age
            Row(
              children: [
                Expanded(
                  child: _counterCard(
                    "WEIGHT",
                    weight,
                    () {
                      setState(() => weight--);
                    },
                    () {
                      setState(() => weight++);
                    },
                  ),
                ),
                Expanded(
                  child: _counterCard(
                    "AGE",
                    age,
                    () {
                      setState(() => age--);
                    },
                    () {
                      setState(() => age++);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Calculate Button
            SizedBox(
              height: 60,
              child: ElevatedButton(
                onPressed: calculateBMI,
                child: const Text("CALCULATE", style: TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(height: 24),

            // Result
            if (bmiResult != null)
              Column(
                children: [
                  Text(
                    "Your BMI: ${bmiResult!.toStringAsFixed(1)}",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(resultText, style: const TextStyle(fontSize: 22)),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _counterCard(
    String label,
    int value,
    VoidCallback onDec,
    VoidCallback onInc,
  ) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontSize: 18)),
          Text(
            "$value",
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: onDec,
                icon: const Icon(Icons.remove_circle, size: 32),
              ),
              IconButton(
                onPressed: onInc,
                icon: const Icon(Icons.add_circle, size: 32),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
