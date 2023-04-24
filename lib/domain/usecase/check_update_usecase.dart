import 'package:remote_congigue_demoapp/data/model/check_update_model.dart';
import 'package:remote_congigue_demoapp/domain/entities/check_update_model_entity.dart';
import 'package:remote_congigue_demoapp/domain/repositories/app_configue_repo.dart';
import 'package:remote_congigue_demoapp/domain/usecase/base_usecase.dart';
import 'package:remote_congigue_demoapp/domain/usecase/get_product_list_usecase.dart';

class CheckUpdateUsecase
    implements Usecase<MyParam, Future<CheckUpdateModelEntity>> {
  AppConfigRepository repository;
  CheckUpdateUsecase(this.repository);

  @override
  Future<CheckUpdateModelEntity> call(MyParam p) {
    return repository.checkUpdate();
  }
}
