import 'package:flutter/material.dart';

void main() {
  runApp(const SpikeLessApp());
}

class SpikeLessApp extends StatelessWidget {
  const SpikeLessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SpikeLess',
      theme: ThemeData(
        primaryColor: const Color(0xFF4CAF93),
        scaffoldBackgroundColor: const Color(0xFFF5FAF9),
      ),
      home: const AgeScreen(),
    );
  }
}

////////////////////////////////////////////////////////////
/// AGE SCREEN
////////////////////////////////////////////////////////////

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key});

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  double age = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            const Text(
              "Step 1 of 4",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Text(
              "How old are you?",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: Text(
                age.toInt().toString(),
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2A9D8F),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Slider(
              value: age,
              min: 10,
              max: 60,
              divisions: 50,
              activeColor: const Color(0xFF4CAF93),
              onChanged: (value) {
                setState(() {
                  age = value;
                });
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF93),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HeightScreen(age: age.toInt()),
                    ),
                  );
                },
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// HEIGHT SCREEN
////////////////////////////////////////////////////////////

class HeightScreen extends StatefulWidget {
  final int age;

  const HeightScreen({super.key, required this.age});

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  double height = 170;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            const Text(
              "Step 2 of 4",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Text(
              "Your height (cm)?",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: Text(
                "${height.toInt()} cm",
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2A9D8F),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Slider(
              value: height,
              min: 120,
              max: 220,
              divisions: 100,
              activeColor: const Color(0xFF4CAF93),
              onChanged: (value) {
                setState(() {
                  height = value;
                });
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF93),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WeightScreen(
                        age: widget.age,
                        height: height.toInt(),
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// WEIGHT SCREEN
////////////////////////////////////////////////////////////

class WeightScreen extends StatefulWidget {
  final int age;
  final int height;

  const WeightScreen({
    super.key,
    required this.age,
    required this.height,
  });

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  double weight = 65;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            const Text(
              "Step 3 of 4",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Text(
              "Your weight (kg)?",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: Text(
                "${weight.toInt()} kg",
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2A9D8F),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Slider(
              value: weight,
              min: 30,
              max: 150,
              divisions: 120,
              activeColor: const Color(0xFF4CAF93),
              onChanged: (value) {
                setState(() {
                  weight = value;
                });
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF93),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  double heightInMeters = widget.height / 100;
                  double bmi =
                      weight / (heightInMeters * heightInMeters);

                  print(
                      "Age: ${widget.age}, Height: ${widget.height}, Weight: ${weight.toInt()}, BMI: ${bmi.toStringAsFixed(1)}");
                },
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
