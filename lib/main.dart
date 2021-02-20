import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _notifier = ValueNotifier<ThemeModel>(ThemeModel(ThemeMode.light));
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeModel>(
      valueListenable: _notifier,
      builder: (_, model, __) {
        final mode = model.mode;
        return MaterialApp(
          title: 'Themer',
          theme: ThemeData(
            brightness: Brightness.light,
            /* light theme settings */
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,

            /* dark theme settings */
          ),
          themeMode: mode,
          /* ThemeMode.system to follow system theme, 
         ThemeMode.light for light theme, 
         ThemeMode.dark for dark theme
      */
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: AppBar(
              title: Text('Theme Switcher'),
              actions: [
                Row(
                  children: [
                    Switch(
                      activeColor: Colors.white,
                      activeTrackColor: Colors.grey,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey,
                      value: value,
                      inactiveThumbImage: NetworkImage(
                          'https://cdn3.iconfinder.com/data/icons/meteocons/512/moon-black-512.png'),
                      activeThumbImage: NetworkImage(
                          'https://image.flaticon.com/icons/png/512/169/169367.png'),
                      onChanged: (bool _value) {
                        setState(() {
                          value = _value;
                        });

                        _notifier.value = ThemeModel(mode == ThemeMode.dark
                            ? ThemeMode.light
                            : ThemeMode.dark);
                      },
                    ),
                  ],
                )
              ],
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Use Toogle Switch to change light and dark theme',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ThemeModel with ChangeNotifier {
  final ThemeMode _mode;
  ThemeMode get mode => _mode;

  ThemeModel(this._mode);
}
