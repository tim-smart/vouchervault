extension AndThen<T> on T {
  R andThen<R>(R Function(T value) transform) => transform(this);
  R pipe<R>(R Function(T value) transform) => transform(this);
}
