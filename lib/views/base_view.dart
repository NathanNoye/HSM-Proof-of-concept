import 'package:flutter/widgets.dart';
import 'package:hsm_poc/core/locator.dart';
import 'package:hsm_poc/viewmodels/base_viewmodel.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final Function(T)? afterLayout;
  final Function(T)? beforeLayout;
  final Function(T)? onDispose;

  BaseView({
    required this.builder,
    this.afterLayout,
    this.beforeLayout,
    this.onDispose,
  });

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  T model = locator<T>();

  @override
  void initState() {
    if (widget.beforeLayout != null) {
      widget.beforeLayout!(model);
    }

    if (widget.afterLayout != null) {
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        widget.afterLayout!(model);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
        value: model, child: Consumer<T>(builder: widget.builder));
  }

  @override
  void dispose() {
    if (widget.onDispose != null) {
      widget.onDispose!(model);
    }
    super.dispose();
  }
}
