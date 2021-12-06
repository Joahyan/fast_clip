import 'package:fast_clip/common/bar/common_bar.dart';
import 'package:fast_clip/common/button/common_button.dart';
import 'package:fast_clip/common/search/common_search.dart';
import 'package:fast_clip/config/theme.dart';
import 'package:fast_clip/pages/paste_detail.dart';
import 'package:fast_clip/route/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IndexPage extends StatefulWidget {
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<IndexPage> with WidgetsBindingObserver {
  final List<PasteModel> pasteList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PasteModel pasteModel = PasteModel(content: 'implement initState');
    pasteList.add(pasteModel);
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeDependencies
    super.didChangeAppLifecycleState(state);
    // 由后台进入应用
    if (state == AppLifecycleState.resumed) {
      // 此时获取粘贴板数据
      Future.delayed(Duration(milliseconds: 500)).then((_) => getPasteData());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonBar(
          title: 'Fast Clip',
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                color: secondBgColor,
                padding: EdgeInsets.fromLTRB(12, 6, 12, 12),
                child: CommonSearch(
                  hint: '搜索记录',
                  icon: Icon(CupertinoIcons.search),
                  onTap: () => {
                    // TODO 接入搜索
                  },
                ),
              ),
              Expanded(
                  // color: secondBgColor,
                  child: pasteList.length > 0
                      ? ListView(
                          children: buildPasteList(),
                        )
                      : Center(
                          child: Text('No Data'),
                        ))
            ],
          ),
        ));
  }

  // 获取粘贴的数据
  void getPasteData() async {
    ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    print('data content ${data?.text}'); //  data content 复制的内容
    // 判断数据是否为空
    if (data != null && data.text!.isNotEmpty) {
      int index = -1;
      PasteModel? tempPaste = null;
      for (int i = 0; i < pasteList.length; i++) {
        if (pasteList[i].content == data.text) {
          tempPaste = pasteList[i];
          index = i;
          break;
        }
      }
      if (index > 0) {
        pasteList.remove(index);
      } else if (index == -1) {
        tempPaste = PasteModel(content: data.text!, show: false);
      }

      if (index != 0) {
        pasteList.insert(0, tempPaste!);
        setState(() {
          pasteList;
        });
      }
    }
  }

  // 从粘贴板中copy数据
  setPasteData(text) {
    ClipboardData clipboardData = ClipboardData(text: text);
    Clipboard.setData(clipboardData);
  }

  linkToPasteDetail(PasteModel element) {
    routePush(new PasteDetail(element));
  }

  List<Widget> buildPasteList() {
    List<Widget> pasteWidget = [];
    pasteList.forEach((element) {
      pasteWidget.add(new Container(
        padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
        child: new GestureDetector(
          onHorizontalDragEnd: (endDetails) {
            setState(() {
              element.show = !element.show;
            });
          },
          child: Container(
            // height: 40.0,
            decoration: new BoxDecoration(
                border: new Border(
              top: BorderSide(color: Color(0xff424549), width: 0.5),
              bottom: BorderSide(color: Color(0xff424549), width: 0.5),
            )),

            child: new Row(
                children: element.show
                    ? [
                        Container(
                            width: 170,
                            padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                            child: Text(
                              element.content,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(color: primaryColor),
                            )),
                        Spacer(),
                        new CommonButton(
                          text: 'pin',
                          width: 60,
                          radius: 0,
                          onTap: () {
                            linkToPasteDetail(element);
                          },
                        ),
                        new CommonButton(
                          text: 'copy',
                          width: 60,
                          radius: 0,
                          onTap: () {
                            setPasteData(element.content);
                          },
                        ),
                        new CommonButton(
                          text: 'remove',
                          width: 60,
                          gradient: LinearGradient(
                              colors: [Color(0xffed2856), Colors.red]),
                          radius: 0,
                          onTap: () {
                            pasteList.remove(element);
                            setState(() {
                              pasteList;
                            });
                          },
                        )
                      ]
                    : [
                        Container(
                            width: 230,
                            padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                            child: Text(
                              element.content,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(color: primaryColor),
                            ))
                      ]),
          ),
        ),
      ));
    });
    return pasteWidget;
  }
}

class PasteModel {
  //复制的内容
  final String content;
  // 是否显示相关操作按钮
  bool show;
  PasteModel({required this.content, this.show = false});
}
