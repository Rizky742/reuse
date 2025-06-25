class ReviewsModel {
  final int rating;
  final String comment;
  final String productId;

  ReviewsModel({
    required this.rating,
    required this.comment,
    required this.productId,
  });

  factory ReviewsModel.fromJson(Map<String, dynamic> json) {
    return ReviewsModel(
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      productId: json['productId'] ?? '',
    );
  }
}
