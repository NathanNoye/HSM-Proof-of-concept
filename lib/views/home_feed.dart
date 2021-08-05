import 'package:flutter/cupertino.dart';
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
          _buildInstagramPost(
              'Latest from Instagram', 'assets/instagram_post.jpg'),
          _generateRow('Jesus Is', jesusIsSermons),
          _generateRow('Life Lines', lifeLines),
          _generateRow('Grace Is', graceis),
          SizedBox(
            height: 60,
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
          Container(
              height: ((screenSize * 0.7) / (16 / 9)).clamp(100, 300),
              width: (screenSize * 0.7).clamp(200, 500),
              margin: EdgeInsets.fromLTRB(kDefaultPadding / 2,
                  kDefaultPadding / 2, kDefaultPadding, kDefaultPadding / 2),
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
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding),
            child: Text(sermon.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: kDefaultPadding),
            child: Text(sermon.speaker,
                style: TextStyle(fontSize: 16, color: kTextLightColor)),
          ),
        ],
      ),
      onTap: () {
        debugPrint(sermon.title);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SermonDetailsScreen(
                      model: sermon,
                    )));
      },
    );
  }

  Widget _buildInstagramPost(String title, String asset) {
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
        child: Text('@hsm_hillside',
            style: TextStyle(color: kTextLightColor, fontSize: 16)),
      ),
      Container(
        margin: const EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          //borderRadius: BorderRadius.circular(12),
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
      'Jesus Is Part 4 - The Finale',
      'Pastor Roger Reid',
      'assets/thumbnails/JesusIs4.png',
      'https://www.youtube.com/watch?v=WdkdHFu9QNo&list=PLbMfNdlwiS7nMzvL-DVnYRBKvmvamK4uj&index=4'),
  SermonModel(
      'Seriously Getting Serious',
      'Pastor Roger Reid',
      'assets/livestream.png',
      'https://www.youtube.com/watch?v=WdkdHFu9QNo&list=PLbMfNdlwiS7nMzvL-DVnYRBKvmvamK4uj&index=4'),
  SermonModel(
      'Grace Is Part 2 - The Finale',
      'Pastor Dave Steeves',
      'assets/thumbnails/graceis_2.png',
      'https://www.youtube.com/watch?v=voqSvY5JNuI&list=PLbMfNdlwiS7mokKD9CGHfOK-dXcsQlRJv&index=2'),
  SermonModel(
      'Lifelines Part 2 - What Are lifelines',
      'Pastor Roger Reid',
      'assets/thumbnails/lifelines_part_2.png',
      'https://www.youtube.com/watch?v=-92lUWDSKh4&list=PLbMfNdlwiS7nJBZBKuqbIP7Kh_0sUu821&index=2'),
  SermonModel(
      'Jesus Is Part 3 - What Is Truth',
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
      'New HSM clothing avaiable',
      'Order now while in stock',
      'assets/hsm_clothes.png',
      'https://www.youtube.com/watch?v=-92lUWDSKh4&list=PLbMfNdlwiS7nJBZBKuqbIP7Kh_0sUu821&index=2'),
  SermonModel(
      'August Newsletter',
      'Stay up to date this week',
      'assets/newsletter_bg.png',
      'https://www.youtube.com/watch?v=V2tCRI388mA&list=PLbMfNdlwiS7nJBZBKuqbIP7Kh_0sUu821&index=1'),
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
