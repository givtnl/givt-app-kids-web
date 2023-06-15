// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:givt_app_kids_web/features/recommendation/utils/font_utils.dart';

class OrganizationItem extends StatelessWidget {
  const OrganizationItem({
    super.key,
    required this.width,
    required this.height,
    required this.name,
    required this.description,
    required this.pictureURL,
    required this.qrCodeURL,
  });

  final double width;
  final double height;
  final String name;
  final String description;
  final String pictureURL;
  final String qrCodeURL;

  @override
  Widget build(BuildContext context) {
    const margin = 10.0;
    const padding = 25.0;
    final availableWidth = width - (margin * 2 + padding * 2);
    final availableHeight = height - (margin * 2 + padding * 2);

    return SizedBox(
      width: width,
      height: height,
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        margin: const EdgeInsets.all(margin),
        child: Padding(
          padding: const EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: availableHeight * .20,
                width: double.infinity,
                child: Container(
                  // color: Colors.blue,
                  child: Image.network(
                    pictureURL,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              SizedBox(
                height: availableHeight * .19,
                width: double.infinity,
                child: Container(
                  alignment: Alignment.center,
                  // color: Colors.amber,
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      fontSize: FontUtils.getScaledFontSize(
                          inputFontSize: 25,
                          availableWidth: availableWidth,
                          availableHeight: availableHeight),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: availableHeight * .25,
                child: Container(
                  alignment: Alignment.center,
                  // color: Colors.yellow,
                  child: Text(
                    description,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: FontUtils.getScaledFontSize(
                          inputFontSize: 14,
                          availableWidth: availableWidth,
                          availableHeight: availableHeight),
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: availableHeight * .125,
                child: Container(
                  // color: Colors.yellow,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        width: 25,
                      ),
                      Text(
                        'Scan\nto give',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: FontUtils.getScaledFontSize(
                              inputFontSize: 16,
                              availableWidth: availableWidth,
                              availableHeight: availableHeight),
                          color: const Color(0xFF54A1EE),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        children: [
                          SizedBox(height: (availableHeight * 0.125) * 0.35),
                          SvgPicture.asset(
                            'images/scan_to_give_arrow.svg',
                            fit: BoxFit.fitHeight,
                            height: (availableHeight * 0.125) * .65,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: availableHeight * .010,
                child: Container(
                    // color: Colors.grey,
                    ),
              ),
              SizedBox(
                height: availableHeight * .20,
                child: Image.network(
                  qrCodeURL,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
