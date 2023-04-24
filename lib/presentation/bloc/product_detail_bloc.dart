import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:remote_congigue_demoapp/data/model/check_update_model.dart';
import 'package:remote_congigue_demoapp/domain/entities/app_config_entity.dart';
import 'package:remote_congigue_demoapp/domain/entities/check_update_model_entity.dart';
import 'package:remote_congigue_demoapp/domain/usecase/check_update_usecase.dart';
import 'package:remote_congigue_demoapp/domain/usecase/get_product_list_usecase.dart';
import 'package:remote_congigue_demoapp/domain/usecase/get_product_stream.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  GetProdcutDetailsUsecase usecase;
  CheckUpdateUsecase checkUpdateUsecase;
  GetProdcutDetailsStreamUsecase streamUsecase;
  StreamController<ProductDetailState> controller =
      StreamController<ProductDetailState>();

  List<ProductDataEntity> productList = [];
  String discount = "0";
  ProductDetailBloc(
    this.usecase,
    this.checkUpdateUsecase,
    this.streamUsecase,
  ) : super(ProductDetailInitial()) {
    on<ProductDetailEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetProductDetailsEvent>((event, emit) async {
      try {
        emit(ProductFetchLodingState());
        productList = await usecase.call(MyParam());

        print("-------------------");
        print("$productList");

        emit(ProductFetchSuccessState(productList, DateTime.now()));
      } catch (e) {
        emit(ProductFetchFailuerState(e.toString()));
      }
    });

    on<CheckForAppUpdate>((event, emit) async {
      try {
        CheckUpdateModelEntity data = await checkUpdateUsecase.call(MyParam());

        final packageInfo = await PackageInfo.fromPlatform();

        print("Fetched from checkupdate ${data.buildNumber}");

        if (data.buildNumber == packageInfo.buildNumber) {
          // print("Both build number are same=========>");
        } else {
          print(
              "Both build number are NOT same=========> ${data.buildNumber} ${packageInfo.buildNumber}");
        }

        emit(AppUpdateFetchSuccessfully(data));
      } catch (e) {
        print(e);
      }
    });

    on<GetProductDetailsStreamEvent>((event, emit) async {
      getData();
      if (!controller.hasListener) {
        await emit.forEach(controller.stream, onData: (state) => state);
      }
    });
  }

  getData() async {
    try {
      controller.add(ProductFetchLodingState());
      final stream = (await streamUsecase.call(MyParam()));

      //
      stream.asBroadcastStream().listen((event) async {
        print("STREAM DATA ${event[0].discount}");

        // if (emit.isDone) emit(ProductFetchLodingState());
        await Future.delayed(const Duration(seconds: 1));
        productList.clear();
        productList.addAll(event);
        controller.sink.add(ProductFetchSuccessState(event, DateTime.now()));

        // if (emit.isDone) {
        //   // emit(ProductFetchSuccessState(event, DateTime.now()));
        // }
      });

      // if (emit.isDone) {
      //   emit(ProductFetchSuccessState(event, DateTime.now()));
      // }
    } catch (e) {
      controller.add(ProductFetchFailuerState(e.toString()));
    }
  }
}
