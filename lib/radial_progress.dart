import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'dart:ui';
import 'dart:math';
import 'dart:core';
import 'dart:async';
import 'home_screen.dart';

class TimePainter extends CustomPainter {
	Color lC, cC;
	double cP, width;
	TimePainter({this.lC, this.cC, this.cP, this.width});

	@override
	void paint(Canvas canvas, Size size) {
		Paint line = Paint()
			..color = lC
			..strokeCap = StrokeCap.round
			..style = PaintingStyle.stroke
			..strokeWidth = width;
		Paint complete = Paint()
			..color = cC
			..strokeCap = StrokeCap.round
			..style = PaintingStyle.stroke
			..strokeWidth = width;
		Offset center = Offset(size.width / 2, size.height / 2);
		double radius = min(size.width / 2, size.height / 2);
		canvas.drawCircle(center, radius, line);
		double arcAngle = 2 * pi * (cP / 100);
		canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2, arcAngle, false, complete);
	}

	@override
	bool shouldRepaint(CustomPainter oldDelegate) {
		return true;
	}
}

class RadialProgress extends StatefulWidget {
	final int tT, mode;
	int tC;
	HomeScreenState par;
	RadialProgress({this.tT, this.mode, this.tC, this.par});
	@override
	State<RadialProgress> createState() {
		return _RadialProgressState();
	}
}

class _RadialProgressState extends State<RadialProgress> {
	bool tF = false;
	AssetsAudioPlayer p;
	Timer timer;

	@override
	void initState() {
		p = AssetsAudioPlayer();
		widget.tC = 0;
		timer = Timer.periodic(
			Duration(seconds: 1),
			(Timer t) => {
				setState(() {
					if (widget.tC >= widget.tT) {
						tF = !tF;
						widget.tC = 0;
						playAlarm();
					} else if (tF) {
						widget.tC += 1;
					}
				})
			});
		super.initState();
	}

	Future playAlarm() async {
		p.open(AssetsAudio(
			asset: "time-over.mp3",
			folder: "assets/audio/",
		));
		showDialog(
			context: context,
			builder: (BuildContext context) {
				return AlertDialog(
					title: Text(widget.mode == 0 ? "Time Over" : "Play Time Over"),
					content: Text(widget.mode == 0 ? "Take a break!" : "Let's get back to work!"),
					contentTextStyle: Theme.of(context).textTheme.body1,
					actions: <Widget>[
						FlatButton(
							color: Colors.blueAccent,
							child: Text("Close", style: Theme.of(context).textTheme.button),
							onPressed: () {
								stop();
								Navigator.of(context).pop();
								widget.par.onTabTapped(1-widget.par.curr);
						}),
					],
				);
			});
	}

	void stop() {
		p.stop();
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
					lC: widget.mode == 0 ? Colors.red : Colors.green,
					cC: Colors.white70,
					cP: widget.tC.toDouble() / widget.tT.toDouble() * 100,
					width: 8
				),
				child: IconButton(
					icon: tF ? Icon(Icons.pause) : Icon(Icons.play_arrow),
					color: widget.mode == 0 ? Colors.redAccent.withOpacity(0.7) : Colors.green.withOpacity(0.7),
					iconSize: 40,
					onPressed: () {
						setState(() {
							tF = !tF;
						});
					}),
			),
		);
	}
}
