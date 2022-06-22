import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:segundo_parcia_backend/pages/home.dart';

var dio = Dio();
var dioDownloader = Dio();
void initDio({required GlobalKey<NavigatorState> navKey}) {
  const storage = FlutterSecureStorage();
  String baseUrl = String.fromEnvironment('SERVER_ADDRESS',
      defaultValue: dotenv.env['SERVER_ADDRESS']!);
  dio.options.connectTimeout = 5000;
  dio.options.baseUrl = baseUrl;
  String? accessToken;

  //setup interceptors
  dio.interceptors.add(QueuedInterceptorsWrapper(
    onRequest: (options, handler) async {
      accessToken = (await storage.read(key: "access_token")??'');
      options.headers["authorization"] = "bearer $accessToken";

      return handler.next(options);
    },
    onError: (DioError error, handle) async {
      if (error.response?.statusCode == 403) {
        try {
          await storage.deleteAll();
          accessToken = null;

          navKey.currentState!.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const MyHomePage(title: 'Bienvenido',),
            ),
                (route) => false,
          );
        } catch (e) {
          print(e);
        }
      } else if (error.response?.statusCode == 401) {
        if (accessToken == null) {
          await storage.deleteAll();

          return handle.next(error);
        }

        RequestOptions options = error.response!.requestOptions;
        Options optionsDio = Options(
            contentType: options.contentType,
            followRedirects: options.followRedirects,
            extra: options.extra,
            headers: options.headers,
            listFormat: options.listFormat,
            maxRedirects: options.maxRedirects,
            method: options.method,
            receiveDataWhenStatusError: options.receiveDataWhenStatusError,
            receiveTimeout: options.receiveTimeout,
            requestEncoder: options.requestEncoder,
            responseDecoder: options.responseDecoder,
            responseType: options.responseType,
            sendTimeout: options.sendTimeout,
            validateStatus: options.validateStatus);
        if ("bearer $accessToken" != options.headers["authorization"]) {
          options.headers["authorization"] = "bearer $accessToken";
          handle.resolve(await dio.request(options.path, options: optionsDio));
          // return handle.next(dio.request(options.path));
        }
        dio.lock();
        dio.interceptors.responseLock.lock();
        dio.interceptors.errorLock.lock();

        try {
          dio.unlock();
          dio.interceptors.responseLock.unlock();
          dio.interceptors.errorLock.unlock();
          //retry request
          return handle
              .resolve(await dio.request(options.path, options: optionsDio));
        } catch (e) {
          dio.unlock();
          dio.interceptors.responseLock.unlock();
          dio.interceptors.errorLock.unlock();
          await storage.deleteAll();
          accessToken = null;

          navKey.currentState!.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const MyHomePage(title: "Bienvienido"),
            ),
                (route) => false,
          );
          return handle.next(error);
        }
      }
      print(error);
      return handle.next(error);
    },
  ));
}

void dioByteInstance() {
  const storage = FlutterSecureStorage();
  String baseUrl = String.fromEnvironment('SERVER_ADDRESS',
      defaultValue: dotenv.env['SERVER_ADDRESS']!);
  dioDownloader.options.connectTimeout = 5000;
  dioDownloader.options.baseUrl = baseUrl;
  dioDownloader.options.connectTimeout = 20000;
  dioDownloader.options.receiveTimeout = 20000;
  dioDownloader.options.responseType = ResponseType.bytes;
  String? accessToken;

  //setup interceptors
  dioDownloader.interceptors.add(QueuedInterceptorsWrapper(
    onRequest: (options, handler) async {
      accessToken = (await storage.read(key: "access_token")??'');
      options.headers["authorization"] = "bearer $accessToken";

      return handler.next(options);
    },
    onError: (DioError error, handle) async {
      if (error.response?.statusCode == 401) {
        if (accessToken == null) {
          await storage.deleteAll();

          return handle.next(error);
        }

        RequestOptions options = error.response!.requestOptions;
        Options optionsDio = Options(
            contentType: options.contentType,
            followRedirects: options.followRedirects,
            extra: options.extra,
            headers: options.headers,
            listFormat: options.listFormat,
            maxRedirects: options.maxRedirects,
            method: options.method,
            receiveDataWhenStatusError: options.receiveDataWhenStatusError,
            receiveTimeout: options.receiveTimeout,
            requestEncoder: options.requestEncoder,
            responseDecoder: options.responseDecoder,
            responseType: options.responseType,
            sendTimeout: options.sendTimeout,
            validateStatus: options.validateStatus);
        if ("bearer $accessToken" != options.headers["authorization"]) {
          options.headers["authorization"] = "bearer $accessToken";
          handle.resolve(await dioDownloader.request(options.path, options: optionsDio));
          // return handle.next(dio.request(options.path));
        }
        dioDownloader.lock();
        dioDownloader.interceptors.responseLock.lock();
        dioDownloader.interceptors.errorLock.lock();

        try {
          dioDownloader.unlock();
          dioDownloader.interceptors.responseLock.unlock();
          dioDownloader.interceptors.errorLock.unlock();
          //retry request
          return handle
              .resolve(await dioDownloader.request(options.path, options: optionsDio));
        } catch (e) {
          dioDownloader.unlock();
          dioDownloader.interceptors.responseLock.unlock();
          dioDownloader.interceptors.errorLock.unlock();
          await storage.deleteAll();
          accessToken = null;


          return handle.next(error);
        }
      }
      print(error);
      return handle.next(error);
    },
  ));
}