// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';
import 'package:givt_app_kids_web/core/app/pages.dart';
import 'package:givt_app_kids_web/features/recommendation/organisations/cubit/organisations_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/organisations/models/organisation.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/organisation_header.dart';
import 'package:givt_app_kids_web/utils/font_utils.dart';
import 'package:go_router/go_router.dart';

class OrganisationItem extends StatelessWidget {
  const OrganisationItem({
    super.key,
    required this.width,
    required this.height,
    required this.organisation,
    required this.isFlipped,
  });

  final double width;
  final double height;
  final Organisation organisation;
  final bool isFlipped;

  @override
  Widget build(BuildContext context) {
    const margin = 20.0;
    final availableHeight = height - margin * 2;
    Image image = Image.network(
      organisation.qrCodeURL,
      fit: BoxFit.cover,
    );

    precacheImage(image.image, context);

    final size = MediaQuery.sizeOf(context);
    return Container(
        margin: const EdgeInsets.all(margin),
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                context
                    .read<OrganisationsCubit>()
                    .flipOrganisation(organisation);
              },
              borderRadius: BorderRadius.circular(25.0),
              child: Card(
                elevation: 10,
                color: isFlipped ? const Color(0xFFC7DFBC) : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(availableHeight * 0.07),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(availableHeight * 0.07),
                  child: Column(
                    children: [
                      SizedBox(
                        height: availableHeight * 0.24,
                        child: OrganisationHeader(
                          organisation: organisation,
                        ),
                      ),
                      isFlipped
                          ? Container(
                              height: availableHeight * 0.63,
                              child: Card(
                                margin: EdgeInsets.zero,
                                elevation: 0,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      availableHeight * 0.07),
                                ),
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          height: availableHeight * 0.5,
                                          width: availableHeight * 0.5,
                                          padding: EdgeInsets.only(
                                            top: 20,
                                            left: 20,
                                            right: 20,
                                          ),
                                          child: image,
                                        ),
                                        Container(
                                          height: availableHeight * 0.13,
                                          width: double.infinity,
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Scan with the\nGivt4Kids app to donate',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize:
                                                  FontUtils.getScaledFontSize(
                                                      inputFontSize: 18,
                                                      size: size),
                                              color: const Color(0xFF54A1EE),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      right: 30,
                                      top: availableHeight * 0.45,
                                      child: SvgPicture.asset(
                                        'images/scan_to_give_arrow.svg',
                                        fit: BoxFit.fitHeight,
                                        height: size.height * .1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  height: availableHeight * 0.51,
                                  child: Image.network(
                                    organisation.promoPictureUrl,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: availableHeight * 0.12,
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    organisation.name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: FontUtils.getScaledFontSize(
                                          inputFontSize: 20, size: size),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: availableHeight * 0.10,
              child: isFlipped
                  ? Center(
                      child: ElevatedButton(
                        onPressed: () {
                          context
                              .read<OrganisationsCubit>()
                              .showOrganisationDetails(
                                organisation: organisation,
                              );
                          context.pushNamed(Pages.organisationDetails.name);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD6EAFF),
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 8,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'learn more',
                                style: TextStyle(
                                  color: Color(0xFF0E90CC),
                                  fontSize: FontUtils.getScaledFontSize(
                                      inputFontSize: 15, size: size),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.arrow_forward_rounded,
                                color: Color(0xFF0E90CC),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ),
          ],
        ));
  }
}
