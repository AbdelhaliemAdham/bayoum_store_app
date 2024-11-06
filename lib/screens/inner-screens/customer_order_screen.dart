import 'package:bayoum_store_app/helper/fontthemes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomerOrderScreen extends StatefulWidget {
  CustomerOrderScreen({super.key});

  @override
  State<CustomerOrderScreen> createState() => _CustomerOrderScreenState();
}

class _CustomerOrderScreenState extends State<CustomerOrderScreen> {
  final Stream<QuerySnapshot> _ordersStream = FirebaseFirestore.instance
      .collection('orders')
      .where('buyerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          onPressed: () async {
            if (!_scrollController.hasClients) {
              await _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut);
            }
          },
          child: const Icon(
            Icons.arrow_downward_outlined,
            color: Colors.white,
          )),
      appBar: AppBar(
        title: Text(
          'Orders',
          style: CustomFontStyle.large,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _ordersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: Colors.yellow.shade900),
              );
            }

            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  'You did n\'t ordered any thing yet !',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 24,
                  ),
                ),
              );
            }
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: ListView(
                      controller: _scrollController,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: snapshot.data!.docs.map((queryDoc) {
                        Map<String, dynamic> data =
                            queryDoc.data() as Map<String, dynamic>;
                        bool accepted = data['accepted'];
                        return Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade600,
                                ),
                                const BoxShadow(
                                  color: Colors.white,
                                )
                              ]),
                          child: Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 20,
                                  child: accepted
                                      ? const Icon(
                                          Icons.delivery_dining,
                                          color: Colors.green,
                                        )
                                      : const Icon(
                                          Icons.access_time,
                                          color: Colors.red,
                                        ),
                                ),
                                title: accepted
                                    ? Text('order accepted',
                                        style: CustomFontStyle.large
                                            .copyWith(color: Colors.green))
                                    : Text('not accepted yet',
                                        style: CustomFontStyle.large
                                            .copyWith(color: Colors.red)),
                                trailing: Text(
                                  '\$ ${data['price']}',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                ),
                              ),
                              ExpansionTile(
                                title: const Text(
                                  'View order details',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 40,
                                        margin: const EdgeInsets.all(8),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        child: OverflowBox(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CircleAvatar(
                                                radius: 20,
                                                backgroundImage:
                                                    NetworkImage(data['photo']),
                                              ),
                                              Text(
                                                  'Product-Name : ${data['productName']}'),
                                              Text(
                                                  'Quantity : ${data['quantity']}'),
                                            ],
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        title: const Text(
                                          'Buyer Details',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Email : ${data['email']}'),
                                            Text(
                                                'Full Name: ${data['fullName']}'),
                                            Text(
                                                'Order-Date : ${getFormattedDate(
                                              data['orderDate'].toDate(),
                                            )}')
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

String getFormattedDate(DateTime date) {
  return '${date.day}/${date.month}/${date.year}';
}
