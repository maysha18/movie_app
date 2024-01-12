import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/global.dart';
import 'package:movie_app/routes/app_routes.dart';
import 'package:movie_app/screens/homePage/homePage_view.dart';
import 'package:movie_app/screens/search_movies/searchMovies_view.dart';
import 'package:movie_app/themes/theme_dark.dart';
import 'package:movie_app/themes/theme_light.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouteref = ref.watch(goRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: goRouteref,
      scaffoldMessengerKey: snackbarKey,
      title: 'Flutter Demo',
      theme: MovieThemeDark.theme,
    );
  }
}

class MyInitialApp extends StatefulWidget {
  const MyInitialApp({super.key});
  @override
  _MyInitialAppState createState() => _MyInitialAppState();
}

class _MyInitialAppState extends State<MyInitialApp>
    with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;
  final List<Widget> _childWidgets = [
    const HomePage(),
    const SearchMoviesPage()
  ];

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: _childWidgets[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
        selectedItemColor: Colors.pink[200],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
