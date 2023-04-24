import 'dart:async';
import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:remote_congigue_demoapp/data/model/check_update_model.dart';
import 'package:remote_congigue_demoapp/data/model/product_model.dart';
import 'package:remote_congigue_demoapp/domain/entities/app_config_entity.dart';
import 'package:remote_congigue_demoapp/domain/entities/check_update_model_entity.dart';
import 'package:remote_congigue_demoapp/domain/repositories/app_configue_repo.dart';
import 'package:http/http.dart' as http;

class AppConfigRepositoryImpl implements AppConfigRepository {
  final FirebaseRemoteConfig remoteConfig;

  const AppConfigRepositoryImpl({required this.remoteConfig});

  @override
  Future<List<ProductDataEntity>> getAppConfig() async {
    bool ans = await remoteConfig.fetchAndActivate();
    print("fetching started-------------------------------------> $ans");

    final responce = remoteConfig.getString('event_info');
    final discount = remoteConfig.getDouble('discount');
    print("discount is---->$discount");
    // print("in repo impl class responce ${responce}------>");
    var resultData = [];
    try {
      resultData = jsonDecode(responce);
    } catch (e) {
      print(e);
    }

    return resultData.map((e) {
      var data = ProductDataModel.fromJson(e).transform();
      print("in repo impl class responce ${data}------>");
      //if discoutn is updated separetly then ovveride the old json value with new
      data.discount = discount;
      return data;
    }).toList();

    // return AppConfig(appName: "asd", appVersion: "asdasd");
  }

  @override
  Future<CheckUpdateModelEntity> checkUpdate() async {
    await remoteConfig.fetchAndActivate();
    var responce = remoteConfig.getString('app_version');

    late CheckUpdateModelEntity resultModel;
    try {
      var data = jsonDecode(responce);
      resultModel = CheckUpdateModel.fromJson(data).transform();

      print("build num=========> ${resultModel.buildNumber}");
      // resultModel = CheckUpdateModel.fromJson(responce).transform();
      // print("APP UPDATE RESPONCE FROM REPO IMPL $result ");
    } catch (e) {
      print("exception is $e");
    }
    return resultModel;
  }

  @override
  Future<Stream<List<ProductDataEntity>>> getProductDetailStream() async {
    StreamController<List<ProductDataEntity>> controller =
        StreamController<List<ProductDataEntity>>();

    double previousDiscount = 0;

    Timer.periodic(Duration(seconds: 2), (timer) async {
      print("TImer ${timer}");
      await remoteConfig.fetchAndActivate();
      //  await remoteConfig.fetch();

      final responce = remoteConfig.getString('event_info');
      // final discount = remoteConfig.getInt('discount');
      final double discount1 = remoteConfig.getDouble('discount');
      var resultData = [];

      try {
        resultData = jsonDecode(responce);
      } catch (e) {
        print(e);
      }

      if (previousDiscount != discount1) {
        controller.sink.add(resultData.map((e) {
          var data = ProductDataModel.fromJson(e).transform();
          //if discoutn is updated separetly then ovveride the old json value with new
          data.discount = discount1;
          previousDiscount = discount1;

          return data;
        }).toList());
      }
    });

    // print("Hello------data to be return is $data");
    return controller.stream;
  }
}
