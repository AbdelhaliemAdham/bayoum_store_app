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
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetails extends ConsumerStatefulWidget {
  final dynamic productDetails;

  const ProductDetails({super.key, this.productDetails});

  @override
  ConsumerState<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends ConsumerState<ProductDetails> {
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
    int imageIndex = 0;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF5F6F9),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 20, bottom: 10, left: 10, right: 10),
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 1,
                        spreadRadius: 1,
                      ),
                    ]),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.red),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 1,
                        spreadRadius: 1,
                      ),
                    ]),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      NetworkImage(widget.productDetails['vendorPictures']),
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                  Assets.whatsApp,
                                                  height: 50,
                                                  width: 50),
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
                                                builder: (context) =>
                                                    ChatScreen(
                                                  buyerId: FirebaseAuth.instance
                                                      .currentUser!.uid,
                                                  vendorId:
                                                      widget.productDetails[
                                                          'vendorId'],
                                                  productId:
                                                      widget.productDetails[
                                                          'productId'],
                                                  productName:
                                                      widget.productDetails[
                                                          'productName'],
                                                  message:
                                                      _whatsAppCotroller.text,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
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
                                      width: MediaQuery.of(context).size.width -
                                          100,
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
                  ),
                ),
              ),
            ],
          ),
          Stack(children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.network(
                      widget.productDetails['imagesUrlList'][imageIndex],
                      fit: BoxFit.cover,
                    ).image,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 300,
              left: 50,
              width: MediaQuery.of(context).size.width * 0.8,
              height: 70,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.productDetails['imagesUrlList'].length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          imageIndex = index;
                        });
                      },
                      child: AnimatedContainer(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange),
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        duration: const Duration(
                          seconds: 1,
                        ),
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Image.network(
                            widget.productDetails['imagesUrlList'][index],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ]),
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Text(
                        widget.productDetails['productName'],
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: IconButton(
                            onPressed: () async {
                              await Share.share(
                                  'check this product ${widget.productDetails['productName']}',
                                  subject:
                                      '${widget.productDetails['imagesUrlList'][0]}');
                            },
                            icon: const Icon(Icons.share, color: Colors.red),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: IconButton(
                            onPressed: () {
                              call();
                            },
                            icon: const Icon(Icons.call, color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    '\$ ${widget.productDetails['productPrice']}',
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
                    child: Text(
                      '${widget.productDetails['productDescription']}',
                      maxLines: 3,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                TopRoundedContainer(
                  color: const Color(0xFFF5F6F9),
                  child: Row(
                    children: [
                      addedToCart == false
                          ? SizedBox(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              child: Expanded(
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: widget
                                        .productDetails['sizeList'].length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: sizeSelectorOff == true
                                            ? null
                                            : () {
                                                final selectedSize =
                                                    widget.productDetails[
                                                        'sizeList'][index];
                                                ref
                                                    .read(sizeProvider.notifier)
                                                    .selectSize(selectedSize);
                                              },
                                        child: Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 6.0,
                                                offset: Offset(2, 2),
                                              )
                                            ],
                                            color: size ==
                                                    widget.productDetails[
                                                        'sizeList'][index]
                                                ? Colors.redAccent
                                                : Colors.grey,
                                            shape: BoxShape.circle,
                                          ),
                                          margin: const EdgeInsets.all(5),
                                          child: Center(
                                            child: Text(
                                              widget.productDetails['sizeList']
                                                  [index],
                                              style: CustomFontStyle.medium
                                                  .copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
      bottomNavigationBar: TopRoundedContainer(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: addedToCart ? Colors.grey : Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 55),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
              onPressed: addedToCart
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
              child: Text(
                addedToCart ? 'Product Added to the Cart' : "Add To Cart",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TopRoundedContainer extends StatelessWidget {
  const TopRoundedContainer({
    super.key,
    required this.color,
    required this.child,
  });
  final Color? color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: child,
    );
  }
}
