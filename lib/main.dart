/*import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RandomApiPage(),
    );
  }
}

class RandomApiPage extends StatefulWidget {
  const RandomApiPage({super.key});

  @override
  State<RandomApiPage> createState() => _RandomApiPageState();
}

class _RandomApiPageState extends State<RandomApiPage> {

  int _randomNumber = 1; // Initial random number

  Future<void> fetchData(int number) async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users/$number'));

    if (response.statusCode == 200) {
      // Successful response
      final responseData = json.decode(response.body);
      print(responseData); // Handle the API response data as needed
    } else {
      // Handle error response
      print('Error fetching data: ${response.statusCode}');
    }
  }

  void getRandomNumberAndFetchData() {
    final random = Random();
    final newRandomNumber = random.nextInt(12) + 1; // Generates a random number between 1 and 12
    setState(() {
      _randomNumber = newRandomNumber;
    });
    fetchData(_randomNumber);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:
             Column(
              children: [
                CircleAvatar(
                //  backgroundImage: NetworkImage(detail[index].image),
                ),
                ElevatedButton(
                  onPressed: getRandomNumberAndFetchData,
                  child: Text('Fetch Data for Random Number $_randomNumber'),
                ),
              ],)
    );
  }
}*/

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _randomNumber = 1;

  Future<Map<String, dynamic>> fetchUserData(int userId) async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users/$userId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  void getRandomNumberAndFetchData() {
    final random = Random();
    final newRandomNumber = random.nextInt(12) + 1; // Generates a random number between 1 and 12
    setState(() {
      _randomNumber = newRandomNumber;
    });
    fetchUserData(_randomNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        title: Text('Fetch Random Data', style: TextStyle(color: Colors.black),),
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>>(
          future: fetchUserData(_randomNumber), // Change the user ID here to fetch different responses
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    trailing: CircleAvatar(
                      backgroundColor: Colors.lightGreenAccent,
                      radius: 50,
                      backgroundImage: NetworkImage(snapshot.data?['data']['avatar']),
                    ),
                    title: Text(
                    '${snapshot.data?['data']['first_name']} ${snapshot.data?['data']['last_name']}',
                    style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      ' ${snapshot.data?['data']['email']}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.lightGreenAccent),
                    onPressed: getRandomNumberAndFetchData,
                    child: Text('Fetch Data $_randomNumber', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}


