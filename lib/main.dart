import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';


Future<UserCredential?> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser =
      await GoogleSignIn().signIn();

  if (googleUser == null) return null;

  final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  return await FirebaseAuth.instance
      .signInWithCredential(credential);
}





Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool show1 = false;
  bool show2 = false;
  bool show3 = false;
  bool show4 = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() => show1 = true);
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() => show2 = true);
    });

    Future.delayed(const Duration(milliseconds: 900), () {
      setState(() => show3 = true);
    });

    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() => show4 = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Center(
              child: Icon(
                Icons.bolt,
                size: 70,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 40),

            const Text(
              "Get the full SpikeLess experience",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 30),

            AnimatedOpacity(
              opacity: show1 ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: BenefitRow(
                text: "Sync your data across devices",
              ),
            ),

            const SizedBox(height: 12),

            AnimatedOpacity(
              opacity: show2 ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: BenefitRow(
                text: "Save and track your progress",
              ),
            ),

            const SizedBox(height: 12),

            AnimatedOpacity(
              opacity: show3 ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: BenefitRow(
                text: "Access AI-powered insights",
              ),
            ),

            const SizedBox(height: 12),

            AnimatedOpacity(
  opacity: show1 ? 1 : 0,
  duration: const Duration(milliseconds: 500),
  child: BenefitRow(
    text: "Sync your data across devices",
  ),
),


            const SizedBox(height: 50),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  final user = await signInWithGoogle();
                  if (user != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AgeScreen(),
                      ),
                    );
                  }
                },
                child: const Text(
                  "Sign in with Google",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 18),

            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AgeScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Continue as Guest",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





class _SplashScreenState
    extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => const AuthScreen(),
    ),
  );
});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      fontWeight: FontWeight.bold,
    ),
  ),

  SizedBox(height: 30),   // add spacing

  
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
              // Inside HeightScreen onPressed
onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => GenderScreen(
        age: widget.age,         // Added name label
        height: height.toInt(),  // Added name label
      ),
    ),
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

  const WeightScreen({super.key, required this.age, required this.height});

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
            const Text(
              "Select your weight (kg)",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            Text(weight.toInt().toString(), style: const TextStyle(fontSize: 40)),
            Slider(
              min: 30,
              max: 150,
              value: weight,
              onChanged: (value) => setState(() => weight = value),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
  // 1. Calculate BMI
  double heightInMeters = widget.height / 100;
  double bmi = weight / (heightInMeters * heightInMeters);

  // 2. Navigate to Permission Screen
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => HealthPermissionScreen( // FIXED: Corrected class name
        age: widget.age,
        height: widget.height,
        weight: weight.toInt(),
        bmi: bmi,
      ),
    ),
  );
},
                child: const Text(
                  "Finish",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
//////GENDER PERMISSION////
class GenderScreen extends StatefulWidget {
  final int age;
  final int height;

  const GenderScreen({super.key, required this.age, required this.height});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String selectedGender = "Male";

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
            const Text("Select Gender", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _genderTile("Male", Icons.male, Colors.blue),
                const SizedBox(width: 20),
                _genderTile("Female", Icons.female, Colors.pink),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (_) => WeightScreen(age: widget.age, height: widget.height))
                ),
                child: const Text("Next"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _genderTile(String gender, IconData icon, Color color) {
    bool isSelected = selectedGender == gender;
    return GestureDetector(
      onTap: () => setState(() => selectedGender = gender),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.grey[100],
          border: Border.all(color: isSelected ? color : Colors.transparent, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Icon(icon, size: 50, color: isSelected ? color : Colors.grey),
            Text(gender, style: TextStyle(color: isSelected ? color : Colors.black)),
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

  const HealthPermissionScreen({
    super.key,
    required this.age,
    required this.height,
    required this.weight,
    required this.bmi,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.health_and_safety, size: 80, color: Colors.green),
            const SizedBox(height: 30),
            const Text(
              "Sync Health Data",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              "SpikeLess uses your step and sleep data to calculate your metabolic risk score more accurately.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () async {
                  // 1. Request Activity Recognition
                  var activityPermission = await Permission.activityRecognition.request();
                  if (!activityPermission.isGranted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Activity permission is required for steps.")),
                    );
                    return;
                  }

                  final health = Health();

                  // 2. Handle Health Connect Status (FIXED NULL SAFETY)
                  var status = await health.getHealthConnectSdkStatus();
                  
                  // If status is null or not available, prompt install
                  if (status == null || status != HealthConnectSdkStatus.sdkAvailable) {
                    await health.installHealthConnect();
                    return;
                  }

                  // 3. Request Authorization
                  final types = [
                    HealthDataType.STEPS,
                    HealthDataType.SLEEP_ASLEEP,
                  ];

                  try {
                    bool granted = await health.requestAuthorization(types);
                    if (granted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DashboardScreen(
                            age: age,
                            height: height,
                            weight: weight,
                            bmi: bmi,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Health access was denied.")),
                      );
                    }
                  } catch (e) {
                    debugPrint("Health Auth Error: $e");
                  }
                },
                child: const Text(
                  "Allow & Continue",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
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

  const DashboardScreen(
      {super.key,
      required this.age,
      required this.height,
      required this.weight,
      required this.bmi,});

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState
    extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {

  final Health health = Health();

  int todaySteps = 0;
  double sleepHours = 0;


  int xp = 0;
  int todaySugarCount = 0;
  List<int> weeklyCounts =
      List.filled(7, 0);
  int riskScore = 0;
  int dailyTarget = 2;
  Map<String, List<String>> categories = {
    
  "🥤 Drinks & Beverages": [
    "Tea (Chai)",
    "Coffee (Sugar)",
    "Cold Drink",
    "Energy Drink",
    "Fruit Juice",
    "Milkshake",
    "Sweet Lassi",
    "Iced Tea"
  ],
  "🍪 Snack Items": [
    "Biscuits",
    "Cookies",
    "Cake Slice",
    "Pastry",
    "Chocolate Bar",
    "Candy",
    "Donut",
    "Ice Cream"
  ],
  "🍛 Meals (Hidden Sugar)": [
    "White Bread",
    "White Rice",
    "Noodles",
    "Burger",
    "Pizza",
    "Sandwich",
    "Fast Food Combo"
  ],
  "🧃 Healthy Alternatives": [
    "Green Tea",
    "Black Coffee",
    "Nuts",
    "Fruit (Whole)",
    "Boiled Eggs",
    "Salad",
    "Unsweetened Yogurt"
  ],
};
@override
void dispose() {
  _controller?.dispose();
  super.dispose();
}
Future<void> loadHealthData() async {
  int steps = await fetchTodaySteps();
  double sleep = await fetchSleepHours();

  setState(() {
    todaySteps = steps;
    sleepHours = sleep;
  });
}

Future<int> fetchTodaySteps() async {
  final types = [HealthDataType.STEPS];

  bool requested = await health.requestAuthorization(types);
  if (!requested) return 0;

  DateTime now = DateTime.now();
  DateTime start = DateTime(now.year, now.month, now.day);

  List<HealthDataPoint> healthData =
      await health.getHealthDataFromTypes(
    types: types,
    startTime: start,
    endTime: now,
  );

  int steps = healthData.fold(
      0,
      (sum, item) =>
          sum + (item.value as NumericHealthValue).numericValue.toInt());

  return steps;
}






 
Future<double> fetchSleepHours() async {
  final types = [HealthDataType.SLEEP_ASLEEP];

  bool requested = await health.requestAuthorization(types);
  if (!requested) return 0;

  DateTime now = DateTime.now();
  DateTime start = now.subtract(const Duration(days: 1));

  List<HealthDataPoint> sleepData =
      await health.getHealthDataFromTypes(
  types: types,
  startTime: start,
  endTime: now,
);


  double hours = sleepData.fold(
      0,
      (sum, item) =>
          sum + (item.value as NumericHealthValue)
              .numericValue);

  return hours;
}



  String insightMessage =
      "Log your first sugar intake today 🌿";
  String correctiveAction = "";

  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    loadHealthData();

    _controller = AnimationController(
  vsync: this,
  duration: const Duration(milliseconds: 400),
  lowerBound: 0.9,
  upperBound: 1.1,
);

_controller!.repeat(reverse: true);

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

    if (todaySteps < 4000)
      score += 15;

    if (sleepHours < 6)
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

    int reward;

if (item.contains("Green Tea") ||
    item.contains("Nuts") ||
    item.contains("Fruit") ||
    item.contains("Salad") ||
    item.contains("Unsweetened")) {
  reward = 15; // Healthy choice bonus
} else if (item.contains("Cold Drink") ||
           item.contains("Energy Drink") ||
           item.contains("Cake") ||
           item.contains("Donut") ||
           item.contains("Candy")) {
  reward = 3; // High sugar item
} else {
  reward = 7; // Moderate sugar
}

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
        todaySteps < 4000
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
              _controller == null
  ? const SizedBox()
  : ScaleTransition(
      scale: _controller!,

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
              Text("Steps: $todaySteps"),
              Text("Sleep: ${sleepHours.toStringAsFixed(1)} hrs"),

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
              ...categories.entries.map((entry) {
  return ExpansionTile(
    title: Text(
      entry.key,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    children: entry.value.map((item) {
      return ListTile(
        title: Text(item),
        onTap: () => logSugar(item),
      );
    }).toList(),
  );
}).toList(),


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
class BenefitRow extends StatelessWidget {
  final String text;

  const BenefitRow({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.check_circle,
          size: 18,
          color: Colors.green,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
