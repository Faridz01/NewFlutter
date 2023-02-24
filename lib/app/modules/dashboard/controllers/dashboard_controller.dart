import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tokoonline/app/data/entertainment_response.dart';
import 'package:tokoonline/app/data/headline_response.dart';
import 'package:tokoonline/app/data/sports_response.dart';
import 'package:tokoonline/app/data/technology_response.dart';
import 'package:tokoonline/app/utils/api.dart';

class DashboardController extends GetxController {
  final getConnect = GetConnect();
  final auth = GetStorage();
  
  Future<HeadlineResponse> getHeadline() async {
    final response = await getConnect.get(BaseUrl.headline);
    return HeadlineResponse.fromJson(jsonDecode(response.body));
  }

  Future<TechnologyResponse> getTechnology() async {
    final response = await getConnect.get(BaseUrl.technology);
    return TechnologyResponse.fromJson(jsonDecode(response.body));
  }

  Future<SportsResponse> getSport() async {
    final response = await getConnect.get(BaseUrl.sports);
    return SportsResponse.fromJson(jsonDecode(response.body));
  }

  Future<EntertainmentResponse> getEntertainment() async {
    final response = await getConnect.get(BaseUrl.entertainment);
    return EntertainmentResponse.fromJson(jsonDecode(response.body));
  }
}
