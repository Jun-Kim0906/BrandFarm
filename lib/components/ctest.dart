import 'package:flutter/material.dart';
import 'package:friendlyeats/components/backDropEx.dart';

class CTest extends StatefulWidget {
  @override
  _CTestState createState() => _CTestState();
}

class _CTestState extends State<CTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Page title'),
        actions: [
          Icon(Icons.favorite),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.search),
          ),
          // Icon(Icons.more_vert),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              const PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.add),
                  title: Text('Item 1'),
                ),
              ),
              const PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.anchor),
                  title: Text('Item 2'),
                ),
              ),
              const PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.article),
                  title: Text('Item 3'),
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(child: Text('Item A')),
              const PopupMenuItem(child: Text('Item B')),
            ],
          ),
        ],
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          MaterialBanner(
            backgroundColor: Colors.cyan,
            content: const Text('Banner Example'),
            leading: CircleAvatar(child: Icon(Icons.delete)),
            actions: [
              FlatButton(
                child: const Text('ACTION 1'),
                onPressed: () {},
              ),
              FlatButton(
                child: const Text('ACTION 2'),
                onPressed: () {},
              ),
            ],
          ),
          RaisedButton(child: Text('BackDropEx'), onPressed: () {}),
          Builder(builder: (context) {
            return Center(
              child: TextButton(
                child: Text('show buttom sheet'),
                onPressed: () {
                  showBottomSheet(
                      context: context,
                      builder: (context) {
                        return Wrap(
                          children: [
                            ListTile(
                              leading: Icon(Icons.share),
                              title: Text('Share'),
                            ),
                            ListTile(
                              leading: Icon(Icons.link),
                              title: Text('Get link'),
                            ),
                            ListTile(
                              leading: Icon(Icons.edit),
                              title: Text('Edit name'),
                            ),
                            ListTile(
                              leading: Icon(Icons.delete),
                              title: Text('Delete collection'),
                            ),
                          ],
                        );
                      });
                },
              ),
            );
          }),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.yellow,
        shape: CircularNotchedRectangle(),
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.menu), onPressed: () {}),
            Spacer(),
            IconButton(icon: Icon(Icons.search), onPressed: () {}),
            IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          label: Text('BackDropEx'),
          icon: Icon(Icons.all_inclusive),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BackDropEx()),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
