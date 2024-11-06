import 'package:bayoum_store_app/controlller/services/category_contoller.dart';
import 'package:bayoum_store_app/screens/inner-screens/category_details_screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helper/AppPages.dart';

class CategoryWidgetItems extends StatelessWidget {
  const CategoryWidgetItems({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryController categoryController = Get.find<CategoryController>();
    return SizedBox(
      height: 170,
      width: MediaQuery.of(context).size.width - 20,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Dm Sans',
                    fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(
                    AppPages.categoryScreen,
                  );
                },
                child: const Text(
                  'See all',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Dm Sans',
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: categoryController.categories.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 35,
                    backgroundImage: Image.network(
                      categoryController.categories[index].imageUrl,
                      height: 70,
                    ).image,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    categoryController.categories[index].categoryName,
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
