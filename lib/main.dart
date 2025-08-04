// Main app entry point
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer_app/model/timer_model.dart';
import 'package:timer_app/view/digital_ticker.dart';

// Main app entry point
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TimerModel(),
      child: TimerApp(),
    ),
  );
}

// Main app widget
class TimerApp extends StatelessWidget {
  const TimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF6A5ACD), // Blue (SlateBlue)
        scaffoldBackgroundColor: Color(0xFFE6E6FA), // Lavender
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF6A5ACD), // Blue buttons
            foregroundColor: Colors.white, // White text
          ),
        ),
      ),
      home: TimerView(),
    );
  }
}

// TimerView: Main UI with SliverAppBar and history
class TimerView extends StatefulWidget {
  const TimerView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TimerViewState createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {
  final TextEditingController _hoursController = TextEditingController();
  final TextEditingController _minutesController = TextEditingController();
  final TextEditingController _secondsController = TextEditingController();
  final TextEditingController _millisecondsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // No animation controller needed since we're using digital ticker
  }

  @override
  void dispose() {
    _hoursController.dispose();
    _minutesController.dispose();
    _secondsController.dispose();
    _millisecondsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TimerModel>(
        builder: (context, timerModel, child) {
          // Calculate hours, minutes, seconds, milliseconds for display
          final hours = timerModel.remainingTime ~/ 3600000;
          final minutes = (timerModel.remainingTime % 3600000) ~/ 60000;
          final seconds = (timerModel.remainingTime % 60000) ~/ 1000;
          final milliseconds = (timerModel.remainingTime % 1000) ~/ 10;

          return CustomScrollView(
            slivers: [
              // SliverAppBar: Pinned header with timer controls
              SliverAppBar(
                pinned: true,
                backgroundColor: Color(0xFFE6E6FA), // Lavender
                expandedHeight: 280.0,
                flexibleSpace: FlexibleSpaceBar(
                  // title: Text(
                  //   'Timer',
                  //   style: TextStyle(color: Color(0xFF6A5ACD),fontSize: 34), // Blue text
                  // ),
                  centerTitle: true,
                  background: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Duration input fields
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 60,
                              child: TextField(
                                controller: _hoursController,
                                decoration: InputDecoration(
                                  labelText: 'Hr',
                                  border: OutlineInputBorder(),
                                  labelStyle: TextStyle(
                                    color: Color(0xFF6A5ACD),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  final hours = int.tryParse(value) ?? 0;
                                  final minutes =
                                      int.tryParse(_minutesController.text) ??
                                      0;
                                  final seconds =
                                      int.tryParse(_secondsController.text) ??
                                      0;
                                  final ms =
                                      int.tryParse(
                                        _millisecondsController.text,
                                      ) ??
                                      0;
                                  timerModel.setDuration(
                                    hours,
                                    minutes,
                                    seconds,
                                    ms,
                                  );
                                },
                              ),
                            ),
                            SizedBox(width: 30),
                            SizedBox(
                              width: 60,
                              child: TextField(
                                controller: _minutesController,
                                decoration: InputDecoration(
                                  labelText: 'Min',
                                  border: OutlineInputBorder(),
                                  labelStyle: TextStyle(
                                    color: Color(0xFF6A5ACD),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  final hours =
                                      int.tryParse(_hoursController.text) ?? 0;
                                  final minutes = int.tryParse(value) ?? 0;
                                  final seconds =
                                      int.tryParse(_secondsController.text) ??
                                      0;
                                  final ms =
                                      int.tryParse(
                                        _millisecondsController.text,
                                      ) ??
                                      0;
                                  timerModel.setDuration(
                                    hours,
                                    minutes,
                                    seconds,
                                    ms,
                                  );
                                },
                              ),
                            ),
                            SizedBox(width: 30),
                            SizedBox(
                              width: 60,
                              child: TextField(
                                controller: _secondsController,
                                decoration: InputDecoration(
                                  labelText: 'Sec',
                                  border: OutlineInputBorder(),
                                  labelStyle: TextStyle(
                                    color: Color(0xFF6A5ACD),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  final hours =
                                      int.tryParse(_hoursController.text) ?? 0;
                                  final minutes =
                                      int.tryParse(_minutesController.text) ??
                                      0;
                                  final seconds = int.tryParse(value) ?? 0;
                                  final ms =
                                      int.tryParse(
                                        _millisecondsController.text,
                                      ) ??
                                      0;
                                  timerModel.setDuration(
                                    hours,
                                    minutes,
                                    seconds,
                                    ms,
                                  );
                                },
                              ),
                            ),
                            SizedBox(width: 30),
                            SizedBox(
                              width: 60,
                              child: TextField(
                                controller: _millisecondsController,
                                decoration: InputDecoration(
                                  labelText: 'ms',
                                  border: OutlineInputBorder(),
                                  labelStyle: TextStyle(
                                    color: Color(0xFF6A5ACD),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  final hours =
                                      int.tryParse(_hoursController.text) ?? 0;
                                  final minutes =
                                      int.tryParse(_minutesController.text) ??
                                      0;
                                  final seconds =
                                      int.tryParse(_secondsController.text) ??
                                      0;
                                  final ms = int.tryParse(value) ?? 0;
                                  timerModel.setDuration(
                                    hours,
                                    minutes,
                                    seconds,
                                    ms,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        // Digital ticker display
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DigitalTicker(value: hours, label: 'Hours'),
                            SizedBox(width: 8),
                            Text(
                              ':',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF6A5ACD),
                              ),
                            ),
                            SizedBox(width: 25),
                            DigitalTicker(value: minutes, label: 'Minutes'),
                            SizedBox(width: 8),
                            Text(
                              ':',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF6A5ACD),
                              ),
                            ),
                            SizedBox(width: 25),
                            DigitalTicker(value: seconds, label: 'Seconds'),
                            SizedBox(width: 8),
                            Text(
                              '.',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF6A5ACD),
                              ),
                            ),
                            SizedBox(width: 25),
                            DigitalTicker(
                              value: milliseconds,
                              label: 'Milliseconds',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // History section
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'HISTORY',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        timerModel.history.isEmpty
                            ? Text(
                                'No completed timers yet.',
                                style: TextStyle(color: Colors.grey),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: timerModel.history.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      'Timer ${index + 1}: ${timerModel.history[index]}',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                },
                              ),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          );
        },
      ),
      // Footer buttons
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 38),
        child: Container(
          color: Color(0xFFE6E6FA), // Lavender
          padding: EdgeInsets.all(10),
          child: Consumer<TimerModel>(
            builder: (context, timerModel, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: timerModel.isRunning
                        ? null
                        : () {
                            timerModel.startTimer();
                          },
                    child: Text('Start'),
                  ),
                  ElevatedButton(
                    onPressed: timerModel.isRunning
                        ? () {
                            timerModel.pauseTimer();
                          }
                        : null,
                    child: Text('Pause'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      timerModel.resetTimer();
                    },
                    child: Text('Reset'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
