import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() {
  runApp(MyApp());
}

class Book {
  final String title;
  final String author;
  Book(this.title, this.author);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //var _selectBook = false;
  Book? book;
  _handleSelectBook(Book book) {
    setState(() {
      // _selectBook = true;
      this.book = book;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Navigator(
          pages: [
            MaterialPage(child: ListBookScreen(_handleSelectBook)),
            if (book != null) MaterialPage(child: DetailBookScreen(book))
          ],
          onPopPage: (route, result) => route.didPop(result),
        ));
  }
}

class ListBookScreen extends StatelessWidget {
  var onTaped;
  ListBookScreen(this.onTaped) : super(key: ValueKey(onTaped));
  List<Book> books = [
    Book('book1', 'authhor1'),
    Book('book2', 'authhor2'),
    Book('book3', 'authhor3')
  ];
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(title: Text('ListBooks')),
      body: ListView(
        children: [
          for (var book in books)
            ListTile(
                title: Text(book.title),
                subtitle: Text(book.author),
                onTap:()=> this.onTaped(book)),
        ],
      ),
    ));
  }
}

class DetailBookScreen extends StatelessWidget {
  var book;
  DetailBookScreen(this.book) : super(key: ValueKey(book));
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        appBar: AppBar(title: Text('detail')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(book.title + '      ' + book.author),
        )));
  }
}
