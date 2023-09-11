import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double fahTemp = 0.0, celTemp = 0.0;
  bool isFah = true;
  var fahController = TextEditingController();
  var celController = TextEditingController();

  fahListener() {
    setState(() {
      fahTemp = double.parse(fahController.text);
      celTemp = convert(fahTemp, true);
      if (isFah) celController.text = celTemp.toStringAsFixed(2);
      isFah = true;
    });
  }

  celListener() {
    setState(() {
      celTemp = double.parse(celController.text);
      fahTemp = convert(celTemp, false);
      if (!isFah) fahController.text = fahTemp.toStringAsFixed(2);
      isFah = false;
    });
  }

  double convert(double temp, bool isF) {
    return isF ? (temp - 32) * (5 / 9) : (temp * 9 / 5) + 32;
  }

  @override
  void initState() {
    fahController.addListener(fahListener);
    celController.addListener(celListener);
    super.initState();
  }

  @override
  void dispose() {
    fahController.dispose();
    celController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Center(child: Text('Temperature Converter App')),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Celsius',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: celController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  suffix: Text('°C'),
                ),
                onChanged: (value) {},
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Fahrenheit',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: fahController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  suffix: Text('°F'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Result:',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                isFah ? '$celTemp °C' : '$fahTemp °F',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isFah = !isFah;
                    if (isFah) {
                      fahController.text = fahTemp.toStringAsFixed(2);
                    } else {
                      celController.text = celTemp.toStringAsFixed(2);
                    }
                  });
                },
                child:
                    Text(isFah ? 'Switch to Fahrenheit' : 'Switch to Celsius'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
