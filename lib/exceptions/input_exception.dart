class NotNumberException extends Error {
  final String message = 'The entered value is not a number';
}

class NotInRangeException extends Error {
  final String message = 'The entered value is not between 1 and 10';
}
