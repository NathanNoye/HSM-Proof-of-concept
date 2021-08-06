import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

showModal(BuildContext context,
    {String body =
        "This is a proof of concept, more functionality will be coming"}) {
  showPlatformDialog(
    context: context,
    builder: (_) => BasicDialogAlert(
      title: Text("Content Not Yet Available"),
      content: Text(body),
      actions: <Widget>[
        BasicDialogAction(
          title: Text("OK"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
