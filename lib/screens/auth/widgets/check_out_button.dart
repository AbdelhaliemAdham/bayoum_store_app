import 'package:flutter/material.dart';

class ProceedButton extends StatelessWidget {
  const ProceedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Colors.white,
            blurRadius: 3,
            spreadRadius: 3,
          ),
        ],
        color: Colors.redAccent.shade700,
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Proceed to CheckOut',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Dm Sans',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
