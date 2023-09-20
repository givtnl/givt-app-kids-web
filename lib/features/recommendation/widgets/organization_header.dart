//avoid_unnecessary_containers

// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:givt_app_kids_web/features/recommendation/models/organization.dart';

class OrganizationHeader extends StatelessWidget {
  const OrganizationHeader({
    required this.organization,
    super.key,
    this.fullScreenMode = false,
  });

  final Organization organization;
  final bool fullScreenMode;
  _arrangedTags() {
    final tags = organization.tags;
    if (tags.length > 3) {
      return tags.take(3).toList();
    }
    return tags;
  }

  @override
  Widget build(BuildContext context) {
    final Image orgLogoImage = Image.network(
      organization.organisationLogoURL,
      fit: BoxFit.contain,
    );
    precacheImage(orgLogoImage.image, context);

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: organization.tags
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
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.025,
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
          Expanded(
            flex: fullScreenMode ? 1 : 2,
            child: Container(
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: orgLogoImage,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
