// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';
import 'package:givt_app_kids_web/features/recommendation/cubit/organizations_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/models/organization.dart';
import 'package:givt_app_kids_web/features/recommendation/screens/organization_details_screen.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/organization_header.dart';

class OrganizationItem extends StatelessWidget {
  const OrganizationItem({
    super.key,
    required this.width,
    required this.height,
    required this.organization,
    required this.isFlipped,
  });

  final double width;
  final double height;
  final Organization organization;
  final bool isFlipped;

  @override
  Widget build(BuildContext context) {
    const margin = 10.0;
    final availableHeight = height - margin * 2;

    return Container(
        margin: const EdgeInsets.all(margin),
        width: width,
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                context
                    .read<OrganizationsCubit>()
                    .flipOrganization(organization);
              },
              borderRadius: BorderRadius.circular(25.0),
              child: Card(
                elevation: 10,
                color: isFlipped ? const Color(0xFFC7DFBC) : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: availableHeight * 0.05,
                    ),
                    SizedBox(
                      height: availableHeight * 0.20,
                      child: OrganizationHeader(
                        organization: organization,
                      ),
                    ),
                    isFlipped
                        ? Container(
                            height: availableHeight * 0.65,
                            child: Card(
                              margin: EdgeInsets.zero,
                              elevation: 0,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
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
                                        child: Image.network(
                                          organization.qrCodeURL,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                      Container(
                                        height: availableHeight * 0.13,
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Scan with the\nGivt4Kids app to donate',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 20,
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
                                  organization.promoPictureUrl,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: availableHeight * 0.14,
                                child: Text(
                                  organization.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
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
                              .read<OrganizationsCubit>()
                              .showOrganizationDetails(
                                organization: organization,
                              );
                          Navigator.pushNamed(
                              context, OrganizationDetailsScreen.routeName);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD6EAFF),
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'learn more',
                                style: const TextStyle(
                                  color: Color(0xFF0E90CC),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  // letterSpacing: 0.8,
                                  // height: 1.2,
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
