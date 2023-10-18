import 'package:flutter_redux/flutter_redux.dart';
import 'package:storeapp/presentation/product_listing/screens/screens.dart';
import 'package:storeapp/presentation/splash_screen/splash_screen.dart';
import 'package:storeapp/redux/redux.dart';
import 'package:storeapp/utils/utils.dart';

class ProductViewModel {
  final ProductRepository _productRepository;
  ProductViewModel(this._productRepository);

  Future getProducts(BuildContext context, int page) async {
    updateLoading(context, true, page);
    var data = await _productRepository.fetchProducts(page);
    if (data.isNotEmpty) {
      if (context.mounted) {
        StoreProvider.of<ProductState>(context).dispatch(
          ProductActionFetch(
            type: 'product fetched',
            payloadData: data,
          ),
        );
      }
    }
    if (context.mounted) updateLoading(context, false, page);
  }

  Future getProductDetail(BuildContext context, int productId) async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => const ProductDetailScreen(),
    ));
    updateDetailFetching(context, true);
    var data = await _productRepository.fetchSingleProduct(productId);
    if (data.isNotEmpty) {
      if (context.mounted) {
        StoreProvider.of<ProductState>(context).dispatch(
          ProductActionFetch(
            payloadData: data,
            type: 'product detail fetched',
          ),
        );
      }
    }
    if (context.mounted) {
      updateDetailFetching(context, false);
    }
  }

  void updateLoading(BuildContext context, bool value, int pageNo) {
    StoreProvider.of<ProductState>(context).dispatch(
      ProductActionUpdate(
        payloadData: value,
        type: pageNo == 1 ? 'update loader' : 'update pagination loader',
      ),
    );
  }

  void updateDetailFetching(BuildContext context, bool value) {
    StoreProvider.of<ProductState>(context).dispatch(
      ProductActionUpdate(
        payloadData: value,
        type: 'update detail loader',
      ),
    );
  }
}
