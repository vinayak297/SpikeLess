import 'dart:math';
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
      home: SplashScreen(),
    );
  }
}

////////////////////////////////////////////////////////////
/// SPLASH SCREEN
////////////////////////////////////////////////////////////

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(
        const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) =>
                const AgeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(Icons.bolt,
                size: 80,
                color: Colors.green),
            SizedBox(height: 20),
            Text(
              "SpikeLess",
              style: TextStyle(
                  fontSize: 32,
                  fontWeight:
                      FontWeight.bold),
            ),
          ],
        ),
      ),
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
              onChanged: (value) =>
                  setState(() => age = value),
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
  State<HeightScreen> createState() =>
      _HeightScreenState();
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
              onChanged: (value) =>
                  setState(() => height = value),
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
  State<WeightScreen> createState() =>
      _WeightScreenState();
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
              onChanged: (value) =>
                  setState(() => weight = value),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                double bmi = weight /
                    ((widget.height / 100) *
                        (widget.height / 100));

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          HealthPermissionScreen(
                            age: widget.age,
                            height: widget.height,
                            weight: weight.toInt(),
                            bmi: bmi,
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
/// HEALTH PERMISSION
////////////////////////////////////////////////////////////

class HealthPermissionScreen extends StatelessWidget {
  final int age;
  final int height;
  final int weight;
  final double bmi;

  const HealthPermissionScreen(
      {super.key,
      required this.age,
      required this.height,
      required this.weight,
      required this.bmi});

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    int steps = 2000 + random.nextInt(7000);
    double sleep =
        4 + random.nextInt(5).toDouble();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            const Text(
              "Allow access to step & sleep data?",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight:
                      FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          DashboardScreen(
                            age: age,
                            height: height,
                            weight: weight,
                            bmi: bmi,
                            steps: steps,
                            sleepHours: sleep,
                          )),
                );
              },
              child:
                  const Text("Allow & Continue"),
            )
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// DASHBOARD
////////////////////////////////////////////////////////////

class DashboardScreen extends StatefulWidget {
  final int age;
  final int height;
  final int weight;
  final double bmi;
  final int steps;
  final double sleepHours;

  const DashboardScreen(
      {super.key,
      required this.age,
      required this.height,
      required this.weight,
      required this.bmi,
      required this.steps,
      required this.sleepHours});

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState
    extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  int xp = 0;
  int todaySugarCount = 0;
  List<int> weeklyCounts =
      List.filled(7, 0);
  int riskScore = 0;
  int dailyTarget = 2;

  String insightMessage =
      "Log your first sugar intake today 🌿";
  String correctiveAction = "";

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    loadData();

    _controller = AnimationController(
        vsync: this,
        duration:
            const Duration(milliseconds: 400),
        lowerBound: 0.9,
        upperBound: 1.1)
      ..repeat(reverse: true);
  }

  Future<void> loadData() async {
    final prefs =
        await SharedPreferences.getInstance();
    List<String> logs =
        prefs.getStringList("sugar_logs") ?? [];

    String today =
        DateTime.now().toIso8601String().split("T").first;

    todaySugarCount =
        logs.where((d) => d == today).length;

    for (int i = 0; i < 7; i++) {
      DateTime day =
          DateTime.now().subtract(
              Duration(days: i));
      String dateStr =
          day.toIso8601String().split("T").first;

      weeklyCounts[6 - i] =
          logs.where((d) => d == dateStr).length;
    }

    calculateRisk();
    setState(() {});
  }

  void calculateRisk() {
    int score = 0;

    if (widget.bmi > 25) score += 20;

    if (todaySugarCount == 1)
      score += 10;
    else if (todaySugarCount == 2)
      score += 20;
    else if (todaySugarCount >= 3)
      score += 30;

    if (todaySugarCount >
        dailyTarget) score += 15;

    int weeklyTotal =
        weeklyCounts.reduce(
            (a, b) => a + b);
    if (weeklyTotal >= 5)
      score += 20;

    if (widget.steps < 4000)
      score += 15;

    if (widget.sleepHours < 6)
      score += 15;

    if (score > 100) score = 100;

    riskScore = score;
  }

  void logSugar(String item) async {
    final prefs =
        await SharedPreferences.getInstance();
    String today =
        DateTime.now().toIso8601String().split("T").first;

    List<String> logs =
        prefs.getStringList("sugar_logs") ?? [];
    logs.add(today);
    await prefs.setStringList(
        "sugar_logs", logs);

    List<int> rewards =
        [3, 5, 7, 10];
    rewards.shuffle();
    int reward = rewards.first;

    xp += reward;

    await loadData();

    if (riskScore >= 70) {
      insightMessage =
          "High metabolic strain detected.";
    } else if (riskScore >= 40) {
      insightMessage =
          "Moderate glucose exposure.";
    } else {
      insightMessage =
          "Low immediate metabolic risk.";
    }

    correctiveAction =
        widget.steps < 4000
            ? "Take a short walk."
            : "Hydrate & balance with protein.";

    setState(() {});

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
          content: Text(
              "$item logged! +$reward XP")),
    );
  }

  Color getRiskColor() {
    if (riskScore < 30)
      return Colors.green;
    if (riskScore < 60)
      return Colors.orange;
    return Colors.red;
  }

  Widget buildBar(int value) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: value * 10.0,
            width: 18,
            color: Colors.green,
          ),
          const SizedBox(height: 4),
          Text(value.toString()),
        ],
      ),
    );
  }

  Widget sugarButton(String label) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () =>
            logSugar(label),
        child: Text(label),
      ),
    );
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("SpikeLess")),
      body: Padding(
        padding:
            const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              const Text("Risk Score",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight:
                          FontWeight.bold)),
              const SizedBox(height: 10),
              ScaleTransition(
                scale: _controller,
                child: Text(
                  "$riskScore / 100",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight:
                          FontWeight.bold,
                      color:
                          getRiskColor()),
                ),
              ),

              const SizedBox(height: 10),
              Text("Steps: ${widget.steps}"),
              Text("Sleep: ${widget.sleepHours.toStringAsFixed(1)} hrs"),
              const SizedBox(height: 10),

              Text("Today: $todaySugarCount logs"),
              Text("Daily Target: $dailyTarget logs"),
              if (todaySugarCount >
                  dailyTarget)
                const Text(
                  "⚠ You exceeded your daily target.",
                  style: TextStyle(
                      color: Colors.red),
                ),

              const SizedBox(height: 30),

              const Text("Last 7 Days",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight:
                          FontWeight.bold)),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.end,
                children: weeklyCounts
                    .map((count) =>
                        buildBar(count))
                    .toList(),
              ),

              const SizedBox(height: 30),

              const Text("Quick Log",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight:
                          FontWeight.bold)),
              const SizedBox(height: 20),
              Row(children: [
                sugarButton("Chai"),
                const SizedBox(width: 10),
                sugarButton("Sweets"),
              ]),
              const SizedBox(height: 10),
              Row(children: [
                sugarButton("Cold Drink"),
                const SizedBox(width: 10),
                sugarButton("Snack"),
              ]),

              const SizedBox(height: 30),

              Text(insightMessage),
              const SizedBox(height: 10),
              if (correctiveAction
                  .isNotEmpty)
                Text(
                  "Action: $correctiveAction",
                  style: const TextStyle(
                      fontWeight:
                          FontWeight.bold),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
