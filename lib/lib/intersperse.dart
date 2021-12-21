Iterable<T> Function(Iterable<T>) intersperse<T>(T element) =>
    (iterable) sync* {
      final iterator = iterable.iterator;
      if (iterator.moveNext()) {
        yield iterator.current;
        while (iterator.moveNext()) {
          yield element;
          yield iterator.current;
        }
      }
    };
