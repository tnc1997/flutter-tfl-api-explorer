import 'package:flutter/material.dart';
import 'package:tfl_api_client/tfl_api_client.dart';

class IdentifierListTile extends StatelessWidget {
  IdentifierListTile({
    Key? key,
    required this.identifier,
  }) : super(
          key: key,
        );

  final Identifier identifier;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        identifier.id ?? 'Unknown',
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        identifier.name ?? 'Unknown',
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
