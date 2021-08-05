enum ViewState { idle, busy, error }

extension ViewStateExt on ViewState {
  bool get isIdle => this == ViewState.idle;
  bool get isNotIdle => this != ViewState.idle;
  bool get isBusy => this == ViewState.busy;
  bool get hasError => this == ViewState.error;
}
