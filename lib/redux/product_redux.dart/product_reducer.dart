import 'package:redux/redux.dart';
import 'package:storeapp/data/product_model.dart';
import 'package:storeapp/redux/product_redux.dart/exporter.dart';

final productStore = Store<ProductState>(
  productReducer,
  initialState: ProductState.initial(),
);
ProductState productReducer(ProductState newState, dynamic action) {
  if (action is ProductActionFetch) {
    if (action.type == 'product fetched') {
      for (int i = 0; i < action.payloadData.length; i++) {
        newState.products?.add(ProductModel.fromMap(action.payloadData[i]));
      }
    } else if (action.type == "product detail fetched") {
      newState.productDetail = ProductModel.fromMap(action.payloadData);
    }
  } else if (action is ProductActionUpdate) {
    if (action.type == "update loader") {
      newState.isProductFetching = action.payloadData;
    } else if (action.type == "update detail loader") {
      newState.isDetailFetching = action.payloadData;
    } else if (action.type == 'update pagination loader') {
      newState.isPaginationLoad = action.payloadData;
    }
  }
  return newState;
}
