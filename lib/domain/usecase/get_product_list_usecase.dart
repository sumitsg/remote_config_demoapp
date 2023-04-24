import 'package:remote_congigue_demoapp/domain/entities/app_config_entity.dart';
import 'package:remote_congigue_demoapp/domain/repositories/app_configue_repo.dart';
import 'package:remote_congigue_demoapp/domain/usecase/base_usecase.dart';

class GetProdcutDetailsUsecase
    implements Usecase<MyParam, Future<List<ProductDataEntity>>> {
  AppConfigRepository repository;
  GetProdcutDetailsUsecase(this.repository);
  @override
  Future<List<ProductDataEntity>> call(MyParam t) {
    return repository.getAppConfig();
  }
}

class MyParam {}
