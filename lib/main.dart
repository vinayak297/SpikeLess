import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const SpikeLessApp());
}

class SpikeLessApp extends StatelessWidget {
  const SpikeLessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AgeScreen(),
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
  double age = 18;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 80),
            const Text("Step 1 of 4"),
            const SizedBox(height: 20),
            const Text("Select your age",
                style:
                    TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            Text(age.toInt().toString(),
                style: const TextStyle(fontSize: 40)),
            Slider(
              min: 10,
              max: 80,
              value: age,
              onChanged: (value) {
                setState(() => age = value);
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HeightScreen(age: age.toInt())),
                );
              },
              child: const Text("Continue"),
            )
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
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 80),
            const Text("Step 2 of 4"),
            const SizedBox(height: 20),
            const Text("Select your height (cm)",
                style:
                    TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            Text(height.toInt().toString(),
                style: const TextStyle(fontSize: 40)),
            Slider(
              min: 100,
              max: 220,
              value: height,
              onChanged: (value) {
                setState(() => height = value);
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WeightScreen(
                            age: widget.age,
                            height: height.toInt(),
                          )),
                );
              },
              child: const Text("Continue"),
            )
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
  double weight = 70;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 80),
            const Text("Step 3 of 4"),
            const SizedBox(height: 20),
            const Text("Select your weight (kg)",
                style:
                    TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            Text(weight.toInt().toString(),
                style: const TextStyle(fontSize: 40)),
            Slider(
              min: 30,
              max: 150,
              value: weight,
              onChanged: (value) {
                setState(() => weight = value);
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                double bmi =
                    weight / ((widget.height / 100) * (widget.height / 100));

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GenderScreen(
                            age: widget.age,
                            height: widget.height,
                            weight: weight.toInt(),
                            bmi: bmi,
                          )),
                );
              },
              child: const Text("Continue"),
            )
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
  String gender = "Male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 80),
            const Text("Step 4 of 4"),
            const SizedBox(height: 20),
            const Text("Select your gender",
                style:
                    TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            DropdownButton<String>(
              value: gender,
              items: const [
                DropdownMenuItem(value: "Male", child: Text("Male")),
                DropdownMenuItem(value: "Female", child: Text("Female")),
              ],
              onChanged: (value) {
                setState(() => gender = value!);
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DashboardScreen(
                            age: widget.age,
                            height: widget.height,
                            weight: widget.weight,
                            bmi: widget.bmi,
                            gender: gender,
                          )),
                );
              },
              child: const Text("Finish"),
            )
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// DASHBOARD SCREEN
////////////////////////////////////////////////////////////

class DashboardScreen extends StatefulWidget {
  final int age;
  final int height;
  final int weight;
  final double bmi;
  final String gender;

  const DashboardScreen(
      {super.key,
      required this.age,
      required this.height,
      required this.weight,
      required this.bmi,
      required this.gender});

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int xp = 0;
  int streak = 0;
  String insightMessage =
      "Log your first sugar intake today 🌿";

  @override
  void initState() {
    super.initState();
    checkStreak();
  }

  Future<void> checkStreak() async {
    final prefs = await SharedPreferences.getInstance();

    String today =
        DateTime.now().toIso8601String().split("T").first;

    String? savedDate =
        prefs.getString("last_login_date");
    int savedStreak =
        prefs.getInt("streak") ?? 0;

    if (savedDate == null) {
      streak = 1;
    } else {
      DateTime lastDate =
          DateTime.parse(savedDate);
      DateTime currentDate =
          DateTime.parse(today);

      int difference =
          currentDate.difference(lastDate).inDays;

      if (difference == 1) {
        streak = savedStreak + 1;
      } else if (difference == 0) {
        streak = savedStreak;
      } else {
        streak = 1;
      }
    }

    await prefs.setString("last_login_date", today);
    await prefs.setInt("streak", streak);

    setState(() {});
  }

  void logSugar(String item) {
    setState(() {
      xp += 5;

      if (widget.bmi > 25) {
        insightMessage =
            "On higher BMI days, sugar spikes may last longer.";
      } else if (widget.age < 18) {
        insightMessage =
            "At younger ages, sugar affects focus.";
      } else {
        insightMessage =
            "Frequent sugar reduces steady energy.";
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$item logged! +5 XP"),
      ),
    );
  }

  Widget sugarButton(String label) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => logSugar(label),
        child: Text(label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SpikeLess")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text("🔥 Streak: $streak days",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("XP: $xp",
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            const Text("Quick Log",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
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
            const SizedBox(height: 30),
            const Text("Insight",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(insightMessage),
          ],
        ),
      ),
    );
  }
}
