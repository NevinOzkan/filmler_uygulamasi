import 'package:filmler_uygulamasi/FilmlerSayfa.dart';
import 'package:filmler_uygulamasi/Kategoriler.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {
  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  Future<List<Kategoriler>> tumKategorileriGoster() async {
    var kategoriListesi = <Kategoriler>[];

    var k1 = Kategoriler(1, "Komedi");
    var k2 = Kategoriler(2, "Bilim Kurgu");

    kategoriListesi.add(k1);
    kategoriListesi.add(k2);

    return kategoriListesi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kategoriler"),
      ),
      body: FutureBuilder<List<Kategoriler>>(
          future: tumKategorileriGoster(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var kategoriListesi = snapshot.data;
              return ListView.builder(
                itemCount: kategoriListesi!.length,
                itemBuilder: (context, index) {
                  var kategori = kategoriListesi[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FilmlerSayfa(
                              kategori: kategori,
                            ),
                          ));
                    },
                    child: Card(
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(kategori.kategori_ad),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center();
            }
          }),
    );
  }
}
