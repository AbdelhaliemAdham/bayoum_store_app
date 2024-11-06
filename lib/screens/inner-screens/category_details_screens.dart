import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> categoryData;

  const CategoryDetailsScreen({super.key, required this.categoryData});

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot<Map<String, dynamic>>> productStreem =
        FirebaseFirestore.instance
            .collection('products')
            .where(
              'productCategory',
              isEqualTo: widget.categoryData['CategoryName'],
            )
            .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryData['CategoryName'],
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2.0),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: productStreem,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          if (snapshot.data!.docs.isNotEmpty) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                childAspectRatio: 2 / 3,
                mainAxisSpacing: 4,
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final product = snapshot.data!.docs[index];
                return SizedBox(
                  height: 250,
                  width: 250,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      elevation: 4,
                      margin: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              height: 250,
                              width: 250,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      NetworkImage(product['imagesUrlList'][0]),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
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
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
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
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: Text('Sorry, Some thing wrong happend !!'),
          );
        },
      ),
    );
  }
}
