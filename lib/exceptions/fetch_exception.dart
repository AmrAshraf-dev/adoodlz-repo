class NetworkErrorException extends Error {
  final String message = 'A Network problem';
}

class UserNotFoundException extends Error {
  UserNotFoundException(this._email);
  final String _email;
  String get message => 'No user with email $_email found';
}
