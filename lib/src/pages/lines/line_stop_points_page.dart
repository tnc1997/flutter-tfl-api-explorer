import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/states/tfl_api_state.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/stop_point_list_tile.dart';

class LineStopPointsPage extends StatefulWidget {
  static const route = '/lines/:id/stop_points';

  final Line line;

  LineStopPointsPage({
    Key key,
    @required this.line,
  }) : super(
          key: key,
        );

  @override
  _LineStopPointsPageState createState() => _LineStopPointsPageState();
}

class _LineStopPointsPageState extends State<LineStopPointsPage> {
  Future<List<StopPoint>> _stopPointsFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stop points'),
      ),
      body: CircularProgressIndicatorFutureBuilder<List<StopPoint>>(
        future: _stopPointsFuture,
        builder: (context, data) {
          if (data != null && data.isNotEmpty) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return StopPointListTile(
                  stopPoint: data[index],
                );
              },
              itemCount: data.length,
            );
          } else {
            return Center(
              child: Text('N/A'),
            );
          }
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
    _stopPointsFuture = tflApi.tflApi.lines.getStopPoints(
      widget.line.id,
    );
  }
}
