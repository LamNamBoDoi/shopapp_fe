import 'package:get/get.dart';
import 'package:shopapp_v1/data/model/body/review.dart';
import 'package:shopapp_v1/data/model/user.dart';
import 'package:shopapp_v1/data/repository/review_repo.dart';

class ReviewController extends GetxController implements GetxService {
  final ReviewRepo repo;
  ReviewController({required this.repo});

  List<Review> _listReview = <Review>[];
  bool _isLoading = false;

  List<Review> get listReview => _listReview;
  bool get isLoading => _isLoading;

  Future<int?> createReview(Review review) async {
    _isLoading = true;
    update();

    try {
      Response response = await repo.createReview(review: review);
      return response.statusCode;
    } catch (e) {
      print("Lỗi khi tạo đánh giá: $e");
      return null;
    } finally {
      _isLoading = false;
      update();
    }
  }

  Future<void> getReviewByUserId(User user) async {
    _isLoading = true;
    update();

    try {
      Response response = await repo.getReviewByUserId(user: user);
      if (response.statusCode == 200) {
        var responseData = response.body["payload"];
        if (responseData is List) {
          _listReview = responseData
              .map<Review>((json) => Review.fromJson(json))
              .toList();
        } else {
          throw Exception("Unexpected response format");
        }
      } else {
        print("Lỗi khi lấy đánh giá: ${response.statusCode}");
      }
    } catch (e) {
      print("Lỗi khi lấy danh sách đánh giá: $e");
    } finally {
      _isLoading = false;
      update();
    }
  }
}
