import 'dart:developer' as developer;
import 'dart:io';
import 'dart:convert';
import 'package:flurest/networking/app_exceptions.dart';
import 'package:http/http.dart' as http;

class ApiBaseHelper {
  final String _baseUrl = 'http://api.themoviedb.org/3';
  
  Future<dynamic> get(String endpoint) async {
    developer.log('Api Get URL: [$endpoint]');

    var responseJson;

    try {
      final response = await http.get(Uri.parse(_baseUrl + endpoint));

      responseJson = parseResponse(response);
    } on SocketException {
      developer.log('No internet connection for request');
      throw FetchDataException('No internet connection available');
    }

    return responseJson;
  }

  dynamic parseResponse(http.Response response) {
    developer.log('Received response payload: ${response.body.toString()}');
    switch (response.statusCode) {
      case HttpStatus.ok:
        return json.decode(response.body.toString());
      case HttpStatus.badRequest:
        throw BadRequestException(response.body.toString());
      case HttpStatus.unauthorized:
      case HttpStatus.forbidden:
        throw UnauthorizedException(response.body.toString());
      case HttpStatus.internalServerError:
      default:
        throw FetchDataException('Error occurred while fetching data from server - error code: ${response.statusCode}');
    }
  }
}
