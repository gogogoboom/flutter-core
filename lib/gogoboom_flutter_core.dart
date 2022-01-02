library gogoboom_flutter_core;

import 'package:dio/dio.dart';
import 'package:gogoboom_flutter_core/core_config.dart';

import 'http/base_dio.dart';

export 'package:dio/dio.dart' hide Headers;
export 'package:retrofit/retrofit.dart';
export 'http/base_dio.dart';
export 'http/base_error.dart';
export 'core_config.dart';

final Dio dio = BaseDio.getInstance().getDio();
final CoreConfig coreConfig = CoreConfig();