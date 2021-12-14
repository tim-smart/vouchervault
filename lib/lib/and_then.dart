extension Chain<T> on T {
  R chain<R>(R Function(T value) transform) => transform(this);
}
