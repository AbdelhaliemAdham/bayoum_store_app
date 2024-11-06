import 'dart:io';

import 'package:bayoum_store_app/controlller/providers/cart_provider.dart';
import 'package:bayoum_store_app/controlller/providers/selected_size_provider.dart';
import 'package:bayoum_store_app/helper/assets.dart';
import 'package:bayoum_store_app/helper/fontthemes.dart';
import 'package:bayoum_store_app/helper/snackbar.dart';
import 'package:bayoum_store_app/screens/MainScreens/cartscreen.dart';
import 'package:bayoum_store_app/screens/inner-screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  final dynamic productDetails;

  const ProductDetailsScreen({super.key, this.productDetails});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late TextEditingController _whatsAppCotroller;
  String? contact;
  @override
  void initState() {
    super.initState();
    _whatsAppCotroller = TextEditingController(
      text: 'hey there !',
    );
  }

  int imageIndex = 0;
  String? whatsAppText;
  call() async {
    DocumentSnapshot<Map<String, dynamic>> vendorData = await _firebaseFirestore
        .collection('vendors')
        .doc(widget.productDetails['vendorId'])
        .get();

    Map<String, dynamic> data = vendorData.data() as Map<String, dynamic>;
    contact = '${data['phoneNumber']}';
    String url = 'tel:${data['phoneNumber']}';
    if (await canLaunchUrl(Uri.parse(url))) {
      launchUrl(Uri.parse(url));
    } else {
      throw 'Could not call $url';
    }
  }

  openWhatsapp(String contact, String whatsAppText) async {
    var androidUrl = "whatsapp://send?phone=$contact&text=$whatsAppText";
    var iosUrl = "https://wa.me/$contact?text=${Uri.parse(whatsAppText)}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      throw 'whatsApp is not installed';
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartData = ref.read(cartProvider.notifier);
    final cartItem = ref.watch(cartProvider);
    bool addedToCart = cartItem.containsKey(widget.productDetails['productId']);
    String size = ref.watch(sizeProvider);
    bool sizeSelectorOff = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productDetails['productName']),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    image: DecorationImage(
                      onError: (object, trace) {
                        Image.asset(Assets.default_image, fit: BoxFit.cover);
                      },
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        widget.productDetails['imagesUrlList'][imageIndex],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 20,
                  height: 70,
                  width: 200,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.productDetails['imagesUrlList'].length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              imageIndex = index;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.redAccent),
                                image: DecorationImage(
                                  onError: (object, trace) {
                                    Image.asset(Assets.default_image,
                                        fit: BoxFit.cover);
                                  },
                                  image: NetworkImage(widget
                                      .productDetails['imagesUrlList'][index]),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productDetails['productName'],
                    style: CustomFontStyle.large,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      '\$ ${widget.productDetails['productPrice']}',
                      style: CustomFontStyle.medium.copyWith(
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ExpansionTile(
                    title: Text(
                      'Product Discription',
                      style: CustomFontStyle.large,
                    ),
                    children: [
                      Text(
                        widget.productDetails['productDescription'],
                        style: CustomFontStyle.small.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  addedToCart == false
                      ? SizedBox(
                          height: 50,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  widget.productDetails['sizeList'].length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: sizeSelectorOff == true
                                      ? null
                                      : () {
                                          final selectedSize =
                                              widget.productDetails['sizeList']
                                                  [index];
                                          ref
                                              .read(sizeProvider.notifier)
                                              .selectSize(selectedSize);
                                        },
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 6.0,
                                          offset: Offset(2, 2),
                                        )
                                      ],
                                      color: size ==
                                              widget.productDetails['sizeList']
                                                  [index]
                                          ? Colors.redAccent
                                          : Colors.grey,
                                      shape: BoxShape.circle,
                                    ),
                                    margin: const EdgeInsets.all(5),
                                    child: Center(
                                      child: Text(
                                        widget.productDetails['sizeList']
                                            [index],
                                        style: CustomFontStyle.medium.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: CircleAvatar(
                      onBackgroundImageError: (object, trace) {},
                      radius: 30,
                      backgroundImage:
                          NetworkImage(widget.productDetails['vendorPictures']),
                    ),
                    title: Text(
                      widget.productDetails['businessName'],
                      style: CustomFontStyle.small,
                    ),
                    subtitle: Text(
                      'See Profile',
                      style: CustomFontStyle.verySmall
                          .copyWith(color: Colors.redAccent, fontSize: 13),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Expanded(
        flex: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: addedToCart
                  ? null
                  : () {
                      cartData.addProductToCart(
                        widget.productDetails['productName'],
                        widget.productDetails['productPrice'].toString(),
                        widget.productDetails['imagesUrlList'][0],
                        widget.productDetails['productQuantity'],
                        1,
                        widget.productDetails['vendorId'],
                        widget.productDetails['productId'],
                        size,
                      );

                      Get.to(() => const CartScreen());
                      HelperFun.showSnackBarWidegt(
                        'Product added to cart successfuly',
                        'Attention',
                      );
                    },
              child: Expanded(
                flex: 4,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 70,
                  width: 190,
                  decoration: BoxDecoration(
                      color: addedToCart ? Colors.grey : Colors.redAccent,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Add to cart',
                        style:
                            CustomFontStyle.large.copyWith(color: Colors.white),
                      ),
                      const Icon(CupertinoIcons.cart, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () => call(),
                child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Call',
                          style: CustomFontStyle.large
                              .copyWith(color: Colors.white),
                        ),
                        const Icon(
                          CupertinoIcons.phone,
                          color: Colors.white,
                        ),
                      ],
                    )),
              ),
            ),
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () async {
                  await showModalBottomSheet(
                      context: context,
                      builder: (builder) {
                        return Container(
                          height: 250.0,
                          color: Colors
                              .transparent, //could change this to Color(0xFF737373),
                          //so you don't have to change MaterialApp canvasColor
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(Assets.whatsApp,
                                              height: 50, width: 50),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'WhatsApp',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ChatScreen(
                                              buyerId: FirebaseAuth
                                                  .instance.currentUser!.uid,
                                              vendorId: widget
                                                  .productDetails['vendorId'],
                                              productId: widget
                                                  .productDetails['productId'],
                                              productName:
                                                  widget.productDetails[
                                                      'productName'],
                                              message: _whatsAppCotroller.text,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(Assets.phone,
                                                height: 50, width: 50),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'Out Chat',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 18),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width - 100,
                                  child: TextField(
                                    controller: _whatsAppCotroller,
                                    decoration: InputDecoration(
                                      suffixIcon: InkWell(
                                        onTap: () async {
                                          await openWhatsapp(
                                            contact ?? '+201142828110',
                                            _whatsAppCotroller.text,
                                          );
                                          debugPrint(contact);
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(3),
                                          padding: const EdgeInsets.all(5),
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.redAccent,
                                          ),
                                          child: const Icon(Icons.send,
                                              color: Colors.white),
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      // ignore: prefer_const_constructors
                                      label: Text('Message'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: Container(
                    margin: const EdgeInsets.all(5),
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Chat',
                          style: CustomFontStyle.large
                              .copyWith(color: Colors.white),
                        ),
                        const Icon(
                          CupertinoIcons.chat_bubble,
                          color: Colors.white,
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
