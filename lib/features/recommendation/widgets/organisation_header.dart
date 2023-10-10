//avoid_unnecessary_containers

// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:givt_app_kids_web/features/recommendation/organisations/models/organisation.dart';
import 'package:givt_app_kids_web/utils/font_utils.dart';

class OrganisationHeader extends StatelessWidget {
  const OrganisationHeader({
    required this.organisation,
    super.key,
    this.fullScreenMode = false,
  });

  final Organisation organisation;
  final bool fullScreenMode;
  _arrangedTags() {
    final tags = organisation.tags;
    if (tags.length > 3) {
      return tags.take(3).toList();
    }
    return tags;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: organisation.tags
                      .map(
                        (tag) => Container(
                          margin: const EdgeInsets.symmetric(vertical: 3),
                          decoration: BoxDecoration(
                            color: tag.color,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 15,
                            ),
                            child: Text(
                              tag.displayText,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: FontUtils.getScaledFontSize(
                                    inputFontSize: 15, size: size),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList()
                      .take(3)
                      .toList(),
                ),
              ),
            ),
          ),
          Expanded(
            flex: fullScreenMode ? 1 : 2,
            child: Container(
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.network(
                  organisation.organisationLogoURL,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
