// ignore_for_file: unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomNavBarCurved extends StatefulWidget {
  const CustomNavBarCurved({super.key});

  @override
  CustomNavBarCurvedState createState() => CustomNavBarCurvedState();
}

class CustomNavBarCurvedState extends State<CustomNavBarCurved> {
  int _selectedIndex = 0;

  void _onNavBarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = 56;

    const primaryColor =  Color(0xFFFFD700), 
     secondaryColor = Colors.black54;
    const backgroundColor = Color.fromARGB(46, 88, 252, 216);

    return Container(
      width: double.infinity, // Ensure full width
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, height + 10),
              painter: BottomNavCurvePainter(backgroundColor: backgroundColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: const Color(0xFFFFD700),
              elevation: 5, // Increase for better shadow effect
              onPressed: () {},
              child: const Icon(CupertinoIcons.book, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20), // Reduce extra space
            child: SizedBox(
              height: height,
              width: double.infinity, // Full width
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Distribute evenly
                children: [
                  NavBarIcon(
                    text: "Home",
                    icon: CupertinoIcons.home,
                    selected: _selectedIndex == 0,
                    onPressed: () => _onNavBarItemTapped(0),
                    defaultColor: secondaryColor,
                    selectedColor:  const Color(0xFFFFD700),
                  ),
                  NavBarIcon(
                    text: "Search",
                    icon: CupertinoIcons.search,
                    selected: _selectedIndex == 1,
                    onPressed: () => _onNavBarItemTapped(1),
                    defaultColor: secondaryColor,
                    selectedColor:  const Color(0xFFFFD700),
                  ),
                  const SizedBox(width: 50), // Space for FAB
                  NavBarIcon(
                    text: "Cart",
                    icon: Icons.local_grocery_store_outlined,
                    selected: _selectedIndex == 2,
                    onPressed: () => _onNavBarItemTapped(2),
                    defaultColor: secondaryColor,
                    selectedColor:  const Color(0xFFFFD700),
                  ),
                  NavBarIcon(
                    text: "Profile",
                    icon: CupertinoIcons.person,
                    selected: _selectedIndex == 3,
                    onPressed: () => _onNavBarItemTapped(3),
                    selectedColor:   const Color(0xFFFFD700),
                    defaultColor: secondaryColor,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavCurvePainter extends CustomPainter {
  BottomNavCurvePainter(
      {this.backgroundColor = Colors.black, this.insetRadius = 38});

  final Color backgroundColor;
  final double insetRadius;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 0);

    double insetCurveBeginnningX = size.width / 2 - insetRadius;
    double insetCurveEndX = size.width / 2 + insetRadius;
    double transitionToInsetCurveWidth = size.width * .05;

    path.quadraticBezierTo(size.width * 0.20, 0,
        insetCurveBeginnningX - transitionToInsetCurveWidth, 0);
    path.quadraticBezierTo(
        insetCurveBeginnningX, 0, insetCurveBeginnningX, insetRadius / 2);

    path.arcToPoint(Offset(insetCurveEndX, insetRadius / 2),
        radius: const Radius.circular(10.0), clockwise: false);

    path.quadraticBezierTo(
        insetCurveEndX, 0, insetCurveEndX + transitionToInsetCurveWidth, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class NavBarIcon extends StatelessWidget {
  const NavBarIcon({
    super.key,
    required this.text,
    required this.icon,
    required this.selected,
    required this.onPressed,
    this.selectedColor = const Color(0xffFF8527),
    this.defaultColor = Colors.black54,
  });

  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;
  final Color defaultColor;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      icon: CircleAvatar(
        backgroundColor: selected ?  const Color(0xFFFFD700): Colors.transparent,
        child: Icon(
          icon,
          size: 25,
          color: selected ?  Colors.black: defaultColor,
        ),
      ),
    );
  }
}
