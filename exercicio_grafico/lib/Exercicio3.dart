import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(MyApp());
}

class ClubStats {
  final String clubName;
  final int goals;
  final int assists;
  final int titles;
  final String clubImage;
  final String gifUrl;

  ClubStats({
    required this.clubName,
    required this.goals,
    required this.assists,
    required this.titles,
    required this.clubImage,
    required this.gifUrl,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cristiano Ronaldo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<ClubStats> clubStatsList = [
    ClubStats(
      clubName: 'Manchester United',
      goals: 118,
      assists: 68,
      titles: 9,
      clubImage: 'assets/manchester_united.png',
      gifUrl: 'https://tenor.com/bLDQX.gif',
    ),
    ClubStats(
      clubName: 'Real Madrid',
      goals: 450,
      assists: 131,
      titles: 16,
      clubImage: 'assets/real_madrid.png',
      gifUrl: 'https://tenor.com/WE07.gif',
    ),
    ClubStats(
      clubName: 'Juventus',
      goals: 101,
      assists: 35,
      titles: 5,
      clubImage: 'assets/juventus.png',
      gifUrl: 'https://media.giphy.com/media/IORjYvIQ8bIaU/giphy.gif',
    ),
    ClubStats(
      clubName: 'Portugal',
      goals: 115,
      assists: 50,
      titles: 3,
      clubImage: 'assets/portugal.png',
      gifUrl: 'https://tenor.com/bo0ia.gif',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(clubStatsList[_currentIndex].clubName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/cristiano_ronaldo.jpg',
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            Text(
              'Gols: ${clubStatsList[_currentIndex].goals}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Assistências: ${clubStatsList[_currentIndex].assists}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Títulos: ${clubStatsList[_currentIndex].titles}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            // GIF de gol
            CachedNetworkImage(
              imageUrl: clubStatsList[_currentIndex].gifUrl,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: clubStatsList.map((clubStats) {
          return BottomNavigationBarItem(
            icon: Image.asset(
              clubStats.clubImage,
              width: 30,
              height: 30,
            ),
            label: clubStats.clubName,
          );
        }).toList(),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
      ),
    );
  }
}
