import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:storeapp/presentation/product_listing/widget/widget.dart';
import 'package:storeapp/redux/product_redux.dart/product_state.dart';
import 'package:storeapp/utils/di/di.dart';
import 'package:storeapp/viewmodels/product/product_viewmodel.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({super.key});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  var productViewModel = getIt<ProductViewModel>();
  int pageNo = 1;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        await productViewModel
            .getProducts(context, pageNo)
            .then((value) => setState(() => pageNo++));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<ProductState, ProductState>(
        converter: (store) => store.state,
        onInit: (store) async {
          await productViewModel
              .getProducts(context, pageNo)
              .then((value) => setState(() => pageNo++));
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(height: 60),
                    const Text(
                      "Products",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (!(state.isProductFetching ?? false)) ...[
                      const SizedBox(height: 20),
                      if ((state.products?.length ?? 0) > 0)
                        ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.products?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () => productViewModel.getProductDetail(
                                context,
                                state.products?[index].id ?? 1,
                              ),
                              child: ProductItem(
                                product: state.products?[index],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                        )
                      else
                        const Center(
                          child: Text("No Item Found"),
                        ),
                      if (state.isPaginationLoad ?? false) ...[
                        const SizedBox(height: 20),
                        const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator.adaptive(),
                              Text("Loading...")
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                      const SizedBox(height: 40)
                    ] else
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 1.2,
                        child: const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
