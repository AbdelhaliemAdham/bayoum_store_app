import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    String? productName;
    final Stream<QuerySnapshot<Map<String, dynamic>>> productStreem =
        FirebaseFirestore.instance
            .collection('products')
            .where(
              'productName',
              isEqualTo: productName,
            )
            .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2.0),
        ),
      ),
      body: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Type the product name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (product) {
              setState(() {
                productName = product;
              });
            },
          ),
          StreamBuilder<QuerySnapshot>(
            stream: productStreem,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }

              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('There is no Product under this category'),
                );
              }
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  childAspectRatio: 2 / 3,
                  mainAxisSpacing: 8,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final product = snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      elevation: 4,
                      margin: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Container(
                            height: 170,
                            width: 170,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    NetworkImage(product['imagesUrlList'][0]),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              product['productName'],
                              style: const TextStyle(
                                fontSize: 20,
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '\$${product['productPrice']}',
                              style: const TextStyle(
                                fontSize: 20,
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
