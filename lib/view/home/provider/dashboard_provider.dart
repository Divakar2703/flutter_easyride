import 'package:flutter/cupertino.dart';
import 'package:flutter_easy_ride/api/dio_client.dart';
import 'package:flutter_easy_ride/api/service_locator.dart';
import 'package:flutter_easy_ride/model/dashboard.dart';
import 'package:flutter_easy_ride/model/nearby_vehicle.dart';
import 'package:flutter_easy_ride/utils/constant.dart';

class DashboardProvider extends ChangeNotifier {
  bool loading = false;
  DashboardResponse? dashboardResponse;
  NearByVehicle? vehicleResponse;
  DashboardResponse? get dashboard => dashboardResponse;
  NearByVehicle? get vehicleData => vehicleResponse;

  final dio = getIt.get<DioClient>();

  Future<void> fetchDashboard() async {
    loading = true;
    try {
      final response = await dio.get(Endpoints.dashboard);

      if (response?.statusCode == 200) {
        dashboardResponse = DashboardResponse.fromJson(response?.data);
        loading = false;
        notifyListeners();
      } else {
        loading = false;
      }
    } catch (e) {
      loading = false;
      print('Error sending POST request: $e');
    }
  }
}
