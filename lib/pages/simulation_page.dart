
import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class SimulationPage extends StatefulWidget {
  const SimulationPage({super.key});

  @override
  State<SimulationPage> createState() => _SimulationPageState();
}

class _SimulationPageState extends State<SimulationPage> {
  final TextEditingController optionA = TextEditingController();
  final TextEditingController optionB = TextEditingController();

  double costWeight = 0.4;
  double riskWeight = 0.3;
  double timeWeight = 0.3;

  double costA = 0, costB = 0;
  double riskA = 0, riskB = 0;
  double timeA = 0, timeB = 0;

  String result = "";
  String explanation = "";

  double score(double cost, double risk, double time) {
    return (cost * costWeight) +
        (risk * riskWeight) +
        (time * timeWeight);
  }

  Future<void> simulate() async {
    final scoreA = score(costA, riskA, timeA);
    final scoreB = score(costB, riskB, timeB);

    if (scoreA < scoreB) {
      result = "Option A is recommended.";
      explanation =
          "Option A has a lower weighted score, mainly due to lower cost/risk/time impact.";
    } else {
      result = "Option B is recommended.";
      explanation =
          "Option B has a lower weighted score, mainly due to better balance across criteria.";
    }

    final history = await StorageService.load();
    history.add({
      "optionA": optionA.text,
      "optionB": optionB.text,
      "scoreA": scoreA,
      "scoreB": scoreB,
      "result": result,
      "timestamp": DateTime.now().toIso8601String(),
    });
    await StorageService.save(history);

    setState(() {});
  }

  Widget slider(String label, double value, Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Slider(
          value: value,
          min: 0,
          max: 10,
          divisions: 10,
          label: value.toString(),
          onChanged: onChanged,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Simulation")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: optionA,
              decoration: const InputDecoration(labelText: "Option A"),
            ),
            TextField(
              controller: optionB,
              decoration: const InputDecoration(labelText: "Option B"),
            ),
            const SizedBox(height: 16),

            slider("Cost (A)", costA, (v) => setState(() => costA = v)),
            slider("Risk (A)", riskA, (v) => setState(() => riskA = v)),
            slider("Time (A)", timeA, (v) => setState(() => timeA = v)),

            slider("Cost (B)", costB, (v) => setState(() => costB = v)),
            slider("Risk (B)", riskB, (v) => setState(() => riskB = v)),
            slider("Time (B)", timeB, (v) => setState(() => timeB = v)),

            const SizedBox(height: 16),
            ElevatedButton(onPressed: simulate, child: const Text("Simulate")),

            const SizedBox(height: 24),
            if (result.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(result, style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text("Why this result?"),
                  Text(explanation),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
