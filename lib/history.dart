import 'package:flutter/material.dart';

class ColorHistoryList extends StatelessWidget {
  ColorHistoryList({
    super.key,
    required this.colorHistory,
    required this.onRemoveColor,
    required this.onGetTextColor,
    required this.onTapHistoryColor,
  });
  final List<Color> colorHistory;

  final void Function(Color color) onRemoveColor;
  final Color Function(Color color) onGetTextColor;
  final void Function(Color color) onTapHistoryColor;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: colorHistory.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(colorHistory[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error,
        ),
        onDismissed: (direction) {
          onRemoveColor(colorHistory[index]);
        },
        child: Container(
          width: double.infinity,
          height: 48,
          color: colorHistory[index],
          child: Center(
            child: GestureDetector(
              onTap: () {
                onTapHistoryColor(colorHistory[index]);
              },
              child: Text(
                colorHistory[index].value.toString(),
                style: TextStyle(
                    backgroundColor: colorHistory[index],
                    color: onGetTextColor(colorHistory[index]),
                    fontSize: 24),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
