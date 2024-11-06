import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerItem extends StatelessWidget {
  const ShimmerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shimmer Placeholder for Photo Image
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade200,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  width: 350,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade200,
            child: SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemExtent: 100,
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.only(left: 15, top: 10),
                      child: CircleAvatar(
                        radius: 150,
                      ),
                    );
                  }),
            ),
          ),
          SizedBox(
            height: 400,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemExtent: 120,
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade200,
                      child: Container(
                        height: 100,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 120.0,
                              height: 50.0,
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade200,
                                child: Container(
                                  margin: EdgeInsets.only(left: 10, bottom: 10),
                                  width: 120.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Shimmer Placeholder for Photo Image

                                SizedBox(
                                  width: 120.0,
                                  height: 100.0,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade200,
                                    child: Container(
                                      margin: EdgeInsets.only(left: 10),
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                // const SizedBox(
                                //   width: 12,
                                // ),
                                // Expanded(
                                //   child: Column(
                                //     crossAxisAlignment: CrossAxisAlignment.start,
                                //     mainAxisAlignment: MainAxisAlignment.start,
                                //     children: [
                                //       // Shimmer for Photo Title
                                //       Shimmer.fromColors(
                                //         baseColor: Colors.grey.shade300,
                                //         highlightColor: Colors.grey.shade200,
                                //         child: Container(
                                //           height: 20,
                                //           decoration: BoxDecoration(
                                //             borderRadius:
                                //                 BorderRadius.circular(12.0),
                                //             color: Colors.white,
                                //           ),
                                //         ),
                                //       ),
                                //       const SizedBox(
                                //         height: 8,
                                //       ),
                                //       // Shimmer for Description
                                //       Shimmer.fromColors(
                                //         baseColor: Colors.grey.shade300,
                                //         highlightColor: Colors.grey.shade200,
                                //         child: Container(
                                //           height: 20,
                                //           width: 100,
                                //           decoration: BoxDecoration(
                                //             borderRadius:
                                //                 BorderRadius.circular(12.0),
                                //             color: Colors.white,
                                //           ),
                                //         ),
                                //       ),
                                //       const SizedBox(
                                //         height: 8,
                                //       ),
                                //       // Shimmer for Another Description
                                //       Shimmer.fromColors(
                                //         baseColor: Colors.grey.shade300,
                                //         highlightColor: Colors.grey.shade200,
                                //         child: Container(
                                //           height: 20,
                                //           width: 50,
                                //           decoration: BoxDecoration(
                                //             borderRadius:
                                //                 BorderRadius.circular(12.0),
                                //             color: Colors.white,
                                //           ),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
