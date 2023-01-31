import 'package:filmler_uygulamasi/DetaySayfa.dart';
import 'package:filmler_uygulamasi/Filmler.dart';
import 'package:filmler_uygulamasi/Kategoriler.dart';
import 'package:filmler_uygulamasi/Yonetmenler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FilmlerSayfa extends StatefulWidget {
  Kategoriler kategori;
  FilmlerSayfa({required this.kategori});

  @override
  State<FilmlerSayfa> createState() => _FilmlerSayfaState();
}

class _FilmlerSayfaState extends State<FilmlerSayfa> {
  Future<List<Filmler>> FilmleriGoster(int kategori_id) async {
    var FilmlerListesi = <Filmler>[];

    var k1 = Kategoriler(1, "Komedi");
    var y1 = Yonetmenler(1, "Quentin Tarantino");

    var f1 = Filmler(1, "Anadoluda", 2008, "anadoluda.jpg", k1, y1);
    var f2 = Filmler(2, "Django", 2009, "django.jpg", k1, y1);
    var f3 = Filmler(3, "Inception", 2010, "inception.jpg", k1, y1);

    FilmlerListesi.add(f1);
    FilmlerListesi.add(f2);
    FilmlerListesi.add(f3);

    return FilmlerListesi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filmler : ${widget.kategori.kategori_ad} "),
      ),
      body: FutureBuilder<List<Filmler>>(
          future: FilmleriGoster(widget.kategori.kategori_id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var FilmlerListesi = snapshot.data;
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3.5,
                ),
                itemCount: FilmlerListesi!.length,
                itemBuilder: (context, index) {
                  var film = FilmlerListesi[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetaySayfa(
                                    film: film,
                                  )));
                    },
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("Images/${film.film_resim}"),
                          ),
                          Text(
                            film.film_ad,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
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
