enum RouteValue {
  splash(
    path: '/',
  ),
  addPond(
    path: 'addPond',
  ),
  home(
    path: '/home',
  ),
  unknown(
    path: '',
  );

  final String path;
  const RouteValue({
    required this.path,
  });
}
