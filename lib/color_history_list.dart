import 'package:fltr_test_app/globals.dart';
import 'package:flutter/material.dart';

///This is widget where we output our color history data
class ColorHistoryList extends StatefulWidget {
  ///Constructor with named argument for better readability
  const ColorHistoryList({
    required this.colorHistory,
    required this.onRemoveColor,
    required this.onGetTextColor,
    required this.onTapHistoryColor,
    super.key,
  });

  ///List in which we contain our color data
  final List<Color> colorHistory;

  ///These functions needed to operate with List data, and save said data
  ///between different screens

  ///This function is used on Dissmisable to remove record of certain color
  ///in our history
  final void Function(Color color) onRemoveColor;

  ///This function is needed to keep clean code following DRY principle
  final Color Function(Color color) onGetTextColor;

  ///This function is used when we tap on color name in our history to change
  ///home page background color
  final void Function(Color color) onTapHistoryColor;

  @override
  State<ColorHistoryList> createState() => _ColorHistoryListState();
}

class _ColorHistoryListState extends State<ColorHistoryList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: colorHistoryListTopMargin),
        child: ListView.builder(
          itemCount: widget.colorHistory.length,
          itemBuilder: (context, index) => Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Theme.of(context).colorScheme.error,
            ),
            onDismissed: (direction) {
              widget.onRemoveColor(widget.colorHistory[index]);
            },
            child: Container(
              width: double.infinity,
              height: colorHistoryItemHeight,
              color: widget.colorHistory[index],
              margin: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 8,
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    widget.onTapHistoryColor(widget.colorHistory[index]);
                  },
                  child: Text(
                    widget.colorHistory[index].value.toString(),
                    style: TextStyle(
                      backgroundColor: widget.colorHistory[index],
                      color: widget.onGetTextColor(widget.colorHistory[index]),
                      fontSize: colorHistoryItemFontSize,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
