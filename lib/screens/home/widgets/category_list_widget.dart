import 'package:flutter/material.dart';
import 'package:user_login/models/category_model.dart';
import 'package:get/get.dart';
import 'package:user_login/screens/home/controller/home_controller.dart';

class CategoryListWidget extends StatelessWidget {
  CategoryListWidget(
      {super.key,
      required this.categoryModel,
      required this.selectedIndex,
      required this.homeController});
  final CategoryModel categoryModel;
  RxInt selectedIndex;
  HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height,
      height: MediaQuery.of(context).size.width * 0.24,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: categoryModel.subCategoryList?.length ?? 0,
        itemBuilder: (context, index) {
          final item = categoryModel.subCategoryList?[index];

          return Obx(() => GestureDetector(
                onTap: () {
                  selectedIndex.value = index;
                  homeController.categoryById(item?.subCategoryId ?? '');
                },
                child: Card(
                  margin: const EdgeInsets.all(8),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Container(
                    decoration: BoxDecoration(
                        color: selectedIndex.value == index
                            ? Colors.blue
                            : Colors.white,
                        borderRadius: BorderRadius.circular(50)),
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(45),
                          ),
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              item?.subCategoryImage ?? '',
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Text(
                            item?.subCategoryName ?? '',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
