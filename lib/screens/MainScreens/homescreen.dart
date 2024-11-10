import 'package:bayoum_store_app/controlller/services/local_notification.dart';
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
  bool canPoob = false;

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
            '${place.subAdministrativeArea}, ${place.administrativeArea}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  setLoader() async {
    await Future.delayed(
      const Duration(seconds: 3),
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
        : PopScope(
            canPop: canPoob,
            onPopInvoked: (value) async {
              await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      actionsAlignment: MainAxisAlignment.center,
                      backgroundColor: Colors.white,
                      title: const Text(
                        'Are you sure you want to exit ?',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            setState(() {
                              canPoob = true;
                              Navigator.of(context).pop(true);
                            });
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Yes',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              canPoob = false;
                              Navigator.of(context).pop(canPoob);
                            });
                          },
                          child: const Text(
                            'No',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            },
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              await LocalNotification.showLocalNotification(
                                  'haleem', 0, 'Hi Omer', 'Tezzak');
                            },
                            child: Image.asset(
                              Assets.store,
                              scale: 13,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            'Bayoum Store',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
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
                    _currentAddress == null
                        ? const SizedBox.shrink()
                        : Row(
                            children: [
                              const SizedBox(width: 10),
                              Image.asset(Assets.location,
                                  height: 25, width: 25),
                              const SizedBox(width: 10),
                              Text(
                                'Current Location:  ${_currentAddress.toString()}',
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.blueGrey),
                              ),
                            ],
                          ),
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
            ),
          );
  }
}
