enum RouteValue {
  splash(
    path: '/',
  ),
  home(
    path: '/home',
  ),
  addPond(
    path: 'addPond',
  ),
  details(
    path: 'details',
  ),
  tasks(
    path: 'tasks',
  ),
  history(
    path: 'history',
  ),
  items(
    path: 'items',
  ),
  unknown(
    path: '',
  );

  final String path;
  const RouteValue({
    required this.path,
  });
}
