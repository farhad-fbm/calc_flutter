import 'package:flutter/material.dart';


class Unit {
  final String name;
  final double? factor; // null for special (like Temperature)
  const Unit(this.name, {this.factor});
}

class Category {
  final String name;
  final List<Unit> units;
  const Category(this.name, this.units);
}

// Categories & Units
final categories = [
  Category("Length", [
    Unit("Meter", factor: 1.0),
    Unit("Kilometer", factor: 1000.0),
    Unit("Centimeter", factor: 0.01),
    Unit("Millimeter", factor: 0.001),
    Unit("Mile", factor: 1609.34),
    Unit("Yard", factor: 0.9144),
    Unit("Foot", factor: 0.3048),
    Unit("Inch", factor: 0.0254),
  ]),
  Category("Weight", [
    Unit("Gram", factor: 1.0),
    Unit("Kilogram", factor: 1000.0),
    Unit("Milligram", factor: 0.001),
    Unit("Pound", factor: 453.592),
    Unit("Ounce", factor: 28.3495),
  ]),
  Category("Temperature", [
    Unit("Celsius"),
    Unit("Fahrenheit"),
    Unit("Kelvin"),
  ]),
];

// Conversion logic
double convert(double value, Unit from, Unit to, {String category = ""}) {
  if (category == "Temperature") {
    return _convertTemperature(value, from.name, to.name);
  }
  if (from.factor != null && to.factor != null) {
    double baseValue = value * from.factor!;
    return baseValue / to.factor!;
  }
  throw Exception("Invalid conversion");
}

double _convertTemperature(double value, String from, String to) {
  if (from == to) return value;

  if (from == "Celsius" && to == "Fahrenheit") return value * 9 / 5 + 32;
  if (from == "Fahrenheit" && to == "Celsius") return (value - 32) * 5 / 9;

  if (from == "Celsius" && to == "Kelvin") return value + 273.15;
  if (from == "Kelvin" && to == "Celsius") return value - 273.15;

  if (from == "Fahrenheit" && to == "Kelvin") {
    return (value - 32) * 5 / 9 + 273.15;
  }
  if (from == "Kelvin" && to == "Fahrenheit") {
    return (value - 273.15) * 9 / 5 + 32;
  }

  throw Exception("Unsupported temperature conversion");
}

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  Category selectedCategory = categories.first;
  Unit? fromUnit;
  Unit? toUnit;
  double inputValue = 0.0;
  double? result;

  final TextEditingController inputController = TextEditingController();

  void _doConversion() {
    if (fromUnit == null || toUnit == null) return;
    final value = double.tryParse(inputController.text) ?? 0.0;
    setState(() {
      inputValue = value;
      result = convert(
        value,
        fromUnit!,
        toUnit!,
        category: selectedCategory.name,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Unit Converter")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Category Selector
            DropdownButton<Category>(
              value: selectedCategory,
              items: categories
                  .map(
                    (cat) =>
                        DropdownMenuItem(value: cat, child: Text(cat.name)),
                  )
                  .toList(),
              onChanged: (cat) {
                setState(() {
                  selectedCategory = cat!;
                  fromUnit = null;
                  toUnit = null;
                  result = null;
                });
              },
            ),
            const SizedBox(height: 16),

            // From unit selector
            DropdownButton<Unit>(
              value: fromUnit,
              hint: const Text("From Unit"),
              items: selectedCategory.units
                  .map((u) => DropdownMenuItem(value: u, child: Text(u.name)))
                  .toList(),
              onChanged: (u) => setState(() => fromUnit = u),
            ),
            const SizedBox(height: 16),

            // To unit selector
            DropdownButton<Unit>(
              value: toUnit,
              hint: const Text("To Unit"),
              items: selectedCategory.units
                  .map((u) => DropdownMenuItem(value: u, child: Text(u.name)))
                  .toList(),
              onChanged: (u) => setState(() => toUnit = u),
            ),
            const SizedBox(height: 16),

            // Input field
            TextField(
              controller: inputController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Enter value",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: _doConversion,
              child: const Text("Convert"),
            ),
            const SizedBox(height: 24),

            // Result display
            if (result != null)
              Text(
                "$inputValue ${fromUnit?.name} = ${result!.toStringAsFixed(3)} ${toUnit?.name}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
