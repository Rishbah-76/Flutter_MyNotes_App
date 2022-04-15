//Login Exceptions
class UserNotFoundFirbaseAuthException implements Exception {}

class WrongPasswordFirbaseAuthException implements Exception{}

//Register View exceptions
class WeakPasswordFirbaseAuthException implements Exception{}

class EmailAlreadyInUseFirbaseAuthException implements Exception{}

class InvalidEmailFirbaseAuthException implements Exception{}

//Generic exceptions for both views
class GenericErrorFirbaseAuthException implements Exception{}

class UserNotLoggedInFirbaseAuthException implements Exception{}