import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return InkWell(
      onTap: (){
        print('TAP!');
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: size.width*0.8,
        decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(20), 
         color: Theme.of(context).primaryColor,
        ),
        padding: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}