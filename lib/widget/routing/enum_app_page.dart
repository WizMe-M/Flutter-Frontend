enum AppPage {
  signIn('Authorization page', '/auth'),
  signUp('Registration page', '/register');

  const AppPage(this.name, this.path);

  final String path;
  final String name;
}
