part of 'product_detail_bloc.dart';

abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object> get props => [];
}

class GetProductDetailsEvent extends ProductDetailEvent {
  @override
  List<Object> get props => [];
}

class GetProductDetailsStreamEvent extends ProductDetailEvent {
  @override
  List<Object> get props => [];
}

class CheckForAppUpdate extends ProductDetailEvent {
  @override
  List<Object> get props => [];
}
