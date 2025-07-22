import 'package:flutter/material.dart';
import 'package:helios_test/pages/algo/algo_presenter.dart';

class AlgoPage extends StatefulWidget {
  final AlgoPresenter presenter;

  const AlgoPage({super.key, required this.presenter});

  @override
  State<AlgoPage> createState() => _AlgoPageState();
}

class _AlgoPageState extends State<AlgoPage> implements AlgoDelegate {
  @override
  void initState() {
    super.initState();
    widget.presenter.init();
  }

  @override
  void dispose() {
    widget.presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.presenter.delegate = this;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Algo'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.presenter.results.length,
        itemBuilder: (context, index) {
          final result = widget.presenter.results[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Articles"),
              Text(result.input),
              const SizedBox(height: 8),
              Text("Robot actuel"),
              Text('${_format(result.naive)} ${result.naive.length} cartons ❌'),
              const SizedBox(height: 8),
              Text("Robot optimisé"),
              Text(
                '${_format(result.optimized)} ${result.optimized.length} cartons ✅',
              ),
              const SizedBox(height: 16),
              const Divider(color: Colors.grey, height: 1),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }

  String _format(List<List<int>> packing) {
    return packing.map((box) => box.join()).join('/');
  }

  @override
  void refreshView() {
    if (mounted) setState(() {});
  }
}
