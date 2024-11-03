class PropertyImage {
  final String url;
  final bool isPrimary;
  final String? caption;

  PropertyImage({
    required this.url,
    this.isPrimary = false,
    this.caption,
  });

  Map<String, dynamic> toJson() => {
        'url': url,
        'isPrimary': isPrimary,
        'caption': caption,
      };

  factory PropertyImage.fromJson(Map<String, dynamic> json) => PropertyImage(
        url: json['url'],
        isPrimary: json['isPrimary'],
        caption: json['caption'],
      );
}
