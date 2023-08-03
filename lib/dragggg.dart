import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Draggable Cards',
      home: Scaffold(
        appBar: AppBar(title: Text('Draggable Cards')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardContainer(),
          ],
        ),
      ),
    );
  }
}

class CardContainer extends StatefulWidget {
  @override
  _CardContainerState createState() => _CardContainerState();
}

class _CardContainerState extends State<CardContainer> {
  List<String> cardTitles = ['Card 1', 'Card 2', 'Card 3', 'Card 4', 'Card 5'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 200, // Sesuaikan dengan ketinggian yang diinginkan
        child: ReorderableListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: cardTitles.length,
          itemBuilder: (BuildContext context, int index) {
            final title = cardTitles[index];
            return Container(
              key: ValueKey(title),
              width: 120, // Sesuaikan dengan lebar yang diinginkan
              child: Card(
                color: Colors.black,
                child: ListTile(
                  title: Text(
                    title,
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: InkWell(
                      onTap: () {
                        print("Index sekarang yaitu : ${index}");
                      },
                      child: Icon(Icons.drag_handle)),
                ),
              ),
            );
          },
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (newIndex > oldIndex) {
                newIndex -= 1;
              }
              final String cardTitle = cardTitles.removeAt(oldIndex);
              cardTitles.insert(newIndex, cardTitle);
            });
          },
        ),
      ),
    );
  }
}
