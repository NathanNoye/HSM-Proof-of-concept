import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hsm_poc/models/carousel_model.dart';
import 'package:hsm_poc/widgets/videoplayer.dart';

class Carousel extends StatelessWidget {
  final List<CarouselModel> items;

  const Carousel({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: items.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 10, bottom: 20),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 2),
                    ),
                  ]),
                  child: buildChild(i));
            },
          );
        }).toList(),
        options: CarouselOptions(
          height: 250,
          aspectRatio: 16 / 9,
          viewportFraction: 0.95,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 10),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ));
  }

  Widget buildChild(CarouselModel model) {
    if (model.isNewsLetter) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: AssetImage(model.imagePath), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
              model.title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            )),
            Center(
                child: Text(model.subtitle,
                    style: TextStyle(color: Colors.white, fontSize: 20)))
          ],
        ),
      );
    } else if (model.isLive) {
      return Container(
        child: Stack(
          children: [
            ClipRRect(
              child: VideoApp(assetPath: model.imagePath),
              borderRadius: BorderRadius.circular(20),
            ),
            Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'LIVE',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w900),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.red[600],
                      borderRadius: BorderRadius.circular(10)),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Text(
                  model.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )),
                Center(
                    child: Text(model.subtitle,
                        style: TextStyle(color: Colors.white, fontSize: 20)))
              ],
            )
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: AssetImage(model.imagePath), fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            model.title,
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          )),
          Center(
              child: Text(model.subtitle,
                  style: TextStyle(color: Colors.white, fontSize: 20)))
        ],
      ),
    );
  }
}
