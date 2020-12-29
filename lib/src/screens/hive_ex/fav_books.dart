import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const favoritesBox = 'favorite_books';
const List<String> books = [
  'Harry Potter',
  'To Kill a Mockingbird',
  'The Hunger Games',
  'The Giver',
  'Brave New World',
  'Unwind',
  'World War Z',
  'The Lord of the Rings',
  'The Hobbit',
  'Moby Dick',
  'War and Peace',
  'Crime and Punishment',
  'The Adventures of Huckleberry Finn',
  'Catch-22',
  'The Sound and the Fury',
  'The Grapes of Wrath',
  'Heart of Darkness',
];

class FavBooks extends StatefulWidget {
  @override
  _FavBooksState createState() => _FavBooksState();
}

class _FavBooksState extends State<FavBooks> {
  Box<String> favoriteBooksBox;
  bool initializeBox = true;

  @override
  void initState() {
    super.initState();
    // _initializeHive().then((result) {
    //   setState(() {
    //     initializeBox = result;
    //     favoriteBooksBox = Hive.box(favoritesBox);
    //   });
    // });
    favoriteBooksBox = Hive.box(favoritesBox);
  }

  Future<bool> _initializeHive() async {
    await Hive.initFlutter();
    await Hive.openBox<String>(favoritesBox);
    return true;
  }

  Widget getIcon(int index) {
    if (favoriteBooksBox.containsKey(index)) {
      return Icon(Icons.favorite, color: Colors.red);
    }
    return Icon(Icons.favorite_border);
  }

  void onFavoritePress(int index) {
    if (favoriteBooksBox.containsKey(index)) {
      favoriteBooksBox.delete(index);
      return;
    }
    favoriteBooksBox.put(index, books[index]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Favorite Books with Hive',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              // await Hive.close();
              // await Hive.box(favoritesBox).clear();
              Navigator.pop(context);
            },
          ),
          title: Text("Favorite Books w/ Hive"),
        ),
        body: ValueListenableBuilder(
          valueListenable: favoriteBooksBox.listenable(),
          builder: (context, Box<String> box, _) {
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, listIndex) {
                return ListTile(
                  title: Text(books[listIndex]),
                  trailing: IconButton(
                    icon: getIcon(listIndex),
                    onPressed: () => onFavoritePress(listIndex),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
