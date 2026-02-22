import 'package:flutter/material.dart';
import 'package:wifi/services/network_services.dart';

class NetworkScanner extends StatefulWidget {
  const NetworkScanner({super.key});

  @override
  State<NetworkScanner> createState() => _NetworkScannerState();
}

class _NetworkScannerState extends State<NetworkScanner> {
  final NetworkServices _networkServices = NetworkServices();
  List<String> devices = [];
  bool scanning = false;

  Future<void> startScan() async {
    setState(() {
      scanning = true;
    });

    

    final ip = await _networkServices.getMyIp();

    if (ip == null) return;

    final subnet = _networkServices.extractSubnet(ip);

    final found = await _networkServices.getDevices(subnet);

    setState(() {
      devices = found;
      scanning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Network Scanner"), centerTitle: true),

      body: Column(
        children: [
          ElevatedButton(onPressed: startScan, child: const Text("Start Scan")),

          if (scanning) const CircularProgressIndicator(),

          Expanded(
            child: ListView.builder(
              itemCount: devices.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(devices[index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}
