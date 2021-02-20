import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart' show md5;
import 'package:flutter/material.dart';
import 'package:covid19/data/network/exceptions/network_exceptions.dart';

class RequestWrapper {
  final String url;
  final Map body;

  RequestWrapper({
    @required this.url,
    @required this.body,
  });
}


class HttpRequestUtil {
  static String hashRequest(RequestWrapper request) {
    final urlHash = generateHash(request.url);
    final bodyHash = generateHash(sortMap(request.body ?? {}).toString());
    final requestHash = generateHash(urlHash + bodyHash);
    debugPrint("Request Hash :- $requestHash");
    return requestHash;
  }

  static SplayTreeMap sortMap(Map map) {
    return SplayTreeMap.from(map, (a, b) => a.compareTo(b) as int);
  }

  static String generateHash(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }


  static dynamic getRequest({
    String url,
  }) async {
    debugPrint('getting $url');

    try {
      // Fetch the contens of the fiven URL and decode it
      final jsonResponse = await http.get(url);
      final responseMap = jsonDecode(jsonResponse.body);

      return responseMap;
      // debugPrint('HTTP Response :- \n $responseMap');

    }

    // Catching the [FormatException] which occurs due to the server not responding
    // with a JSON but rather with some error message
    on FormatException {
      debugPrint('Get Request Format Exception');
      throw 'Server Error. API not deployed [ E_API01 ]';
    }
    // Catching any Generic Errors and throwing APIRresponseException to display
    // generic error screen to the user
    catch (e) {
      debugPrint('Error in GET Request :- \n ${e.message}');
      if (e.message == 'You don’t seem to have an active Internet Connection') {
        throw NetworkException(
          message: 'You don’t seem to have an active Internet Connection',
        );
      } else {
        throw APIResponseException(
          message: 'Unknown Exception while GETting',
        );
      }
    }
  }

  static void handleResponseError(
    Map jsonResponse,
    String customError,
  ) {
    // debugPrint('In Handle Response Error + ${jsonResponse.toString()}');
  }
}
