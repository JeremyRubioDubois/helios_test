abstract class AlgoDelegate {
  void refreshView();
}

class AlgoTestResult {
  final String input;
  final List<List<int>> naive;
  final List<List<int>> optimized;

  AlgoTestResult({
    required this.input,
    required this.naive,
    required this.optimized,
  });
}

class AlgoPresenter {
  AlgoDelegate? delegate;

  final List<String> testInputs = [
    "163841689525773",
    "915372648192837",
    "374829156738291",
    "889977665544332211",
    "195384726182736",
    "561378942315789",
    "123789456987123",
    "987612345981276",
  ];

  final List<AlgoTestResult> results = [];

  void init() {
    runPacking();
  }

  void dispose() {}

  void runPacking() {
    results.clear();

    for (final input in testInputs) {
      final items = input.split('').map(int.parse).toList();

      List<List<int>> naive = [];
      List<int> currentBox = [];
      for (final item in items) {
        final currentSum = currentBox.fold(0, (sum, e) => sum + e);
        if (currentSum + item > 10) {
          naive.add(currentBox);
          currentBox = [item];
        } else {
          currentBox.add(item);
        }
      }
      if (currentBox.isNotEmpty) naive.add(currentBox);

      List<List<int>> optimized = [];
      final sortedItems = List<int>.from(items)..sort((a, b) => b - a);
      for (final item in sortedItems) {
        bool placed = false;
        for (final box in optimized) {
          final boxSum = box.fold(0, (sum, e) => sum + e);
          if (boxSum + item <= 10) {
            box.add(item);
            placed = true;
            break;
          }
        }
        if (!placed) optimized.add([item]);
      }

      results.add(
        AlgoTestResult(input: input, naive: naive, optimized: optimized),
      );
    }

    delegate?.refreshView();
  }
}
