import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

showModal(BuildContext context,
    {String title = "Content Not Yet Available",
    String body =
        "This is a proof of concept, more functionality will be coming",
    List<BasicDialogAction>? actions}) {
  showPlatformDialog(
    context: context,
    builder: (_) => BasicDialogAlert(
      title: Text(title),
      content: Text(body),
      actions: actions ??
          <Widget>[
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
