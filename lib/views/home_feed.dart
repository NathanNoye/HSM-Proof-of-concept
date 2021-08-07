import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hsm_poc/core/constants.dart';
import 'package:hsm_poc/models/carousel_model.dart';
import 'package:hsm_poc/models/sermon_model.dart';
import 'package:hsm_poc/views/sermon_details_screen.dart';
import 'package:hsm_poc/widgets/carousel.dart';

class HomeFeed extends StatefulWidget {
  @override
  _HomeFeedState createState() => _HomeFeedState();
}

class _HomeFeedState extends State<HomeFeed> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
          child: Column(
        children: [
          Carousel(
            items: carouselModels,
          ),
          SizedBox(
            height: 20,
          ),
          _generateRow('Most Popular', mostPopular),
          _generateRow('Recent Updates', recentUpdates),
          _buildInstagramPost('Latest from Instagram', '@hsm_hillsi',
              'assets/instagram_post.jpg'),
          _generateRow('Upcoming Events', events),
          _generateRow('HSM Swag', clothes),
          _buildInstagramPost('New Volunteer Position', 'Apply in the More Tab',
              'assets/volunteer.jpg'),
          _generateRow('Jesus Is', jesusIsSermons),
          _generateRow('Life Lines', lifeLines),
          _generateRow('Grace Is', graceis),
          SizedBox(
            height: 100,
          )
        ],
      )),
    );
  }

  Widget _generateRow(String title, List<SermonModel> sermons) {
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: Text(title,
            style: TextStyle(
                color: kTextColor, fontWeight: FontWeight.w900, fontSize: 28)),
      ),
      Container(
        height: 250,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: sermons.length,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) =>
                _buildTileItem(sermons[index])),
      )
    ]));
  }

  Widget _buildTileItem(SermonModel sermon) {
    double screenSize = MediaQuery.of(context).size.width;

    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment(0, 0),
            children: [
              Container(
                  height: ((screenSize * 0.7) / (16 / 9)).clamp(100, 300),
                  width: (screenSize * 0.7).clamp(200, 500),
                  margin: EdgeInsets.fromLTRB(
                      kDefaultPadding / 2,
                      kDefaultPadding / 2,
                      kDefaultPadding,
                      kDefaultPadding / 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Hero(
                      tag: sermon.title,
                      child: Image.asset(
                        sermon.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding),
            child: Text(sermon.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding),
            child: Text(sermon.speaker,
                style: TextStyle(fontSize: 16, color: kTextLightColor)),
          )
        ],
      ),
      onTap: () {
        if (sermon.type == SermonCardType.event ||
            sermon.type == SermonCardType.clothes ||
            sermon.type == SermonCardType.newsletter ||
            sermon.type == SermonCardType.volunteer) {
          bottomSheet(sermon);
          return;
        }

        if (sermon.noClick) {
          return;
        }

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SermonDetailsScreen(
                      model: sermon,
                    )));
      },
    );
  }

  Widget _buildInstagramPost(String title, String subtitle, String asset) {
    return Container(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(
            kDefaultPadding / 2, kDefaultPadding / 2, kDefaultPadding / 2, 0),
        child: Text(title,
            style: TextStyle(
                color: kTextColor, fontWeight: FontWeight.w900, fontSize: 28)),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(
            kDefaultPadding / 2, 0, kDefaultPadding / 2, kDefaultPadding / 2),
        child: Text(subtitle,
            style: TextStyle(color: kTextLightColor, fontSize: 16)),
      ),
      Container(
        margin: const EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            asset,
            fit: BoxFit.cover,
          ),
        ),
      )
    ]));
  }

  void bottomSheet(SermonModel model) {
    showModalBottomSheet(
        enableDrag: model.type != SermonCardType.newsletter,
        context: context,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        builder: (BuildContext context) {
          if (model.type == SermonCardType.newsletter) {
            return DraggableScrollableSheet(
              initialChildSize: 1,
              minChildSize: 0.99,
              expand: true,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  dragStartBehavior: DragStartBehavior.down,
                  physics: BouncingScrollPhysics(),
                  child: SingleChildScrollView(
                      child: _createBottomSheetChildren(
                    model,
                  )),
                );
              },
            );
          }

          return Container(
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[_createBottomSheetChildren(model)],
            ),
          );
        });
  }

  Widget _createBottomSheetChildren(SermonModel model) {
    //double screenSize = MediaQuery.of(context).size.width;

    if (model.type == SermonCardType.clothes) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: 200,
              child:
                  Image.asset(model.imagePath.replaceAll(".png", "-nobg.png"))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Wrap(children: [
                  Text(
                    model.title,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  )
                ]),
                SizedBox(height: 5),
                Text('XS  S  M  L  XL  XXL'),
                SizedBox(height: 10),
                Text('Cost: \$${model.cost.toStringAsFixed(2)}'),
                SizedBox(height: 50),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Place order',
                  ),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black)),
                )
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      );
    } else if (model.type == SermonCardType.event) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(model.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Container(
                width: 200,
                child: Text('When: ${model.speaker}',
                    textAlign: TextAlign.left, style: TextStyle(fontSize: 16))),
            SizedBox(height: 5),
            Container(
              width: 200,
              child: Text(
                  'Cost: ${model.cost > 0 ? "\$" + model.cost.toStringAsFixed(2) : "Free!"}',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16)),
            ),
            SizedBox(height: 50),
            TextButton(
              onPressed: () {},
              child: Text(
                'Sign Up',
              ),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black)),
            )
          ],
        ),
      );
    } else if (model.type == SermonCardType.newsletter) {
      return Column(
        children: [
          /*
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                  height: ((screenSize) / (16 / 7)).clamp(100, 300),
                  width: (screenSize).clamp(200, 500),
                  margin: EdgeInsets.only(bottom: kDefaultPadding / 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      model.imagePath,
                      fit: BoxFit.cover,
                    ),
                  )),
              Column(
                children: [
                  SizedBox(height: 60),
                  Text(model.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30)),
                ],
              )
            ],
          ),
          */
          SizedBox(height: 20),
          Text(model.title,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30)),
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Wrap(
              children: [
                Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc auctor egestas nibh vitae consectetur. Sed porttitor ullamcorper egestas. Proin nec dictum ligula, eget consequat nisi. Maecenas quis turpis neque. Etiam ut feugiat massa. Proin ut tristique justo, vestibulum hendrerit nunc. Proin ultricies mi a auctor malesuada. Cras bibendum vulputate porta. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc auctor egestas nibh vitae consectetur. Sed porttitor ullamcorper egestas. Proin nec dictum ligula, eget consequat nisi. Maecenas quis turpis neque. Etiam ut feugiat massa. Proin ut tristique justo, vestibulum hendrerit nunc. Proin ultricies mi a auctor malesuada. Cras bibendum vulputate porta',
                    style: TextStyle(
                      fontSize: 16,
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Wrap(
              children: [
                Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc auctor egestas nibh vitae consectetur. Sed porttitor ullamcorper egestas. Proin nec dictum ligula, eget consequat nisi. Maecenas quis turpis neque. Etiam ut feugiat massa. Proin ut tristique justo, vestibulum hendrerit nunc. Proin ultricies mi a auctor malesuada. Cras bibendum vulputate porta. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc auctor egestas nibh vitae consectetur. Sed porttitor ullamcorper egestas. Proin nec dictum ligula, eget consequat nisi. Maecenas quis turpis neque. Etiam ut feugiat massa. Proin ut tristique justo, vestibulum hendrerit nunc. Proin ultricies mi a auctor malesuada. Cras bibendum vulputate porta',
                    style: TextStyle(
                      fontSize: 16,
                    )),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      );
    }

    return Container();
  }
}

// Temp content until this is grabbed via API
List<CarouselModel> carouselModels = [
  CarouselModel('Sunday Service', '243 Watching live',
      'assets/live_preview.mp4', false, true),
  CarouselModel(
      'August Newsletter', 'Read Now', 'assets/newsletter_bg.png', true, false),
  CarouselModel(
      'New HSM Swag', 'Order Now', 'assets/hsm_clothes.png', false, false),
];
List<SermonModel> mostPopular = [
  SermonModel(
      'The Finale',
      'Pastor Roger Reid',
      'assets/thumbnails/JesusIs4.png',
      'https://www.youtube.com/watch?v=WdkdHFu9QNo&list=PLbMfNdlwiS7nMzvL-DVnYRBKvmvamK4uj&index=4'),
  SermonModel(
      'Seriously Getting Serious',
      'Pastor Roger Reid',
      'assets/livestream.png',
      'https://www.youtube.com/watch?v=WdkdHFu9QNo&list=PLbMfNdlwiS7nMzvL-DVnYRBKvmvamK4uj&index=4'),
  SermonModel(
      'The Finale',
      'Pastor Dave Steeves',
      'assets/thumbnails/graceis_2.png',
      'https://www.youtube.com/watch?v=voqSvY5JNuI&list=PLbMfNdlwiS7mokKD9CGHfOK-dXcsQlRJv&index=2'),
  SermonModel(
      'What Are lifelines',
      'Pastor Roger Reid',
      'assets/thumbnails/lifelines_part_2.png',
      'https://www.youtube.com/watch?v=-92lUWDSKh4&list=PLbMfNdlwiS7nJBZBKuqbIP7Kh_0sUu821&index=2'),
  SermonModel(
      'What Is Truth',
      'Pastor Roger Reid',
      'assets/thumbnails/JesusIs3.png',
      'https://www.youtube.com/watch?v=QuumeH28HHM&list=PLbMfNdlwiS7nMzvL-DVnYRBKvmvamK4uj&index=3')
];
List<SermonModel> jesusIsSermons = [
  SermonModel(
      'Part 1 - Forgiveness',
      'Pastor Roger Reid',
      'assets/thumbnails/JesusIs1.png',
      'https://www.youtube.com/watch?v=jbNxCcHeZT0&list=PLbMfNdlwiS7nMzvL-DVnYRBKvmvamK4uj&index=1'),
  SermonModel(
      'Part 2 - Good News',
      'Pastor Roger Reid',
      'assets/thumbnails/JesusIs2.png',
      'https://www.youtube.com/watch?v=RJHyMRYrGzk&list=PLbMfNdlwiS7nMzvL-DVnYRBKvmvamK4uj&index=2'),
  SermonModel(
      'Part 3 - What Is Truth',
      'Pastor Roger Reid',
      'assets/thumbnails/JesusIs3.png',
      'https://www.youtube.com/watch?v=QuumeH28HHM&list=PLbMfNdlwiS7nMzvL-DVnYRBKvmvamK4uj&index=3'),
  SermonModel(
      'Part 4 - The Finale',
      'Pastor Roger Reid',
      'assets/thumbnails/JesusIs4.png',
      'https://www.youtube.com/watch?v=WdkdHFu9QNo&list=PLbMfNdlwiS7nMzvL-DVnYRBKvmvamK4uj&index=4')
];
List<SermonModel> recentUpdates = [
  SermonModel(
      'New HSM clothing available',
      'Order now while in stock',
      'assets/hsm_clothes.png',
      'https://www.youtube.com/watch?v=-92lUWDSKh4&list=PLbMfNdlwiS7nJBZBKuqbIP7Kh_0sUu821&index=2',
      noClick: true,
      type: SermonCardType.other),
  SermonModel(
      'August Newsletter',
      'Stay up to date this week',
      'assets/newsletter_bg.png',
      'https://www.youtube.com/watch?v=V2tCRI388mA&list=PLbMfNdlwiS7nJBZBKuqbIP7Kh_0sUu821&index=1',
      noClick: true,
      type: SermonCardType.newsletter),
];
List<SermonModel> lifeLines = [
  SermonModel(
      'Part 1 - Intro',
      'Pastor Roger Reid',
      'assets/thumbnails/lifelines_part_1.png',
      'https://www.youtube.com/watch?v=V2tCRI388mA&list=PLbMfNdlwiS7nJBZBKuqbIP7Kh_0sUu821&index=1'),
  SermonModel(
      'Part 2 - What Are lifelines',
      'Pastor Roger Reid',
      'assets/thumbnails/lifelines_part_2.png',
      'https://www.youtube.com/watch?v=-92lUWDSKh4&list=PLbMfNdlwiS7nJBZBKuqbIP7Kh_0sUu821&index=2'),
  SermonModel(
      'Part 3 - Friends As lifelines',
      'Pastor Roger Reid',
      'assets/thumbnails/lifelines_part_3.png',
      'https://www.youtube.com/watch?v=xoBotynKjxY&list=PLbMfNdlwiS7nJBZBKuqbIP7Kh_0sUu821&index=3'),
  SermonModel(
      'Part 4 - The Finale',
      'Pastor Roger Reid',
      'assets/thumbnails/lifelines_part_4.png',
      'https://www.youtube.com/watch?v=1Sa-d48hJJM&list=PLbMfNdlwiS7nJBZBKuqbIP7Kh_0sUu821&index=4')
];
List<SermonModel> graceis = [
  SermonModel(
      'Part 1 - Intro',
      'Pastor Roger Reid',
      'assets/thumbnails/graceis_1.png',
      'https://www.youtube.com/watch?v=c6CkBjoKZQA&list=PLbMfNdlwiS7mokKD9CGHfOK-dXcsQlRJv&index=1'),
  SermonModel(
      'Part 2 - The Finale',
      'Pastor Dave Steeves',
      'assets/thumbnails/graceis_2.png',
      'https://www.youtube.com/watch?v=voqSvY5JNuI&list=PLbMfNdlwiS7mokKD9CGHfOK-dXcsQlRJv&index=2'),
];
List<SermonModel> events = [
  SermonModel(
    'Nacho night',
    'September 12, 2021',
    'assets/events/nacho_night.jpg',
    'https://www.youtube.com/watch?v=c6CkBjoKZQA&list=PLbMfNdlwiS7mokKD9CGHfOK-dXcsQlRJv&index=1',
    noClick: true,
    type: SermonCardType.event,
  ),
  SermonModel(
    'Mexico Mission Trip',
    'November 25, 2021',
    'assets/events/mission_trip.jpg',
    'https://www.youtube.com/watch?v=voqSvY5JNuI&list=PLbMfNdlwiS7mokKD9CGHfOK-dXcsQlRJv&index=2',
    noClick: true,
    type: SermonCardType.event,
    cost: 3500.00,
  ),
  SermonModel(
    'Winter Retreat',
    'January 10, 2022',
    'assets/events/winter_retreat.jpg',
    'https://www.youtube.com/watch?v=voqSvY5JNuI&list=PLbMfNdlwiS7mokKD9CGHfOK-dXcsQlRJv&index=2',
    noClick: true,
    type: SermonCardType.event,
    cost: 100.00,
  ),
];
List<SermonModel> clothes = [
  SermonModel(
      'New Longsleeves',
      'Starting at 15\$',
      'assets/clothes/black_longsleeve.png',
      'https://www.youtube.com/watch?v=c6CkBjoKZQA&list=PLbMfNdlwiS7mokKD9CGHfOK-dXcsQlRJv&index=1',
      noClick: true,
      type: SermonCardType.clothes,
      cost: 15.00),
  SermonModel(
      'New T-Shirts',
      'Starting at 10\$',
      'assets/clothes/black_tshirt.png',
      'https://www.youtube.com/watch?v=c6CkBjoKZQA&list=PLbMfNdlwiS7mokKD9CGHfOK-dXcsQlRJv&index=1',
      noClick: true,
      type: SermonCardType.clothes,
      cost: 10.00),
  SermonModel(
      'New Hoodies',
      'Starting at 30\$',
      'assets/clothes/red_hoodie.png',
      'https://www.youtube.com/watch?v=c6CkBjoKZQA&list=PLbMfNdlwiS7mokKD9CGHfOK-dXcsQlRJv&index=1',
      noClick: true,
      type: SermonCardType.clothes,
      cost: 30.00),
];
