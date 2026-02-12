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
            const Text("Step 1 of 4",
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 20),
            const Text("How old are you?",
                style:
                    TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            Center(
              child: Text(
                age.toInt().toString(),
                style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2A9D8F)),
              ),
            ),
            Slider(
              value: age,
              min: 10,
              max: 60,
              divisions: 50,
              activeColor: const Color(0xFF4CAF93),
              onChanged: (value) {
                setState(() => age = value);
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF93),
                    padding:
                        const EdgeInsets.symmetric(vertical: 16)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            HeightScreen(age: age.toInt())),
                  );
                },
                child: const Text("Continue",
                    style: TextStyle(fontSize: 18)),
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
            const Text("Step 2 of 4",
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 20),
            const Text("Your height (cm)?",
                style:
                    TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            Center(
              child: Text(
                "${height.toInt()} cm",
                style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2A9D8F)),
              ),
            ),
            Slider(
              value: height,
              min: 120,
              max: 220,
              divisions: 100,
              activeColor: const Color(0xFF4CAF93),
              onChanged: (value) {
                setState(() => height = value);
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF93),
                    padding:
                        const EdgeInsets.symmetric(vertical: 16)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => WeightScreen(
                              age: widget.age,
                              height: height.toInt(),
                            )),
                  );
                },
                child: const Text("Continue",
                    style: TextStyle(fontSize: 18)),
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

  const WeightScreen(
      {super.key, required this.age, required this.height});

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
            const Text("Step 3 of 4",
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 20),
            const Text("Your weight (kg)?",
                style:
                    TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            Center(
              child: Text(
                "${weight.toInt()} kg",
                style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2A9D8F)),
              ),
            ),
            Slider(
              value: weight,
              min: 30,
              max: 150,
              divisions: 120,
              activeColor: const Color(0xFF4CAF93),
              onChanged: (value) {
                setState(() => weight = value);
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF93),
                    padding:
                        const EdgeInsets.symmetric(vertical: 16)),
                onPressed: () {
                  double heightMeters = widget.height / 100;
                  double bmi =
                      weight / (heightMeters * heightMeters);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => GenderScreen(
                              age: widget.age,
                              height: widget.height,
                              weight: weight.toInt(),
                              bmi: bmi,
                            )),
                  );
                },
                child: const Text("Continue",
                    style: TextStyle(fontSize: 18)),
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
/// GENDER SCREEN
////////////////////////////////////////////////////////////

class GenderScreen extends StatefulWidget {
  final int age;
  final int height;
  final int weight;
  final double bmi;

  const GenderScreen(
      {super.key,
      required this.age,
      required this.height,
      required this.weight,
      required this.bmi});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String? selectedGender;

  Widget genderButton(String gender) {
    bool isSelected = selectedGender == gender;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => selectedGender = gender);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF4CAF93)
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF4CAF93)),
          ),
          child: Center(
            child: Text(
              gender,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? Colors.white
                      : const Color(0xFF4CAF93)),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            const Text("Step 4 of 4",
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 20),
            const Text("Select your gender",
                style:
                    TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            Row(
              children: [
                genderButton("Male"),
                genderButton("Female"),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF93),
                    padding:
                        const EdgeInsets.symmetric(vertical: 16)),
                onPressed: selectedGender == null
                    ? null
                    : () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => DashboardScreen(
                                    age: widget.age,
                                    height: widget.height,
                                    weight: widget.weight,
                                    bmi: widget.bmi,
                                    gender: selectedGender!,
                                  )),
                        );
                      },
                child: const Text("Finish",
                    style: TextStyle(fontSize: 18)),
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
/// DASHBOARD SCREEN
////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
/// DASHBOARD SCREEN
////////////////////////////////////////////////////////////

class DashboardScreen extends StatefulWidget {
  final int age;
  final int height;
  final int weight;
  final double bmi;
  final String gender;

  const DashboardScreen({
    super.key,
    required this.age,
    required this.height,
    required this.weight,
    required this.bmi,
    required this.gender,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int xp = 0;
  String insightMessage = "Log your first sugar intake today 🌿";

  void logSugar(String item) {
    setState(() {
      xp += 5;

      // Simple rule-based insight
      if (widget.bmi > 25) {
        insightMessage =
            "On higher BMI days, sugar spikes may last longer.";
      } else if (widget.age < 18) {
        insightMessage =
            "At younger ages, sugar can affect focus and mood.";
      } else {
        insightMessage =
            "Frequent sugar may reduce steady energy levels.";
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$item logged! +5 XP"),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Widget sugarButton(String label) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4CAF93),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: () => logSugar(label),
        child: Text(label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SpikeLess 🌿"),
        backgroundColor: const Color(0xFF4CAF93),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text("XP: $xp",
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Text(
              "Quick Log",
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                sugarButton("Chai"),
                const SizedBox(width: 10),
                sugarButton("Sweets"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                sugarButton("Cold Drink"),
                const SizedBox(width: 10),
                sugarButton("Snack"),
              ],
            ),

            const SizedBox(height: 40),
            const Text(
              "Insight",
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              insightMessage,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
