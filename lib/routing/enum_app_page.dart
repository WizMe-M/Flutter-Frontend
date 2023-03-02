enum AppScreen {
  signIn('Authorization screen', '/auth'),
  signUp('Registration screen', '/register'),
  home('Home screen', '/home');

  const AppScreen(this.name, this.path);

  final String path;
  final String name;
}
