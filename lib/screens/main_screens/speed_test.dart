import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class SpeedTest extends StatefulWidget {
  const SpeedTest({super.key});

  @override
  State<SpeedTest> createState() => _SpeedTestState();
}

class _SpeedTestState extends State<SpeedTest> {
  double downloadSpeed = 0.0;
  bool testing = false;

  Future<void> _testSpeed() async {
    setState(() {
      testing = true;
      downloadSpeed = 0.0;
    });
    final stopwatch = Stopwatch()..start();

    final response = await http.get(
      Uri.parse("https://speed.cloudflare.com/__down?bytes=10000000"),
    );

    stopwatch.stop();

    final bytes = response.bodyBytes.length;

    final seconds = stopwatch.elapsedMilliseconds / 1000;

    final bitsLoaded = bytes * 8;

    final speedMbps = (bitsLoaded / seconds) / (1024 * 1024);

    setState(() {
      downloadSpeed = speedMbps;
      testing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${downloadSpeed.toStringAsFixed(2)} Mbps"),
              const SizedBox(height: 30),
              testing
                  ? Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blue[400],
                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: const SpinKitThreeBounce(
                        color: Colors.white,
                        size: 30,
                      ),
                    )
                  : GestureDetector(
                      onTap: () => _testSpeed(),
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blue[400],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "Start Test",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
