
import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>> history = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    final data = await StorageService.load();
    setState(() => history = data.reversed.toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Decision History")),
      body: history.isEmpty
          ? const Center(child: Text("No decisions yet"))
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (_, i) {
                final h = history[i];
                return ListTile(
                  title: Text(h["result"]),
                  subtitle: Text(
                    "A: ${h["optionA"]} | B: ${h["optionB"]}\n"
                    "Scores → A: ${h["scoreA"].toStringAsFixed(2)}, "
                    "B: ${h["scoreB"].toStringAsFixed(2)}",
                  ),
                );
              },
            ),
    );
  }
}
