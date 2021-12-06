import 'package:fast_clip/config/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiscoverCell extends StatelessWidget {
  final String title;
  final List<Icon> icons;
  final Function onTap;

  DiscoverCell(
      {this.title = '',
      required this.icons,
      required this.onTap}); // final String

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(12),
      height: 80,
      decoration: BoxDecoration(
          border: new Border(
        bottom: BorderSide(color: Color(0xff424549), width: 0.5),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: buildIcons(),
              ),
              Text(title)
            ],
          ),
          const Icon(IconData(0xe64d,fontFamily: 'MyIcons'),)
        ],
      ),
      // color: ,
    );
  }

  List<Widget> buildIcons() {
    List<Widget> iconWidgets = [];
    for (int index = 0; index < icons.length; index++) {
      if (index == icons.length - 1) {
        iconWidgets.add(icons[index]);
        iconWidgets.add(SizedBox(width: 5,));
      } else {
        iconWidgets.add(icons[index]);
        iconWidgets.add(SizedBox(width: 5,));
        iconWidgets.add(const Icon(IconData(0xe60c,fontFamily: 'MyIcons')));
        iconWidgets.add(SizedBox(width: 5,));
      }
    }
    return iconWidgets;
  }
}
