import 'package:remote_congigue_demoapp/data/model/check_update_model.dart';
import 'package:remote_congigue_demoapp/domain/entities/app_config_entity.dart';
import 'package:remote_congigue_demoapp/domain/entities/check_update_model_entity.dart';

abstract class AppConfigRepository {
  Future<List<ProductDataEntity>> getAppConfig();
  Future<CheckUpdateModelEntity> checkUpdate();
  Future<Stream<List<ProductDataEntity>>> getProductDetailStream();
}
