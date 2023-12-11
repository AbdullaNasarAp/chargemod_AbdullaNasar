// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:abdulla_nasar/utils/app_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppExceptions {
  static void errorHandler(Object e) {
    if (e is PlatformException) {
      AppToast.showToast('Platform Error Occured', Colors.red);
    }
    if (e is SocketException) {
      AppToast.showToast('No Internet Connection', Colors.red);
    } else if (e is TimeoutException) {
      AppToast.showToast('Connection Timedout', Colors.red);
    } else if (e is MissingPluginException) {
      AppToast.showToast('Plugin error occured', Colors.red);
    } else if (e is DioException) {
      if (e.response?.statusCode == 403 &&
          e.response?.data['message'] == 'forbidden') {
        log('refresh token expired so loging out');
      }
      if (e.response?.data['message'] != null) {
        AppToast.showToast(e.response!.data['message'].toString(), Colors.red);
      } else if (e.type == DioErrorType.connectionTimeout) {
        AppToast.showToast('Connection timedout', Colors.red);
      } else if (e.type == DioErrorType.receiveTimeout) {
        AppToast.showToast('Response timedout', Colors.red);
      } else if (e.type == DioErrorType.cancel) {
        AppToast.showToast('Request cancelled', Colors.red);
      } else if (e.type == DioErrorType.sendTimeout) {
        AppToast.showToast('Request timedout', Colors.red);
      } else if (e.error is SocketException) {
        AppToast.showToast('No Internet Connection', Colors.red);
      } else if (e.type == DioErrorType.unknown) {
        AppToast.showToast('Something went wrong', Colors.red);
      }
    }
  }
}
