import 'package:flutter/material.dart';
import 'package:tlp_client/tlp_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'TLP DEMO'),
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
  final awesome = TlpClient();

  @override
  void initState() {
    super.initState();
    st();
  }

  st() async {
    await awesome.initialize();
    awesome.start(
      onMessage: (message) {
        print("SOME MSG $message");
      },
    );
  }

  void _incrementCounter() {
    awesome.sendTlpMessage(
      BigInt.from(300),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 30),
            const Text("TLP HISTORY: DEMO"),
            const SizedBox(height: 30),
            Expanded(
              child: StreamBuilder(
                  stream: awesome.db.getSavedTlps(),
                  builder: (context, snap) {
                    final datas = snap.data ?? [];
                    return ListView.builder(
                      itemCount: datas.length,
                      itemBuilder: (context, index) {
                        final data = datas[index];
                        return ListTile(
                          title: Text(data.fingerprint),
                          subtitle: Text(data.createdAt.toString()),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
