import 'dart:math';
import 'package:fltr_test_app/color_history_list.dart';
import 'package:fltr_test_app/globals.dart';
import 'package:flutter/material.dart';

///This class is our main screen, where we see main changes
class HomePage extends StatefulWidget {
  ///Simple constructor with one required argument
  const HomePage({
    required this.title,
    super.key,
  });

  ///Variable that determines title in AppBar of application
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _backgroundColor = Colors.white;
  Color _textColor = Colors.black;

  final List<Color> _registeredColors = List.empty(growable: true);

  void _changeBackgroundColor() {
    _registeredColors.add(_backgroundColor);
    final Random random = Random();
    final int red = random.nextInt(256);
    final int green = random.nextInt(256);
    final int blue = random.nextInt(256);
    final Color newBackgroundColor = Color.fromRGBO(red, green, blue, 1.0);
    setState(() {
      _backgroundColor = newBackgroundColor;
      _textColor = _getTextColorFromBackgroundColor(newBackgroundColor);
    });
  }

  Color _getTextColorFromBackgroundColor(Color backgroundColor) {
    const maxColorValue = 255;

    return Color.fromRGBO(
      maxColorValue - backgroundColor.red,
      maxColorValue - backgroundColor.green,
      maxColorValue - backgroundColor.blue,
      1.0,
    );
  }

  void _getColorFromHistory(Color backgroundColor) {
    setState(() {
      _backgroundColor = backgroundColor;
      _textColor = _getTextColorFromBackgroundColor(backgroundColor);
      Navigator.pop(context);
    });
  }

  void _openHistoryOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height / bottomOverlayDividedBy,
      ),
      builder: (ctx) => ColorHistoryList(
        colorHistory: _registeredColors,
        onRemoveColor: _removeColorFromHistory,
        onGetTextColor: _getTextColorFromBackgroundColor,
        onTapHistoryColor: _getColorFromHistory,
      ),
    );
  }

  void _removeColorFromHistory(Color backgroundColor) {
    final colorIndex = _registeredColors.indexOf(backgroundColor);
    setState(() {
      _registeredColors.remove(backgroundColor);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('The color has been removed'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => setState(() {
            _registeredColors.insert(colorIndex, backgroundColor);
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GestureDetector(
        onTap: _changeBackgroundColor,
        behavior: HitTestBehavior.translucent,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: transitionDuration),
            width: double.infinity,
            height: double.infinity,
            curve: Curves.easeInOut,
            color: _backgroundColor,
            child: Center(
              child: Text(
                'Hello there',
                style: TextStyle(
                  fontSize: fontSize24,
                  fontWeight: FontWeight.bold,
                  color: _textColor, // Animated property
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openHistoryOverlay,
        tooltip: 'Open color history',
        child: const Icon(Icons.history),
      ),
    );
  }
}
