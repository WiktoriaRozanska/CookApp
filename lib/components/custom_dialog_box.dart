import 'package:flutter/material.dart';
import 'package:day_picker/day_picker.dart';

showCustomDialogBox(BuildContext context,
    {required String title, required String description}) {
  return showGeneralDialog(
    context: context,
    barrierLabel: '',
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return CustomDialogBox(title: title, description: description);
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        child: child,
        scale: Tween<double>(end: 1.0, begin: 0).animate(CurvedAnimation(
            parent: animation,
            curve: const Interval(0.00, 0.50, curve: Curves.linear))),
      );
    },
  );
}

class CustomDialogBox extends StatelessWidget {
  final _borderRadius = 20.0;
  final String title, description;

  List<DayInWeek> _days = [
    DayInWeek("Mon", isSelected: true),
    DayInWeek(
      "Tue",
    ),
    DayInWeek(
      "Wed",
    ),
    DayInWeek(
      "Thu",
    ),
    DayInWeek(
      "Fri",
    ),
    DayInWeek(
      "Sat",
    ),
    DayInWeek(
      "Sun",
    ),
  ];

  CustomDialogBox({Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Dialog(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius)),
        child: Stack(
          children: [
            Container(
              width: _width,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.only(
                  top: 24, left: 10, right: 10, bottom: 80),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(_borderRadius)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 1.5,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(
                          16,
                          (_index) => Container(
                                width: 6,
                                height: 1.5,
                                color: Colors.black,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2),
                              )),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: SelectWeekDays(
                        days: _days,
                        fontSize: 11,
                        border: false,
                        boxDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            colors: [
                              const Color(0xFF00BFA6),
                              const Color(0xFF0AE6C7)
                            ],
                            tileMode: TileMode
                                .repeated, // repeats the gradient over the canvas
                          ),
                        ),
                        onSelect: (values) {
                          // <== Callback to handle the selected days
                          print(values);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: -3,
              child: RaisedButton(
                elevation: 4,
                color: Theme.of(context).primaryColor,
                clipBehavior: Clip.antiAlias,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'SAVE',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
