import 'package:bayoum_store_app/screens/auth/widgets/progress_indeicator.dart';
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
        title: const Text(
          'Categories',
          style: TextStyle(
              fontSize: 20, letterSpacing: 2, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _categoryStrean,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 1 / 1.5,
                ),
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade300,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                offset: const Offset(0.0, 2.0),
                                blurRadius: 4,
                              ),
                            ]),
                        child: Column(children: [
                          Image.network(
                            data['Image'],
                            height: 200,
                            width: 220,
                            fit: BoxFit.fill,
                          ),
                          const SizedBox(height: 15),
                          Text(
                            data['CategoryName'],
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ]),
                      ),
                    ),
                  );
                  // return ListTile(
                  //   title: Text(data['CategoryName']),
                  //   subtitle: Image.network(data['Image']),
                  // );
                }).toList(),
              ),
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
