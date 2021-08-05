enum SermonCardType { sermon, event, volunteer, clothes, other, newsletter }

class SermonModel {
  final String title;
  final String speaker;
  final String imagePath;
  final String url;
  final bool noClick;
  final SermonCardType type;
  final double cost;

  SermonModel(this.title, this.speaker, this.imagePath, this.url,
      {this.noClick = false,
      this.type = SermonCardType.sermon,
      this.cost = 0.00});
}
