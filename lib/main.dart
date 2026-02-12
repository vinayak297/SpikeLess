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
                style: TextStyle(
                    fontSize: 26, fontWeight: FontWeight.bold)),
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
                      builder: (_) =>
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
                style: TextStyle(
                    fontSize: 26, fontWeight: FontWeight.bold)),
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
                      builder: (_) => WeightScreen(
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
                style: TextStyle(
                    fontSize: 26, fontWeight: FontWeight.bold)),
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
                    weight / ((widget.height / 100) *
                        (widget.height / 100));

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => DashboardScreen(
                            age: widget.age,
                            height: widget.height,
                            weight: weight.toInt(),
                            bmi: bmi,
                            gender: "Male",
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
  int streak = 1;
  int todaySugarCount = 0;
  List<int> weeklyCounts = List.filled(7, 0);

  String insightMessage =
      "Log your first sugar intake today 🌿";
  String correctiveAction = "";

  @override
  void initState() {
    super.initState();
    loadTodayCount();
    loadWeeklyData();
  }

  Future<void> loadTodayCount() async {
    final prefs = await SharedPreferences.getInstance();
    String today =
        DateTime.now().toIso8601String().split("T").first;

    List<String> logs =
        prefs.getStringList("sugar_logs") ?? [];

    int count =
        logs.where((d) => d == today).length;

    setState(() {
      todaySugarCount = count;
    });
  }

  Future<void> loadWeeklyData() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> logs =
        prefs.getStringList("sugar_logs") ?? [];

    List<int> counts = List.filled(7, 0);

    for (int i = 0; i < 7; i++) {
      DateTime day =
          DateTime.now().subtract(Duration(days: i));
      String dateStr =
          day.toIso8601String().split("T").first;

      counts[6 - i] =
          logs.where((d) => d == dateStr).length;
    }

    setState(() {
      weeklyCounts = counts;
    });
  }

  void logSugar(String item) async {
    final prefs = await SharedPreferences.getInstance();

    String today =
        DateTime.now().toIso8601String().split("T").first;

    List<String> logs =
        prefs.getStringList("sugar_logs") ?? [];

    logs.add(today);
    await prefs.setStringList("sugar_logs", logs);

    List<int> rewards = [3, 5, 7, 10];
    rewards.shuffle();
    int randomReward = rewards.first;

    String action;

    if (widget.bmi > 25 && todaySugarCount >= 2) {
      action = "Take a 10-minute brisk walk now.";
    } else if (todaySugarCount >= 3) {
      action = "Drink 2 glasses of water immediately.";
    } else {
      action =
          "Have a protein snack to balance sugar spike.";
    }

    setState(() {
      xp += randomReward;
      correctiveAction = action;

      if (widget.bmi > 25) {
        insightMessage =
            "Higher BMI may prolong glucose spikes.";
      } else {
        insightMessage =
            "Frequent sugar reduces steady energy.";
      }
    });

    await loadTodayCount();
    await loadWeeklyData();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text("$item logged! +$randomReward XP"),
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

  Widget buildBar(int value) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: value * 10.0,
            width: 20,
            color: Colors.green,
          ),
          const SizedBox(height: 4),
          Text(value.toString()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SpikeLess")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text("🔥 Streak: $streak days",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text("XP: $xp",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text("Today: $todaySugarCount logs"),
              const SizedBox(height: 30),

              const Text("Last 7 Days",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.end,
                children: weeklyCounts
                    .map((count) => buildBar(count))
                    .toList(),
              ),

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

              const SizedBox(height: 10),
              if (correctiveAction.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius:
                        BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Action: $correctiveAction",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
