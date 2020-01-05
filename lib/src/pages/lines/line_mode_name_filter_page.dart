import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tfl_api_client/tfl_api_client.dart';
import 'package:tfl_api_explorer/src/notifiers/line_filters_change_notifier.dart';
import 'package:tfl_api_explorer/src/states/tfl_api_state.dart';
import 'package:tfl_api_explorer/src/widgets/circular_progress_indicator_future_builder.dart';
import 'package:tfl_api_explorer/src/widgets/nullable_text.dart';

class LineModeNameFilterPage extends StatefulWidget {
  LineModeNameFilterPage({
    Key key,
  }) : super(
          key: key,
        );

  @override
  _LineModeNameFilterPageState createState() => _LineModeNameFilterPageState();
}

class _LineModeNameFilterPageState extends State<LineModeNameFilterPage> {
  Future<List<Mode>> _lineModesFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mode name'),
      ),
      body: Consumer<TflApiState>(
        builder: (context, tflApi, child) {
          return CircularProgressIndicatorFutureBuilder<List<Mode>>(
            future: _lineModesFuture,
            builder: (context, data) {
              return Consumer<LineFiltersChangeNotifier>(
                builder: (context, lineFilters, child) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return RadioListTile<String>(
                        value: data[index].modeName,
                        groupValue: lineFilters.modeName,
                        onChanged: (value) {
                          lineFilters.modeName = value;
                        },
                        title: NullableText(
                          data[index].modeName,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                    itemCount: data.length,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _lineModesFuture = Provider.of<TflApiState>(
      context,
      listen: false,
    ).tflApi.lineModes.get();
  }
}
