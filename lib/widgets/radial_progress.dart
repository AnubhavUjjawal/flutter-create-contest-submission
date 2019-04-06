import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math';
import 'dart:core';
import 'dart:async';

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
		Offset center = Offset(size.width/2, size.height/2);
		double radius = min(size.width/2,size.height/2);
		canvas.drawCircle(
				center,
				radius,
				line
		);
		double arcAngle = 2*pi*(completePercent/100);
		canvas.drawArc(
				Rect.fromCircle(center: center,radius: radius),
				-pi/2,
				arcAngle,
				false,
				complete
		);
	}

	@override
	bool shouldRepaint(CustomPainter oldDelegate) {
		return true;
	}
}

class RadialProgress extends StatefulWidget {
	final int totalTime; 
	RadialProgress({this.totalTime});
	@override
	State<RadialProgress> createState() {
		return _RadialProgressState();
	}
}

class _RadialProgressState extends State<RadialProgress>{
	int timeCompleted;
	bool timerRunning = false;
	Timer timer;

	@override
	void initState() {
		timeCompleted = 0;
		// totalTime = 60;
		timer = Timer.periodic(Duration(seconds: 1), (Timer t) => {
			setState((){
				timeCompleted = !timerRunning?timeCompleted:timeCompleted<widget.totalTime?timeCompleted+1:0;
				
			})
		});
		super.initState();
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
					lineColor: Colors.redAccent,
					completeColor: Colors.white70,
					completePercent: timeCompleted.toDouble()/widget.totalTime.toDouble() * 100,
					width: 8.0
				),
				child: IconButton(
					icon: timerRunning?Icon(Icons.pause):Icon(Icons.play_arrow),
					color: Colors.redAccent.withOpacity(0.7),
					iconSize: 40,
					onPressed: (){
						setState(() {
								timerRunning = !timerRunning;
						});
					}
				),
			),
		);
	}
}