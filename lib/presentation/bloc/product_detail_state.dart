part of 'product_detail_bloc.dart';

abstract class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object> get props => [];
}

class ProductDetailInitial extends ProductDetailState {}

class ProductFetchSuccessState extends ProductDetailState {
  List<ProductDataEntity> dataList;
  DateTime time;

  ProductFetchSuccessState(this.dataList, this.time);

  @override
  List<Object> get props => [dataList, time];
}

class ProductFetchLodingState extends ProductDetailState {}

class ProductFetchFailuerState extends ProductDetailState {
  String failureMessage;
  ProductFetchFailuerState(this.failureMessage);

  @override
  List<Object> get props => [failureMessage];
}

class AppUpdateFetchSuccessfully extends ProductDetailState {
  CheckUpdateModelEntity checkUpdateData;
  AppUpdateFetchSuccessfully(this.checkUpdateData);
  @override
  List<Object> get props => [checkUpdateData];
}
