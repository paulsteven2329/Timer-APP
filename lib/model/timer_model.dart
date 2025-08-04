// Import necessary packages
import 'dart:async';
import 'package:flutter/material.dart';

// TimerModel: Manages timer state and history, using Provider for updates
class TimerModel extends ChangeNotifier {
  // Timer properties
  int _duration = 60000; // Total duration in milliseconds (default 60 seconds)
  int _remainingTime = 60000; // Current remaining time in milliseconds
  bool _isRunning = false; // Tracks if timer is running
  Timer? _timer; // Periodic timer for countdown
  final List<String> _history = []; // Stores completed timer durations

  // Getters
  int get duration => _duration;
  int get remainingTime => _remainingTime;
  bool get isRunning => _isRunning;
  List<String> get history => _history;

  // Set duration from hours, minutes, seconds, and milliseconds
  void setDuration(int hours, int minutes, int seconds, int milliseconds) {
    _duration = hours * 3600000 + minutes * 60000 + seconds * 1000 + milliseconds;
    _remainingTime = _duration;
    notifyListeners();
  }

  // Start the timer
  void startTimer() {
    if (!_isRunning) {
      _isRunning = true;
      // Update every 10ms for smooth millisecond display
      _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
        if (_remainingTime > 0) {
          _remainingTime -= 10; // Decrease by 10ms
          notifyListeners();
        } else {
          pauseTimer();
          // Add completed duration to history
          _history.add(formatDuration(_duration));
          notifyListeners();
        }
      });
      notifyListeners();
    }
  }

  // Pause the timer
  void pauseTimer() {
    _timer?.cancel();
    _isRunning = false;
    notifyListeners();
  }

  // Reset the timer
  void resetTimer() {
    _timer?.cancel();
    _isRunning = false;
    _remainingTime = _duration;
    notifyListeners();
  }

  // Format duration in hh:mm:ss:ms
  String formatDuration(int milliseconds) {
    final hours = milliseconds ~/ 3600000;
    final minutes = (milliseconds % 3600000) ~/ 60000;
    final seconds = (milliseconds % 60000) ~/ 1000;
    final ms = (milliseconds % 1000) ~/ 10; // Show two-digit milliseconds
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${ms.toString().padLeft(2, '0')}';
  }
}