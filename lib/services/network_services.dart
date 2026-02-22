import 'package:network_info_plus/network_info_plus.dart';
import 'package:dart_ping/dart_ping.dart';

class NetworkServices {
  Future<String?> getMyIp() async {
    final info = NetworkInfo();
    return info.getWifiIP();
  }

  String extractSubnet(String ip) {
    return ip.substring(0, ip.lastIndexOf("."));
  }

  Future<List<String>> getDevices(String subnet) async {
    List<String> activeDevices = [];

    const int batchSize = 20;

    for (int i = 1; i < 255; i += batchSize) {
      List<Future<void>> batch = [];

      for (int j = i; j < i + batchSize && j < 255; j++) {
        final ip = '$subnet.$j';

        batch.add(() async {
          final ping = Ping(ip, count: 1, timeout: 1);

          await for (var event in ping.stream) {
            if (event.response != null) {
              activeDevices.add(ip);
            }
          }
        }());
      }

      await Future.wait(batch);
    }

    return activeDevices;
  }
}
