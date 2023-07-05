// ignore_for_file: sized_box_for_whitespace

import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givt_app_kids_web/features/recommendation/cubit/organizations_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/utils/font_utils.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/organization_item.dart';

class OrganizationsScreen extends StatefulWidget {
  const OrganizationsScreen({super.key});

  @override
  State<OrganizationsScreen> createState() => _OrganizationsScreenState();
}

class _OrganizationsScreenState extends State<OrganizationsScreen> {
  @override
  void initState() {
    super.initState();

//    context.read<OrganizationsCubit>().fetchOrganizations();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<OrganizationsCubit, OrganizationsState>(
      listener: (context, state) {
        log('OrganizationsCubit state changed on $state');
        if (state is OrganizationsExternalErrorState) {
          log(state.errorMessage);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Cannot fetch organizations. Please try again later. ${state.errorMessage}",
                textAlign: TextAlign.center,
              ),
              // duration: Duration(seconds: 10),
              backgroundColor: Theme.of(context).errorColor,
            ),
          );
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: const Color(0xFFEEEDE4),
            body: state is OrganizationsFetchingState
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    width: size.width,
                    height: size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: size.height * .07,
                        ),
                        Text(
                          'Based on your interest, I have a few options for you.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: FontUtils.getScaledFontSize(
                                inputFontSize: 7,
                                availableWidth: size.width,
                                availableHeight: size.height),
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: size.height * .025,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: state.organizations
                              .map((organization) => OrganizationItem(
                                    width: (size.width * .90) /
                                        state.organizations.length,
                                    height: size.height * .80,
                                    name: organization.name,
                                    description: organization.shortDescription,
                                    pictureURL: organization.promoPictureUrl,
                                    qrCodeURL: organization.qrCodeURL,
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
