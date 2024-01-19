abstract class AuthenCredential{
  const AuthenCredential(this.url);
  final String url;
  Map<String, dynamic> asMap();
  @override
  String toString() => asMap().toString();
}