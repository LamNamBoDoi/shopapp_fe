import 'dart:convert';
import 'dart:io';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopapp_v1/data/response/error_response.dart';
import '../../utils/app_constants.dart';
import 'package:http_parser/http_parser.dart';

class ApiClient extends GetxService {
  final String appBaseUrl; // địa chỉ cơ sở
  final SharedPreferences sharedPreferences;
  static final String noInternetMessage = 'connection_to_api_server_failed'.tr;
  final int timeoutInSeconds = 90;
  var logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
    ),
  );
  String token = "";
  int storage = 0;
  Map<String, String> _mainHeaders = {};
  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    token = sharedPreferences.getString(AppConstants.TOKEN) ??
        "Basic Y29yZV9jbGllbnQ6c2VjcmV0";
    if (foundation.kDebugMode) {
      logger.i('Token: $token');
    }
    updateHeader(
      token,
      null,
      sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
      0,
    );
  }

  void updateHeader(
      String token, List<int>? zoneIDs, String? languageCode, int moduleID) {
    Map<String, String> header = {
      // 'Content-Type': 'application/json; charset=utf-8',
      'Content-Type': 'application/json',
      // AppConstants.LOCALIZATION_KEY:
      //     languageCode ?? AppConstants.languages[0].languageCode,
      'Authorization': token
    };
    header.addAll({AppConstants.MODULE_ID: moduleID.toString()});
    _mainHeaders = header;
  }

  Future<Response> getData(String uri,
      {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    try {
      if (foundation.kDebugMode) {
        logger.i(
            'Get Request: ${(appBaseUrl) + uri}\nHeader: ${headers ?? _mainHeaders}');
      }
      http.Response response = await http
          .get(
            Uri.parse(appBaseUrl + uri).replace(queryParameters: query),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      logger.e('${e.toString()}');
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(
      String uri, dynamic body, Map<String, String>? headers) async {
    try {
      if (foundation.kDebugMode) {
        logger.i(
            'Post Request: ${(appBaseUrl) + uri}\nHeader: ${headers ?? _mainHeaders}\nAPI Body: $body');
      }
      http.Response response = await http
          .post(
            Uri.parse(appBaseUrl + uri),
            body: body,
            headers: _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      logger.e('Error: ${e.toString()}');
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postDataLogin(
      String uri, dynamic body, Map<String, String>? headers) async {
    try {
      if (foundation.kDebugMode) {
        logger.i(
            'Post Request: ${(appBaseUrl) + uri}\nHeader: ${headers ?? _mainHeaders}\nAPI Body: $body');
      }
      http.Response response = await http
          .post(
            Uri.parse(appBaseUrl + uri),
            body: body,
            headers: headers,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      logger.e('Error: ${e.toString()}');
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postMultipartData({
    required String uri,
    required Map<String, String> body,
    File? file,
    Map<String, String>? headers,
  }) async {
    try {
      final request =
          http.MultipartRequest('POST', Uri.parse(appBaseUrl + uri));
      request.headers.addAll(headers ?? _mainHeaders);
      if (foundation.kDebugMode) {
        logger.i(
            'Post Multipart Request: ${(appBaseUrl) + uri}\nHeader: ${headers ?? _mainHeaders}');
      }
      if (file != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'thumbnail',
          file.path,
          contentType: MediaType('image', 'jpeg'), // hoặc 'png'
          filename: file.path.split('/').last,
        ));
      }

      request.fields.addAll(body);

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      if (foundation.kDebugMode) {
        logger.i(
            'Post Request: ${(appBaseUrl) + uri}\nHeader: ${headers ?? _mainHeaders}\nAPI Body: $body');
      }
      http.Response response = await http
          .put(
            Uri.parse(appBaseUrl + uri),
            body: jsonEncode(body),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String uri,
      {Map<String, String>? headers}) async {
    try {
      if (foundation.kDebugMode) {
        logger.i(
            'Post Request: ${(appBaseUrl) + uri}\nHeader: ${headers ?? _mainHeaders}');
      }
      http.Response response = await http
          .delete(
            Uri.parse(appBaseUrl + uri),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  // hàm xử lý phản hồi từ 1 yêu cầu HTTP
  Response handleResponse(http.Response response, String uri) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (e) {
      logger.e(e.toString());
    }
    Response response0 = Response(
      body: body ?? response.body,
      bodyString: response.body.toString(),
      request: Request(
          headers: response.request!.headers,
          method: response.request!.method,
          url: response.request!.url),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if (response0.statusCode != 200 &&
        response0.body != null &&
        response0.body is! String) {
      if (response0.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse errorResponse = ErrorResponse.fromJson(response0.body);
        response0 = Response(
            statusCode: response0.statusCode,
            body: response0.body,
            statusText: errorResponse.errors![0].message);
      } else if (response0.body.toString().startsWith('{message')) {
        response0 = Response(
            statusCode: response0.statusCode,
            body: response0.body,
            statusText: response0.body['message']);
      }
    } else if (response0.statusCode != 200 && response0.body == null) {
      response0 = Response(statusCode: 0, statusText: noInternetMessage);
    }
    if (foundation.kDebugMode) {
      logger
          .i('API Response: [${response0.statusCode}] $uri\n${response0.body}');
    }
    return response0;
  }

  Future<Response> postFileMultipartData(
      {required String uri,
      required Map<String, String> body,
      required File file,
      Map<String, String>? headers}) async {
    try {
      if (foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
      }
      http.MultipartRequest request =
          http.MultipartRequest('POST', Uri.parse(appBaseUrl + uri));
      request.headers.addAll(headers ?? _mainHeaders);

      http.MultipartFile imageMultipartFile = await http.MultipartFile.fromPath(
          'uploadfile ', file.path,
          filename: '${DateTime.now().toString()}.png');
      request.files.add(imageMultipartFile);

      request.fields.addAll(body);
      http.Response response =
          await http.Response.fromStream(await request.send());
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }
}

class MultipartBody {
  String key;
  XFile file;

  MultipartBody(this.key, this.file);
}
