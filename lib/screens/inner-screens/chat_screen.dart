// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bayoum_store_app/helper/fontthemes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String? buyerId;
  final String? vendorId;
  final String? productId;
  final String? productName;
  final String? message;

  const ChatScreen({
    super.key,
    this.buyerId,
    this.vendorId,
    this.productId,
    this.productName,
    this.message,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController _controller;
  late Stream<QuerySnapshot> _stream;
  void sendMessage() async {
    DocumentSnapshot vendorDoc =
        await _firestore.collection('vendors').doc(widget.vendorId).get();
    DocumentSnapshot buyerDoc =
        await _firestore.collection('buyers').doc(widget.buyerId).get();
    String message = _controller.text.trim();
    if (message.isNotEmpty) {
      await _firestore.collection('chats').add({
        'buyerId': widget.buyerId,
        'vendorId': widget.vendorId,
        'productId': widget.productId,
        'productName': widget.productName,
        'message': message,
        'timestamp': Timestamp.now(),
        'senderId': FirebaseAuth.instance.currentUser!.uid,
        'vendorPhoto':
            (vendorDoc.data() as Map<String, dynamic>)['vendorPictures'],
        'buyerPhoto': (buyerDoc.data() as Map<String, dynamic>)['photo'],
        'buyerName': (buyerDoc.data() as Map<String, dynamic>)['fullName'],
      });
    }
    _controller.clear();
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.message);
    _stream = _firestore
        .collection('chats')
        .where('buyerId', isEqualTo: widget.buyerId)
        .where('vendorId', isEqualTo: widget.vendorId)
        .where('productId', isEqualTo: widget.productId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Chat',
              style: CustomFontStyle.veryLarg.copyWith(color: Colors.red),
            ),
            Text('${widget.productName}'),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: _stream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Something went wrong'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ListView(
                      reverse: true,
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;

                        bool isBuyer = data['senderId'] == data['buyerId'];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              decoration: BoxDecoration(
                                color: isBuyer
                                    ? Colors.grey.shade200
                                    : Colors.redAccent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                title: Text(
                                  data['message'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        isBuyer ? Colors.black : Colors.white,
                                  ),
                                ),
                                subtitle: Text(
                                  data['buyerName'],
                                  style: TextStyle(
                                    color:
                                        isBuyer ? Colors.black : Colors.white,
                                  ),
                                ),
                                trailing: Text(
                                  isBuyer ? 'Customer' : 'Vendor',
                                  style: TextStyle(
                                    color:
                                        isBuyer ? Colors.black : Colors.white,
                                  ),
                                ),
                                leading: CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      NetworkImage(data['buyerPhoto']),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text(
                                date(data['timestamp'].toDate()),
                              ),
                            )
                          ],
                        );
                      }).toList(),
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                          hintText: 'type your text here',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 8),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          )),
                    ),
                  ),
                ),
                InkWell(
                  onTap: sendMessage,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.redAccent,
                    ),
                    child:
                        const Icon(Icons.send, color: Colors.white, size: 25),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

String date(DateTime date) {
  return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
}
