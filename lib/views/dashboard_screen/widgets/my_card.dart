import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../models/MyFiles.dart';
import '../../../responsive.dart';
import 'info_card.dart';

class MyCard extends StatelessWidget {
  const MyCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(height: defaultPadding),
        Responsive(
          mobile: InfoCardGridView(
            crossAxisCount: 2,
            childAspectRatio: size.width < 650 && size.width > 350 ? 1.3 : 2.3,
          ),
          tablet: const InfoCardGridView(),
          desktop: InfoCardGridView(
            childAspectRatio: size.width < 1400 ? 2.3 : 3,
          ),
        ),
      ],
    );
  }
}

class InfoCardGridView extends StatelessWidget {
  const InfoCardGridView({
    Key? key,
    this.crossAxisCount = 2,
    this.childAspectRatio = 1.9,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: informations.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => InfoCard(
        info: informations[index],
      ),
    );
  }
}
