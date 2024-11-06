import 'package:bayoum_store_app/helper/assets.dart';
import 'package:bayoum_store_app/helper/location.dart';
import 'package:bayoum_store_app/screens/auth/widgets/carouselslider.dart';
import 'package:bayoum_store_app/screens/auth/widgets/category_title_widget.dart';
import 'package:bayoum_store_app/screens/auth/widgets/men_products.dart';
import 'package:bayoum_store_app/screens/auth/widgets/search_bar.dart';
import 'package:bayoum_store_app/screens/auth/widgets/shimmer_item.dart';
import 'package:bayoum_store_app/screens/auth/widgets/women_product.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

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
  String? _currentAddress;
  Position? _currentPosition;
  String? message;
  List<Placemark> placemarks = [];

  Future<void> _getCurrentPosition(BuildContext context) async {
    final hasPermission = await GetLocation.handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

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
    _getCurrentPosition(context);
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
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_currentAddress.toString()),
                  const BannerWidget(),
                  const CategoryWidgetItems(),
                  const ChipWidget(),
                  const ProductPage(),
                  const CategoryTitleWidget(title: "Men's Products"),
                  const SizedBox(height: 5),
                  const MenProducts(),
                  const CategoryTitleWidget(title: "Women's Products"),
                  const SizedBox(height: 5),
                  const WomenProducts(),
                ],
              ),
            ),
          );
  }
}
