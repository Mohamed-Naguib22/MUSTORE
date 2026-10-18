import 'dart:async';

enum SessionEvent { refreshed, expired }

class SessionEvents {
  final _controller = StreamController<SessionEvent>.broadcast();

  Stream<SessionEvent> get stream => _controller.stream;

  void add(SessionEvent event) {
    if (!_controller.isClosed) _controller.add(event);
  }

  void dispose() => _controller.close();
}