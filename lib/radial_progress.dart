import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'dart:ui';
import 'dart:math';
import 'dart:core';
import 'dart:async';
import 'home_screen.dart';

class TimePainter extends CustomPainter {
	Color lineColor, completeColor;
	double completePercent, width;
	TimePainter({this.lineColor, this.completeColor, this.completePercent, this.width});

	@override
	void paint(Canvas canvas, Size size) {
		Paint line = Paint()
			..color = lineColor
			..strokeCap = StrokeCap.round
			..style = PaintingStyle.stroke
			..strokeWidth = width;
		Paint complete = Paint()
			..color = completeColor
			..strokeCap = StrokeCap.round
			..style = PaintingStyle.stroke
			..strokeWidth = width;
		Offset center = Offset(size.width / 2, size.height / 2);
		double radius = min(size.width / 2, size.height / 2);
		canvas.drawCircle(center, radius, line);
		double arcAngle = 2 * pi * (completePercent / 100);
		canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
				arcAngle, false, complete);
	}

	@override
	bool shouldRepaint(CustomPainter oldDelegate) {
		return true;
	}
}

class RadialProgress extends StatefulWidget {
	final int totalTime, mode;
	int timeCompleted;
	HomeScreenState parent;
	RadialProgress({this.totalTime, this.mode, this.timeCompleted, this.parent});
	@override
	State<RadialProgress> createState() {
		return _RadialProgressState();
	}
}

class _RadialProgressState extends State<RadialProgress> {
	bool timerRunning = false, shouldPlaySound = false;
	AssetsAudioPlayer player;
	Timer timer;

	@override
	void initState() {
		player = AssetsAudioPlayer();
		widget.timeCompleted = 0;
		// totalTime = 60;
		timer = Timer.periodic(
				Duration(seconds: 1),
				(Timer t) => {
							setState(() {
								if (widget.timeCompleted >= widget.totalTime) {
									timerRunning = !timerRunning;
									widget.timeCompleted = 0;
									playAlarm();
								} else if (timerRunning) {
									widget.timeCompleted += 1;
								}
							})
						});
		super.initState();
	}

	Future playAlarm() async {
		player.open(AssetsAudio(
			asset: "time-over.mp3",
			folder: "assets/audio/",
		));
		showDialog(
				context: context,
				builder: (BuildContext context) {
					return AlertDialog(
						title: Text(widget.mode == 0 ? "Time Over" : "Play Time Over"),
						content: Text(
								widget.mode == 0 ? "Take a break!" : "Let's get back to work!"),
						contentTextStyle: Theme.of(context).textTheme.body1,
						actions: <Widget>[
							FlatButton(
								color: Colors.blueAccent,
								child: Text("Close", style: Theme.of(context).textTheme.button),
								onPressed: () {
									stop();
									Navigator.of(context).pop();
									widget.parent.onTabTapped(1-widget.parent.currentIndex);
								},
							),
						],
					);
				});
	}

	void stop() {
		player.stop();
	}

	@override
	void dispose() {
		timer?.cancel();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return Container(
			height: 200,
			width: 200,
			child: CustomPaint(
				foregroundPainter: TimePainter(
						lineColor: widget.mode == 0 ? Colors.red : Colors.green,
						completeColor: Colors.white70,
						completePercent: widget.timeCompleted.toDouble() /
								widget.totalTime.toDouble() *
								100,
						width: 8.0),
				child: IconButton(
						icon: timerRunning ? Icon(Icons.pause) : Icon(Icons.play_arrow),
						color: widget.mode == 0
								? Colors.redAccent.withOpacity(0.7)
								: Colors.green.withOpacity(0.7),
						iconSize: 40,
						onPressed: () {
							setState(() {
								timerRunning = !timerRunning;
							});
						}),
			),
		);
	}
}
