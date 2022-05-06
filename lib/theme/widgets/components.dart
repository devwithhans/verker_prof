import 'package:flutter/material.dart';
import 'package:verker_prof/theme/constants/textstyle.dart';

class CenterText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const CenterText(this.text, {Key? key, this.style}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class Badge extends StatelessWidget {
  final Widget icon;
  final int number;
  final double vertical;
  final double horizontal;
  final bool right;

  const Badge({
    Key? key,
    required this.icon,
    this.number = 0,
    this.horizontal = -10,
    this.vertical = -8,
    this.right = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return number == 0
        ? icon
        : Stack(
            alignment: AlignmentDirectional.center,
            clipBehavior: Clip.none,
            children: [
              icon,
              PositionedDirectional(
                top: vertical,
                end: right ? horizontal : null,
                start: right ? null : horizontal,
                child: BadgeContainer(number: number),
              ),
            ],
          );
  }
}

class BadgeContainer extends StatelessWidget {
  const BadgeContainer({
    Key? key,
    required this.number,
  }) : super(key: key);

  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
          color: const Color(0xffFE3650),
          borderRadius: BorderRadius.circular(100)),
      child: Text(
        number.toString(),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String backgroundImageUrl;
  final String title;
  final String measure;
  final double price;
  final void Function() onPressed;

  const ProductCard({
    Key? key,
    required this.backgroundImageUrl,
    required this.title,
    required this.price,
    this.measure = 'kvm',
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 20),
          width: 200,
          height: 200,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(backgroundImageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(13)),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Text(
              '${price.toInt()},-',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              ' pr. $measure',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        )
      ],
    );
  }
}

enum Status { active, offer, done, canceled }

class StatusBox extends StatelessWidget {
  final String outreachStatus;
  final Color backgroundColor;
  final Color textColor;

  const StatusBox({
    Key? key,
    required this.outreachStatus,
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: backgroundColor,
      ),
      child: Text(
        states[outreachStatus]!,
        style: TextStyle(
            fontSize: 14, color: textColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  static const Map<String, String> states = {
    'PENDING': 'SALG',
    'ACTIVE': 'AKTIV',
    'LOST': 'TABT',
    'DONE': 'AFSLUTTET'
  };
}

class KsliverAppBar extends StatelessWidget {
  const KsliverAppBar({
    Key? key,
    required this.image,
    required this.screenWidth,
    required this.title,
  }) : super(key: key);

  final String title;
  final String image;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        pinned: true,
        snap: true,
        floating: true,
        expandedHeight: 200.0,
        leading: IconButton(
          color: Colors.black,
          splashRadius: 20,
          focusColor: Colors.black,
          splashColor: Colors.black,
          highlightColor: Colors.black,
          icon: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(20)),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          onPressed: () {},
        ),
        flexibleSpace: LayoutBuilder(builder: (context, constraints) {
          double percent = ((constraints.maxHeight) / constraints.minWidth);
          return Stack(
            children: [
              GradientImage(
                image: percent < 0.40 ? '' : image,
              ),
              Positioned(
                bottom: 10,
                child: AnimatedContainer(
                    padding: EdgeInsets.only(
                        left: percent < 0.40 ? 60 : 20, right: 20),
                    curve: Curves.easeIn,
                    width: screenWidth,
                    height: 40,
                    alignment: percent < 0.40
                        ? Alignment.center
                        : Alignment.centerLeft,
                    duration: const Duration(milliseconds: 250),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 10,
                          child: Text(
                            title,
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: SizedBox(
                            width: 20,
                          ),
                        ),
                        const StatusBox(
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          outreachStatus: 'ACTIVE',
                        )
                      ],
                    )),
              ),
            ],
          );
        }));
  }
}

class GradientImage extends StatelessWidget {
  const GradientImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    if (image.isEmpty) {
      return Container(
        color: Colors.black,
      );
    }
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            end: Alignment(0.0, 0.4),
            begin: Alignment(0.0, -1),
            colors: <Color>[Color(0x8A000000), Colors.black],
          ),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(7), topRight: Radius.circular(7)),
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              end: Alignment(0.0, -0.1),
              begin: Alignment(0.0, 1.0),
              colors: <Color>[
                Colors.black,
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    ]

        // Stack(
        //   children: [
        // Image(
        //   fit: BoxFit.cover,
        //   image: NetworkImage(projectModel.projectImages!.first),
        // ),
        //     Image(
        //       fit: BoxFit.cover,
        //       image: AssetImage('assets/gradient.png'),
        //     ),
        //   ],
        // ),
        );
  }
}

class ProjectFormHeader extends StatelessWidget {
  final String headerText;
  final String? bodyText;

  const ProjectFormHeader({Key? key, this.bodyText, required this.headerText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headerText,
          style: kMediumBold,
        ),
        SizedBox(
          height: bodyText != null ? 0 : 20,
        ),
        Text(
          bodyText ?? '',
          style: kMediumBold,
        ),
        SizedBox(
          height: bodyText != null ? 20 : 40,
        ),
      ],
    );
  }
}
