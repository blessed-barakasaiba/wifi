import 'dart:isolate';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:dart_ping/dart_ping.dart';

class NetworkServices {
  Future<String?> getMyIp() async {
    return NetworkInfo().getWifiIP();
  }

  String extractSubnet(String ip) {
    return ip.substring(0, ip.lastIndexOf("."));
  }

  Future<List<String>> getDevices(String subnet) async {
    // Run in isolate so UI thread is never blocked
    return await Isolate.run(() => _scanSubnet(subnet));
  }

  static Future<List<String>> _scanSubnet(String subnet) async {
    final futures = List.generate(253, (i) async {
      final ip = '$subnet.${i + 1}';
      try {
        final ping = Ping(ip, count: 1, timeout: 1, interval: 0);
        await for (final event in ping.stream) {
          if (event.response != null) return ip;
        }
      } catch (_) {}
      return null;
    });

    final results = await Future.wait(futures);
    return results.whereType<String>().toList();
  }


  
}