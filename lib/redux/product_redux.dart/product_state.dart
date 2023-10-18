// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:storeapp/data/product_model.dart';

class ProductState {
  List<ProductModel>? products;
  ProductModel? productDetail;
  bool? isProductFetching, isDetailFetching, isPaginationLoad;

  ProductState({
    this.products,
    this.isProductFetching,
    this.productDetail,
    this.isDetailFetching,
    this.isPaginationLoad,
  });

  factory ProductState.initial() {
    return ProductState(
      products: [],
      isProductFetching: false,
      isPaginationLoad: false,
      productDetail: ProductModel.initial(),
      isDetailFetching: false,
    );
  }

  ProductState.fromProductState(ProductState another) {
    products = List.from(another.products ?? []);
    isProductFetching = another.isProductFetching ?? false;
    productDetail = another.productDetail ?? ProductModel.initial();
    isDetailFetching = another.isDetailFetching ?? false;
    isPaginationLoad = another.isPaginationLoad ?? false;
  }

  ProductState copyWith({
    List<ProductModel>? products,
    bool? isProductFetching,
    ProductModel? productDetail,
    bool? isDetailFetching,
    bool? isPaginationLoad,
  }) {
    return ProductState(
      products: products ?? this.products,
      isProductFetching: isProductFetching ?? this.isProductFetching,
      productDetail: productDetail ?? this.productDetail,
      isDetailFetching: isDetailFetching ?? this.isDetailFetching,
      isPaginationLoad: isPaginationLoad ?? this.isPaginationLoad,
    );
  }
}
