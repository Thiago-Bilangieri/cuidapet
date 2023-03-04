// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:math';

import 'package:cuida_pet/app/core/rest_client/rest_client_response.dart';

class RestClientException implements Exception {
  String? message;
  int? statusCode;
  dynamic error;
  RestClientResponse response;

  RestClientException({
    this.message,
    this.statusCode,
    required this.error,
    required this.response,
  });

  @override
  String toString() {
    return "RestClientException ($message, statusCode: $statusCode, error:$error, reponse: $response)";
  }
}
