import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:givt_app_kids_web/features/recommendation/models/tag.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({required this.item, required this.size, super.key});
  final Size size;
  final Tag item;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.3,
      width: size.width * 0.25,
      padding: EdgeInsets.all(size.width * 0.005),
      child: Card(
          elevation: 25,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Color(0XFFFAF4D8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.network(item.pictureUrl),
              Text(
                item.displayText,
                style: TextStyle(
                    color: Color(0xFF405A66),
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              )
            ],
          )),
    );
  }
}
