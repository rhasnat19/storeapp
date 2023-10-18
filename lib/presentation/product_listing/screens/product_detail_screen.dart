import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:storeapp/redux/redux.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<ProductState, ProductState>(
        converter: (store) => store.state,
        onDispose: (store) {
          store.state.productDetail = null;
        },
        builder: (context, data) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: const Text(
                "Product detail",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: false,
              titleSpacing: 0,
            ),
            body: (data.isDetailFetching ?? false)
                ? const Center(child: CircularProgressIndicator.adaptive())
                : Padding(
                    padding: const EdgeInsets.all(14),
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 15),
                          Container(
                            height: 300,
                            padding: const EdgeInsets.all(15),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Image.network(
                              data.productDetail?.image ?? "",
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            data.productDetail?.title ?? "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Description: ",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            data.productDetail?.description ?? "",
                            style: const TextStyle(fontSize: 14),
                            maxLines: 20,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Text(
                                "Price: ",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "\$${data.productDetail?.price ?? ""}",
                                style: const TextStyle(fontSize: 24),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Rating ",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "count: ${data.productDetail?.rating?.count ?? ""} \n"
                            "rating: ${data.productDetail?.rating?.rating ?? "not available"}",
                            style: const TextStyle(fontSize: 14),
                            maxLines: 20,
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
          );
        });
  }
}
