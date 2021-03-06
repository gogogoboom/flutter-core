import 'package:gogoboom_flutter_core/gogoboom_flutter_core.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class BaseDio {
  BaseDio._();

  static BaseDio? _instance;

  static BaseDio getInstance() {
    _instance ??= BaseDio._();
    return _instance!;
  }

  Dio getDio() {
    final Dio dio = Dio();
    dio.options = BaseOptions(
        receiveTimeout: coreConfig.receiveTimeout,
        connectTimeout: coreConfig.connectTimeout); // 设置超时时间等 ...
    dio.interceptors.addAll(coreConfig.interceptors);
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      compact: false,
    ));
    return dio;
  }

  /// 这里封装了一个 BaseError 类，会根据后端返回的code返回不同的错误类
  BaseError getDioError(Object obj) {
    switch (obj.runtimeType) {
      case DioError:
        if ((obj as DioError).type == DioErrorType.response) {
          final Response? response = obj.response;
          if (response?.statusCode == 401) {
            return NeedLogin();
          } else if (response?.statusCode == 403) {
            return NeedAuth();
          } else if (response?.statusCode == 408) {
            return UserNotExist();
          } else if (response?.statusCode == 409) {
            return PwdNotMatch();
          } else if (response?.statusCode == 405) {
            return UserNameEmpty();
          } else if (response?.statusCode == 406) {
            return PwdEmpty();
          } else {
            return OtherError(
              statusCode: response?.statusCode,
              statusMessage: response?.statusMessage,
            );
          }
        }
    }

    return OtherError();
  }
}
