import 'dart:convert';

import 'package:card_selector/card_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'package:foldable_sidebar_example/widgets/amountPageWidget.dart';
import 'package:foldable_sidebar_example/widgets/cardPageWidget.dart';
import 'package:foldable_sidebar_example/widgets/customSideBarDrawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _cards;
  Map _data;
  double _width = 0;
  FSBStatus _fsbStatus;

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context).loadString("assets/data.json").then((d) {
      _cards = json.decode(d);
      setState(() => _data = _cards[0]);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_cards == null) return Container();
    if (_width <= 0) _width = MediaQuery.of(context).size.width - 40.0;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      body: FoldableSidebarBuilder(
        status: _fsbStatus,
        drawer: CustomSidebarDrawer(drawerClose: () {
          setState(() {
            _fsbStatus = FSBStatus.FSB_CLOSE;
          });
        }),
        screenContents: content(),
        drawerBackgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[400],
        child: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            _fsbStatus = _fsbStatus == FSBStatus.FSB_OPEN
                ? FSBStatus.FSB_CLOSE
                : FSBStatus.FSB_OPEN;
          });
        },
      ),
    );
  }

  Widget content() {
    return Container(
      child: Column(
        children: <Widget>[
          Text("Home Widget"),
          CardSelector(
            cards: _cards.map((context) => CardPage(context)).toList(),
            mainCardWidth: _width,
            mainCardHeight: _width * 0.63,
            mainCardPadding: -16,
            onChanged: (i) => setState(
              () => _data = _cards[i],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(child: AmountPage(_data)),
        ],
      ),
    );
  }
}
