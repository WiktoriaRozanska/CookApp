import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ErrorBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 200.0),
      child: Center(
        child: Column(
          children: [
            const Text(
              'Unspeccted error',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const Text('Please try again later.'),
            const SizedBox(
              height: 20,
            ),
            SvgPicture.asset(
              'assets/images/undraw_cancel_u-1-it.svg',
              width: 190,
              height: 190,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
