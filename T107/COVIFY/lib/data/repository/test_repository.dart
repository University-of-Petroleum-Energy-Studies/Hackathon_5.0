import 'package:flutter/material.dart';
import 'package:covid19/models/application/ip_model.dart';
import 'package:covid19/data/repository/base_repository.dart';
import 'package:covid19/models/application/country_information_model.dart';
import 'package:covid19/models/statistics/country_statistics_day_model.dart';
import 'package:covid19/models/statistics/statistics_response_model.dart';

class TestRepository implements BaseRepository {
  Future<void> _wait() async {
    await Future.delayed(const Duration(milliseconds: 1000));
  }

  @override
  Future<IPModel> fetchUserIP() async {
    _wait();
    return IPModel(
      origin: "103.69.21.105",
    );
  }

  @override
  Future<CountryInformationModel> fetchUserCountryInformation({
    @required String ipAddress,
  }) async {
    _wait();
    return CountryInformationModel(
      countryName: "India",
      countryCode: "IN",
    );
  }

  @override
  Future<StatisticsResponseModel> fetchHomeData({
    @required String iso2,
  }) async {
    _wait();
    return StatisticsResponseModel(
      global: Global(
        newConfirmed: 62833,
        totalConfirmed: 1837869,
        newDeaths: 5665,
        totalDeaths: 110071,
        newRecovered: 24489,
        totalRecovered: 444024,
      ),
      countries: [
        HomeCountries(
          country: "India",
          countryCode: "IN",
          slug: "india",
          newConfirmed: 1034,
          totalConfirmed: 11487,
          newDeaths: 35,
          totalDeaths: 393,
          newRecovered: 178,
          totalRecovered: 1359,
          date: "2020-04-15T03:30:24Z",
        ),
      ],
      date: '2020-04-15T03:30:24Z',
    );
  }

  @override
  Future<List<CountryStatistics>> fetchCountryStatisticsConfirmed(
      {String iso2}) async {
    return [
      CountryStatistics(
        country: "India",
        countryCode: "IN",
        lat: "20.59",
        lon: "78.96",
        cases: 0,
        status: "confirmed",
        date: "2020-01-22T00:00:00Z",
      )
    ];
  }

  @override
  Future<List<CountryStatistics>> fetchCountryStatisticsRecovered(
      {String iso2}) async {
    return [
      CountryStatistics(
        country: "India",
        countryCode: "IN",
        lat: "20.59",
        lon: "78.96",
        cases: 0,
        status: "confirmed",
        date: "2020-01-22T00:00:00Z",
      )
    ];
  }
}
