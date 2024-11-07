import 'package:bayoum_store_app/screens/inner-screens/category_details_screens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final Stream<QuerySnapshot> _categoryStrean =
      FirebaseFirestore.instance.collection('Categories').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        shadowColor: Colors.grey.withOpacity(0.9),
        title: const Text(
          'Categories',
          style: TextStyle(
              fontSize: 22, letterSpacing: 3, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: _categoryStrean,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.docs.isNotEmpty) {
              return Skeletonizer(
                enabled: snapshot.connectionState == ConnectionState.waiting,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6.0,
                      mainAxisExtent: 210,
                      childAspectRatio: 1 / 1,
                    ),
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryDetailsScreen(
                                  categoryData: data,
                                ),
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.9),
                                  offset: const Offset(0.0, 2.0),
                                  blurRadius: 4,
                                ),
                              ]),
                          child: Column(children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Image.network(
                                data['Image'],
                                height: 150,
                                width: 180,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              data['CategoryName'],
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          ]),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            }
            return const Center(
              child: Text('Sorry, Some thing wrong happend !!'),
            );
          },
        ),
      ),
    );
  }
}
