import 'package:remote_congigue_demoapp/domain/entities/app_config_entity.dart';
import 'package:remote_congigue_demoapp/domain/repositories/app_configue_repo.dart';
import 'package:remote_congigue_demoapp/domain/usecase/base_usecase.dart';
import 'package:remote_congigue_demoapp/domain/usecase/get_product_list_usecase.dart';

class GetProdcutDetailsStreamUsecase
    implements Usecase<MyParam, Future<Stream<List<ProductDataEntity>>>> {
  AppConfigRepository repository;
  GetProdcutDetailsStreamUsecase(this.repository);
  @override
  Future<Stream<List<ProductDataEntity>>> call(MyParam t) {
    return repository.getProductDetailStream();
  }
}
