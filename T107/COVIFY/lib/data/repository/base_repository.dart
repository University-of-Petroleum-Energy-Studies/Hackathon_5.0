import 'package:flutter/material.dart';
import 'package:covid19/models/application/ip_model.dart';
import 'package:covid19/models/application/country_information_model.dart';
import 'package:covid19/models/statistics/statistics_response_model.dart';
import 'package:covid19/models/statistics/country_statistics_day_model.dart';


abstract class BaseRepository {
  /// Fetch IP of the user
  Future<IPModel> fetchUserIP();

  Future<CountryInformationModel> fetchUserCountryInformation(
      {@required String ipAddress});

  Future<StatisticsResponseModel> fetchHomeData({@required String iso2});

  Future<List<CountryStatistics>> fetchCountryStatisticsConfirmed(
      {@required String iso2});

  Future<List<CountryStatistics>> fetchCountryStatisticsRecovered(
      {@required String iso2});
}
