import 'package:hsm_poc/models/sermon_model.dart';

class EventModel extends SermonModel {
  final DateTime eventTime;
  final double cost;

  EventModel(String title, String speaker, String imagePath, String url,
      {required this.eventTime, required this.cost})
      : super(title, speaker, imagePath, url);
}
