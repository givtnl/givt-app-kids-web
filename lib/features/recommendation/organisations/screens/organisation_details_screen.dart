// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:givt_app_kids_web/core/app/pages.dart';
import 'package:givt_app_kids_web/features/profiles/widgets/profile_wallet_button.dart';
import 'package:givt_app_kids_web/features/recommendation/organisations/cubit/organisations_cubit.dart';
import 'package:givt_app_kids_web/features/recommendation/widgets/organisation_header.dart';
import 'package:givt_app_kids_web/shared/widgets/givt_primary_elevated_button.dart';

import 'package:givt_app_kids_web/shared/widgets/back_button.dart'
    as givt_widgets;

class OrganisationDetailsScreen extends StatelessWidget {
  const OrganisationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const topPaddingRelative = 0.1;
    const bottomPaddingRelative = 0.025;
    const horizontalPaddingRelative = 0.05;
    final availableWidth =
        size.width - (size.width * horizontalPaddingRelative * 2);
    final availableHeight = size.height -
        (size.height * topPaddingRelative +
            size.height * bottomPaddingRelative);

    return BlocBuilder<OrganisationsCubit, OrganisationsState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                Positioned.fill(
                  child: state is! OrganisationDetailesState
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          width: size.width,
                          height: size.height,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("images/gradient.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: size.width * horizontalPaddingRelative,
                              right: size.width * horizontalPaddingRelative,
                              top: size.height * topPaddingRelative,
                              bottom: size.height * bottomPaddingRelative,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  color: const Color(0xFFEEEDE4),
                                  width: double.maxFinite,
                                  height: availableHeight * 0.85,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: availableWidth,
                                        height: availableHeight * 0.2,
                                        child: OrganisationHeader(
                                          organisation:
                                              state.selectedOrganisation,
                                          fullScreenMode: true,
                                        ),
                                      ),
                                      Container(
                                        width: availableWidth,
                                        height: availableHeight * 0.6,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        state
                                                            .selectedOrganisation
                                                            .name,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          fontSize: 35,
                                                          color:
                                                              Color(0xFF404A70),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5),
                                                      child: Text(
                                                        state
                                                            .selectedOrganisation
                                                            .shortDescription,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          fontSize: 17,
                                                          color:
                                                              Color(0xFF404A70),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 7,
                                                    child: Container(
                                                      width: double.maxFinite,
                                                      height: double.maxFinite,
                                                      color: const Color(
                                                          0xFFE2E0CF),
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Text(
                                                        state
                                                            .selectedOrganisation
                                                            .longDescription,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          color:
                                                              Color(0xFF404A70),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 20,
                                                        bottom: 30,
                                                      ),
                                                      width: double.infinity,
                                                      alignment:
                                                          Alignment.topCenter,
                                                      child: const Text(
                                                        'Even \$1 dollar helps!',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color:
                                                              Color(0xFF54A1EE),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 30,
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Container(
                                                child: state.isDonateMode
                                                    ? Row(
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              child: Column(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 5,
                                                                    child:
                                                                        Container(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              10),
                                                                      child: Image
                                                                          .network(
                                                                        state
                                                                            .selectedOrganisation
                                                                            .qrCodeURL,
                                                                        fit: BoxFit
                                                                            .fitHeight,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const Spacer(),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Stack(
                                                              children: [
                                                                Positioned.fill(
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .only(
                                                                      top: 10,
                                                                    ),
                                                                    width: double
                                                                        .infinity,
                                                                    alignment:
                                                                        Alignment
                                                                            .topCenter,
                                                                    child:
                                                                        const Text(
                                                                      'Scan with the\nGivt4Kids app to donate',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        color: Color(
                                                                            0xFF54A1EE),
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  left: 20,
                                                                  top: 50,
                                                                  child:
                                                                      SvgPicture
                                                                          .asset(
                                                                    'images/scan_to_give_arrow_alt.svg',
                                                                    fit: BoxFit
                                                                        .fitHeight,
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  bottom: 0,
                                                                  left: 0,
                                                                  child: Image
                                                                      .asset(
                                                                          'images/g4k_app_screenshot.png'),
                                                                  //TODO: replace with non corrupted svg
                                                                  // SvgPicture
                                                                  //     .asset(
                                                                  //   'images/g4k_app_screenshot.svg',
                                                                  //   fit: BoxFit
                                                                  //       .fitHeight,
                                                                  // ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : Image.network(
                                                        state
                                                            .selectedOrganisation
                                                            .promoPictureUrl,
                                                        fit: BoxFit.fitHeight,
                                                      ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
                Positioned(
                  top: 30,
                  left: 30,
                  child: givt_widgets.BackButton(
                    pageName: Pages.organisationDetails.name,
                  ),
                ),
                Positioned(
                  top: 30,
                  right: 30,
                  child: ProfileWalletButton(
                    pageName: Pages.organisationDetails.name,
                  ),
                ),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton:
                (state as OrganisationDetailesState).isDonateMode == false
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 25),
                        child: GivtPrimaryElevatedButton(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 90, vertical: 12),
                          text: 'Donate',
                          onPressed: () => context
                              .read<OrganisationsCubit>()
                              .showOrganisationDetails(
                                organisation: state.selectedOrganisation,
                                isDonateMode: true,
                              ),
                        ),
                      )
                    : null,
          ),
        );
      },
    );
  }
}
