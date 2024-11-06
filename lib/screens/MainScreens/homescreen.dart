import 'package:bayoum_store_app/helper/assets.dart';
import 'package:bayoum_store_app/screens/auth/widgets/carouselslider.dart';
import 'package:bayoum_store_app/screens/auth/widgets/category_title_widget.dart';
import 'package:bayoum_store_app/screens/auth/widgets/men_products.dart';
import 'package:bayoum_store_app/screens/auth/widgets/search_bar.dart';
import 'package:bayoum_store_app/screens/auth/widgets/shimmer_item.dart';
import 'package:bayoum_store_app/screens/auth/widgets/women_product.dart';
import 'package:flutter/material.dart';

import '../auth/widgets/categories_list_widget.dart';
import '../auth/widgets/chip_widget.dart';
import '../auth/widgets/productPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;

  setLoader() async {
    await Future.delayed(
      const Duration(seconds: 4),
    ).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setLoader();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return const ShimmerItem();
                },
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          Assets.store,
                          scale: 11,
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          'Bayoum Store',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Dm Sans',
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () async {
                          await showSearch(
                            context: context,
                            delegate: SearchDelegateBar(),
                          );
                        },
                        icon: const Icon(Icons.search),
                      ),
                    ),
                  ],
                ),
              ),
              titleSpacing: 2,
            ),
            body: const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BannerWidget(),
                  CategoryWidgetItems(),
                  ChipWidget(),
                  ProductPage(),
                  CategoryTitleWidget(title: "Men's Products"),
                  SizedBox(height: 5),
                  MenProducts(),
                  CategoryTitleWidget(title: "Women's Products"),
                  SizedBox(height: 5),
                  WomenProducts(),
                ],
              ),
            ),
          );
  }
}
