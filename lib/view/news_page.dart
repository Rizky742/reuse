import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reuse/theme.dart';
import 'package:reuse/view/news_detail_page.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample news data
    final List<Map<String, dynamic>> newsItems = [
      {
        'title': 'Reducing Plastic Pollution in Oceans',
        'date': '12 Nov 2023',
        'image': 'https://images.pexels.com/photos/802221/pexels-photo-802221.jpeg',
        'content': 'New initiatives to clean up plastic pollution in oceans are showing promising results...'
      },
      {
        'title': 'Sustainable Packaging Trends',
        'date': '5 Nov 2023',
        'image': 'https://images.pexels.com/photos/1108572/pexels-photo-1108572.jpeg',
        'content': 'Companies are increasingly adopting eco-friendly packaging solutions to reduce waste...'
      },
      {
        'title': 'Zero Waste Movement Gains Momentum',
        'date': '28 Oct 2023',
        'image': 'https://images.pexels.com/photos/2827735/pexels-photo-2827735.jpeg',
        'content': 'More people are joining the zero waste movement to minimize their environmental impact...'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'News',
          style: heading3.copyWith(color: primary),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              Text(
                'Latest Updates',
                style: heading2.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),
              Text(
                'Stay informed about sustainability and environmental news',
                style: body2.copyWith(color: Colors.grey),
              ),
              SizedBox(height: 24.h),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: newsItems.length,
                itemBuilder: (context, index) {
                  final news = newsItems[index];
                  return NewsCard(
                    title: news['title'],
                    date: news['date'],
                    imageUrl: news['image'],
                    content: news['content'],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final String title;
  final String date;
  final String imageUrl;
  final String content;

  const NewsCard({
    super.key,
    required this.title,
    required this.date,
    required this.imageUrl,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero animation for smooth transition
          Hero(
            tag: 'news-image-$title',
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
              child: Image.network(
                imageUrl,
                height: 160.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        date,
                        style: caption2.copyWith(color: primary),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  title,
                  style: heading3.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.h),
                Text(
                  content,
                  style: body2.copyWith(color: Colors.grey[700]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 12.h),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to detail page with article information
                    Get.to(() => NewsDetailPage(
                          title: title,
                          date: date,
                          imageUrl: imageUrl,
                          content: content,
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text('Read More'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 