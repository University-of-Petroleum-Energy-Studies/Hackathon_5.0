class Endpoints {
  Endpoints._();

  static const baseUrlStatistics = "https://api.covid19api.com";

  static const baseUrlIP = "https://httpbin.org/ip";

  static const baseUrlCurrentCountry = 'https://freegeoip.live/json';

  static const baseUrlGraphics = 'https://saurabhsuresh.github.io/covid';

  
  static const bgr =
      '';

  static const preventionDataSourceReferenceURL =
      'https://visme.co/blog/coronavirus-prevention';

  static const preventionDataSourceAuthorURL = 'https://www.chloesocial.com';

  static const informationDataSourceReferenceURL =
      'https://visme.co/blog/what-is-coronavirus';

  static const informationSourceAuthorURL = 'https://www.mahnoorsheikh.com';

  static const receiveTimeout = 5000;

  static const connectionTimeout = 3000;

  static const _fetchHomeData = '/summary';

  static const _fetchCountryStatistics = '/total/country/';

  static const _fetchPreventionGraphic = '/prevention.jpg';

  static const _fetchInformationGraphic =
      '/COVID-19-A-Global-Health-Crisis.jpg';

  static String get fetchIP => baseUrlIP;

  static String get fetchCurrentCountry => baseUrlCurrentCountry;

  static String get fetchHomeData => baseUrlStatistics + _fetchHomeData;

  static String get fetchCountryStatistics =>
      baseUrlStatistics + _fetchCountryStatistics;

  static String get fetchPreventionGraphic =>
      baseUrlGraphics + _fetchPreventionGraphic;

  static String get fetchInformatiionGraphic =>
      baseUrlGraphics + _fetchInformationGraphic;
}
