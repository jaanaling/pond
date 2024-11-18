enum RouteValue {
  splash(
    path: '/',
  ),
  chellenge(
    path: '/chellenge',
  ),
  tips(
    path: '/tips',
  ),
  home(
    path: '/home',
  ),
    analytic(
    path: 'analytic',
  ),
  goals(
    path: '/goals',
  ),
  transaction(
    path: '/transaction',
  ),
  addTransaction(
    path: 'addTransaction',
  ),
  unknown(
    path: '',
  );

  final String path;
  const RouteValue({
    required this.path,
  });
}
