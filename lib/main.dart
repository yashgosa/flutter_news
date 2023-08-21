import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'src/article.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Article> _articles = articles;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        child: ListView(
          children: _articles.map(_build).toList(),
        ),
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            _articles.removeAt(0);
          });
          return;
        },
      ),
    );
  }
}

Widget _build(Article article) {
  return Padding(
    key: Key(article.text),
    padding: const EdgeInsets.all(17.0),
    child: ExpansionTile(
      title: Text(article.text, style: const TextStyle(fontSize: 24.0)),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("${article.commentsCount} comments"),
            // MaterialButton(onPressed: () {}, child: const Text("OPEN"))
            IconButton(
                onPressed: () async {
                  final Uri fakeUrl = Uri.parse("https://${article.domain}");
                  if (!await launchUrl(fakeUrl)) {}
                },
                icon: const Icon(Icons.launch)),
          ],
        ),
      ],
      // onTap: () async {

      // },
    ),
  );
}
