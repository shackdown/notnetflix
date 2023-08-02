import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color bgColor;
  final Color contentColor;

  const ActionButton({
    Key? key,
    required this.icon,
    required this.bgColor,
    required this.contentColor,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(5), color: bgColor),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(icon, color: contentColor),
        const SizedBox(height: 5),
        Text(label,
            style: GoogleFonts.poppins(
                color: contentColor, fontSize: 16, fontWeight: FontWeight.w600))
      ]),
    );
  }
}
