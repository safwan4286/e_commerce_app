import 'package:flutter/material.dart';
import 'package:user_login/models/product_model.dart';
import 'package:get/get.dart';

class ProductListWidget extends StatelessWidget {
  ProductListWidget({super.key, required this.productList});
  List<ProductList>? productList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisExtent: MediaQuery.of(context).size.height * 0.28,
          mainAxisSpacing: 10),
      itemCount: productList?.length ?? 0,
      itemBuilder: (context, index) {
        final item = productList?[index];

        return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            margin: const EdgeInsets.all(10),
            elevation: 5,
            child: GridTile(
                footer: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.9),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)),
                  ),
                  child: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(left: 10),
                          width: 120,
                          child: Text(
                            item?.productName ?? '',
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite,
                          ))
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.network(item?.productImage ?? ''),
                )));
      },
    );
  }
}
