import 'package:flutter/material.dart';
import 'package:wanandroid/env/l10n/generated/l10n.dart';

class SharedPage extends StatefulWidget {
  const SharedPage({Key? key}) : super(key: key);

  @override
  _SharedPageState createState() => _SharedPageState();
}

class _SharedPageState extends State<SharedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.of(context).mine_share),
      ),
    );
  }
}
