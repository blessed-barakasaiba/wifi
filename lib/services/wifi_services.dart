import 'package:wifi_scan/wifi_scan.dart';

class WifiServices {
  Future<List<WiFiAccessPoint>> scanWifi() async {
    final can = await WiFiScan.instance.canGetScannedResults();

    if (can == CanGetScannedResults.yes) {
      return await WiFiScan.instance.getScannedResults();
    }
    return [];
  }
}
