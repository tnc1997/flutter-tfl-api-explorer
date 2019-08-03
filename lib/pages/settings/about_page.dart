import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import '../../material/list_tile.dart';
import '../../widgets/async.dart';
import '../../widgets/text.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: CircularProgressIndicatorFutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, data) {
          return ListView(
            children: <Widget>[
              AlignedListTile(
                title: Text('Package name'),
                subtitle: NullableText(data.packageName),
              ),
              AlignedListTile(
                title: Text('Package version'),
                subtitle: NullableText(data.version),
              ),
            ],
          );
        },
      ),
    );
  }
}
