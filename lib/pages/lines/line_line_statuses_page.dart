import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

import '../../material/list_tile.dart';
import '../../states/tfl_api_state.dart';
import '../../widgets/async.dart';

class LineLineStatusesPage extends StatefulWidget {
  static const route = '/lines/:id/line_statuses';

  final Line line;

  LineLineStatusesPage({
    Key key,
    @required this.line,
  }) : super(key: key);

  @override
  _LineLineStatusesPageState createState() => _LineLineStatusesPageState();
}

class _LineLineStatusesPageState extends State<LineLineStatusesPage> {
  Future<List<LineStatus>> _lineStatusesFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Line statuses'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<LineStatus>>(
        future: _lineStatusesFuture,
        builder: (context, data) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return LineStatusListTile(
                context: context,
                lineStatus: data[index],
              );
            },
            itemCount: data.length,
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    final tflApi = Provider.of<TflApiState>(
      context,
      listen: false,
    );
    _lineStatusesFuture = tflApi.tflApi.lines.getLineStatuses(
      widget.line.id,
    );
  }
}
