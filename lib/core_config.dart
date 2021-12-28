import 'package:dio/dio.dart';

class CoreConfig {
  ///接收数据最大时间
  int receiveTimeout = 3000;

  ///连接超时时间
  int connectTimeout = 3000;

  ///dio的拦截器
  Interceptors interceptors = Interceptors();

  ///开发环境
  String devHost = '';

  ///测试环境
  String testHost = '';

  ///生产环境
  String prodHost = '';

  ///baseUrl通用后缀，如/app/**
  String hostSuffix = '/app';

  Profiles profiles = Profiles.dev;

  String get baseUrl {
    String host = devHost;
    switch (profiles) {
      case Profiles.dev:
        host = devHost;
        break;
      case Profiles.prod:
        host = prodHost;
        break;
      case Profiles.test:
        host = testHost;
        break;
    }
    return '$host$hostSuffix';
  }
}

enum Profiles { dev, prod, test }
