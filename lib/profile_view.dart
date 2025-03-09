import 'dart:html';

import 'package:cv/player.dart';
import 'package:cv/position.dart';
import 'package:cv/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileView extends StatefulWidget {
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  List<Position> positions = [
    Position.fromJson({
      'title': 'It Developer',
      'company': 'Company',
      'start': '2021-01-01',
      'end': '2021-12-31',
      'description': 'Description'
    }),
    Position.fromJson({
      'title': 'Software Engineer',
      'company': 'Company 2',
      'start': '2019-01-01',
      'end': '2020-12-31',
      'description': 'Description'
    }),
    Position.fromJson({
      'title': 'Sales Representative',
      'company': 'Company 2',
      'start': '2019-01-01',
      'end': '2020-12-31',
      'description': 'Description'
    }),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [HexColor('#286169'), HexColor('#332d41')],
          ),
        ),
        child: Stack(
          children: [
            AvatarContainer(),
            Padding(
              padding: const EdgeInsets.only(top: 400),
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      BioContainer(),
                      ListView(
                        shrinkWrap: true,
                        children: positions
                            .map((position) => PositionContainer(position))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class AvatarContainer extends StatelessWidget {
  const AvatarContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: MediaQuery.sizeOf(context).width,
      child: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.transparent.withOpacity(0.5)],
          ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
        },
        blendMode: BlendMode.dstIn,
        child: Image.asset(
          'assets/images/banner-faded-narrow.png',
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}

class NameContainer extends StatelessWidget {
  final String name;

  const NameContainer(this.name, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        name,
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.normal,
          fontFamily: 'Domine',
          color: HexColor('#FFFFFF'),
        ),
      ),
    );
  }
}

class BioContainer extends StatelessWidget {
  final String name = 'Sampo Lunkka';

  const BioContainer({super.key});

  Future<String> _getBio() async {
    return await rootBundle.loadString('assets/text/bio.txt');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            HexColor('#333942').withOpacity(1),
            HexColor('#611621').withOpacity(0.5)
          ],
        ),
        border: Border(
          bottom: BorderSide(color: HexColor('#000000').withOpacity(0.4), width: 10),
        )
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 800),
        child:
          // NameContainer(name),
          // Divider(color: HexColor('#FFFFFF').withOpacity(0.4), thickness: 1),
          FutureBuilder<String>(
              future: _getBio(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const SelectableText('Something went wrong while loading bio');
                } else {
                  return SelectableText('${snapshot.data}');
                }
              }),
      ),
    );
  }
}

class PositionContainer extends StatelessWidget {
  final Position position;

  const PositionContainer(this.position, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              HexColor('#FFFFFF').withOpacity(0.2),
              HexColor('#FFFFFF').withOpacity(0.1)
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: HexColor('#FFFFFF').withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Row(
                children: [
                  SelectableText(position.title,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Domine',
                          color: HexColor('#FFFFFF'))),
                  SelectableText(position.company,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Domine',
                          color: HexColor('#FFFFFF'))),
                ],
              ),
            ),
            Divider(color: HexColor('#FFFFFF').withOpacity(0.4), thickness: 1),
          ],
        ),
      ),
    );
  }
}

class FormatRow extends StatelessWidget {
  final Format format;
  final int index;

  const FormatRow(this.format, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    const double spacing = 8;
    return Padding(
      padding: EdgeInsets.only(top: index == 0 ? 0 : spacing),
      child: Container(
        decoration: BoxDecoration(
          color: HexColor('#000000').withOpacity(0.3),
          borderRadius: BorderRadius.circular(26),
        ),
        padding: EdgeInsets.all(spacing),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TagContainer(format.name, TagType.format),
            SizedBox(width: spacing),
            TagContainer(format.level.name, TagType.level),
            SizedBox(width: spacing),
            TagContainer('Proxies OK', TagType.proxy),
          ],
        ),
      ),
    );
  }
}

enum TagType { game, format, level, proxy }

class TagContainer extends StatelessWidget {
  final String text;
  final TagType type;

  // Padding
  final double left = 8;
  final double top = 4;
  final double right = 8;
  final double bottom = 4;

  const TagContainer(this.text, this.type, {super.key});

  Color getTextColor() {
    switch (type) {
      case TagType.game:
        return HexColor('#FFCDD2');
      case TagType.format:
        return HexColor('#C8E6C9');
      case TagType.level:
        return HexColor('#FFE0B2');
      case TagType.proxy:
        return HexColor('#7de8ff');
    }
  }

  Color getBorderColor() {
    switch (type) {
      case TagType.game:
        return HexColor('#E57373');
      case TagType.format:
        return HexColor('#81C784');
      case TagType.level:
        return HexColor('#FFB74D');
      case TagType.proxy:
        return HexColor('#52a0b1');
    }
  }

  /*
  Color getTextColor() {
    switch (type) {
      case TagType.game:
        return HexColor('#D32F2F');
      case TagType.format:
        return HexColor('#388E3C');
      case TagType.level:
        return HexColor('#F57C00');
      case TagType.proxy:
        return HexColor('#FFFFFF');
    }
  }
   */

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      decoration: BoxDecoration(
        border: Border.all(
          color: getTextColor().withOpacity(0.5),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(color: getTextColor(), fontSize: 14),
      ),
    );
  }
}
