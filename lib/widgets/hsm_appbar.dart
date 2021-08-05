import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hsm_poc/core/constants.dart';

class HsmAppBar extends StatefulWidget implements PreferredSizeWidget {
  final TabController? tabController;

  const HsmAppBar({Key? key, @required this.tabController}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HsmAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kAppBarHeight);
}

class _HsmAppBarState extends State<HsmAppBar> {
  final List<String> tabNames = ['HSM', 'Events', 'Watch', 'Serve', 'More'];

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: kDefaultPadding / 2),
        child: IconButton(
          icon: Image.asset(
            'assets/mountains.png',
            color: kTextColor,
          ),
          onPressed: () {},
        ),
      ),
      title: Center(
          child: Text(tabNames[widget.tabController!.index],
              style: TextStyle(
                  color: kTextColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 24))),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.account_circle,
            color: kTextColor,
          ),
          onPressed: () {},
        ),
        SizedBox(width: kDefaultPadding / 2)
      ],
    );
  }
}