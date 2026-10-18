import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin SafeEmitMixin<S> on Cubit<S> {
  void safeEmit(S state) {
    if (!isClosed) emit(state);
  }

  Future<void> safeRun(Future<void> Function() fn) async {
    if (isClosed) return;
    await fn();
  }

  void safeFold<L, R>(
      Either<L, R> result, {
        required S Function(L) onLeft,
        required S Function(R) onRight,
      }) {
    if (isClosed) return;
    result.fold(
          (l) => safeEmit(onLeft(l)),
          (r) => safeEmit(onRight(r)),
    );
  }

  void safeFoldSideEffect<L, R>(
      Either<L, R> result, {
        required void Function(L) onLeft,
        required void Function(R) onRight,
      }) {
    if (isClosed) return;
    result.fold(onLeft, onRight);
  }

  StreamSubscription<T>? safeSubscribe<T>(
      Stream<T> stream,
      void Function(T event) onEvent, {
        void Function(Object error, StackTrace stack)? onError,
        void Function()? onDone,
        bool cancelOnError = false,
      }) {
    if (isClosed) return null;
    return stream.listen(
          (event) {
        if (isClosed) return;
        onEvent(event);
      },
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  StreamSubscription<void>? safeSubscribeVoid(
      Stream<void> stream,
      void Function() onEvent, {
        void Function(Object error, StackTrace stack)? onError,
        void Function()? onDone,
        bool cancelOnError = false,
      }) {
    if (isClosed) return null;
    return stream.listen(
          (_) {
        if (isClosed) return;
        onEvent();
      },
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }
}