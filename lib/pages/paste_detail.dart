import 'package:fast_clip/common/bar/common_bar.dart';
import 'package:fast_clip/common/cell/discover_cell.dart';
import 'package:fast_clip/config/theme.dart';
import 'package:fast_clip/pages/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class PasteDetail extends StatefulWidget {
  _PasteState createState() => _PasteState();

  PasteModel pasteModel;

  PasteDetail(this.pasteModel);
}

class _PasteState extends State<PasteDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonBar(
        title: 'Fast Clip',
        leadingW: InkWell(
          child: const Icon(IconData(0xe697,fontFamily: 'MyIcons')),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        rightDMActions: [
          InkWell(
            child: const Icon(IconData(0xe76b,fontFamily: 'MyIcons')),
            onTap: () {
            //  TODO 分享
              print('------分享---------');
              Share.share(widget.pasteModel.content,subject:'Fast Clip');
            },
          ),
          // Spacer(),
          SizedBox(width: 10,),
          InkWell(
            child: const Icon(IconData(0xe6f7,fontFamily: 'MyIcons')),
            onTap: () {
              Clipboard.setData(ClipboardData(text: widget.pasteModel.content));
            },
          ),
          SizedBox(width: 10,),
        ],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(12, 20, 12, 20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  border: new Border.all(color: Color(0xff424549)),
                  borderRadius: new BorderRadius.all(new Radius.circular(5.0))),
              child: TextField(
                minLines: 5,
                maxLines: 8,
                controller:
                    TextEditingController(text: widget.pasteModel.content),
                decoration: InputDecoration.collapsed(hintText: 'copy'),
              ),
            ),
            SizedBox(height: 40,),
            Expanded(
              child: Column(
                children: [
                  DiscoverCell(
                      title: '提醒我',
                      icons: [
                        const Icon(IconData(0xe604,fontFamily: 'MyIcons'),color: primaryColor,),
                        const Icon(IconData(0xe65b,fontFamily: 'MyIcons'),color: primaryColor)
                      ],
                      onTap: () {}),
                  DiscoverCell(
                      title: '浏览网站',
                      icons: [
                        const Icon(IconData(0xe604,fontFamily: 'MyIcons'),color: primaryColor),
                        const Icon(IconData(0xe950,fontFamily: 'MyIcons'),color: primaryColor),
                        const Icon(IconData(0xe80a,fontFamily: 'MyIcons'),color: primaryColor)
                      ],
                      onTap: () {}),
                  DiscoverCell(
                      title: '浏览网站',
                      icons: [
                        const Icon(IconData(0xe604,fontFamily: 'MyIcons'),color: primaryColor),
                        const Icon(IconData(0xe698,fontFamily: 'MyIcons'),color: primaryColor),
                      ],
                      onTap: () {}),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
