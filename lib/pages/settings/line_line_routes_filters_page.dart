import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../material/list_tile.dart';
import '../../notifiers/line_line_routes_filters_change_notifier.dart';
import '../../widgets/text.dart';

class LineLineRoutesFiltersPage extends StatefulWidget {
  LineLineRoutesFiltersPage({Key key}) : super(key: key);

  @override
  _LineLineRoutesFiltersPageState createState() =>
      _LineLineRoutesFiltersPageState();
}

class _LineLineRoutesFiltersPageState extends State<LineLineRoutesFiltersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Line routes'),
      ),
      body: Consumer<LineLineRoutesFiltersChangeNotifier>(
        builder: (context, lineLineRoutesFilters, child) {
          return ListView(
            children: <Widget>[
              AlignedListTile(
                title: Text('Service type'),
                subtitle: NullableText(
                  lineLineRoutesFilters.serviceType,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.restore),
                  onPressed: () {
                    lineLineRoutesFilters.serviceType = null;
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
