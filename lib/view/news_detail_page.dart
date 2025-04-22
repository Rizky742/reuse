import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:reuse/theme.dart';

class NewsDetailPage extends StatelessWidget {
  final String title;
  final String date;
  final String imageUrl;
  final String content;

  const NewsDetailPage({
    super.key,
    required this.title,
    required this.date,
    required this.imageUrl,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar with Hero image
            SliverAppBar(
              expandedHeight: 240.h,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: 'news-image-$title',
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              leading: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  margin: EdgeInsets.only(left: 16.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.arrow_back, color: primary),
                ),
              ),
            ),
            // Content
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date badge
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        date,
                        style: caption1.copyWith(color: primary, fontWeight: semiBold),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    
                    // Title
                    Text(
                      title,
                      style: heading1.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 24.h),
                    
                    // Expanded content - this would be the full article
                    Text(
                      // The full content (we'll expand the sample content)
                      _getFullContent(),
                      style: body1.copyWith(
                        color: Colors.black87,
                        height: 1.6,
                      ),
                    ),
                    
                    SizedBox(height: 30.h),
                    
                    // Share and bookmark section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildActionButton(Icons.share, 'Share'),
                        SizedBox(width: 30.w),
                        _buildActionButton(Icons.bookmark_border, 'Bookmark'),
                      ],
                    ),
                    
                    SizedBox(height: 30.h),
                    
                    // Related news section
                    Text(
                      'Related News',
                      style: heading3.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16.h),
                    
                    _buildRelatedNewsItem(
                      'Eco-Friendly Alternatives to Single-Use Plastics',
                      'https://images.pexels.com/photos/3850512/pexels-photo-3850512.jpeg',
                    ),
                    SizedBox(height: 12.h),
                    _buildRelatedNewsItem(
                      'How Businesses are Going Green in 2023',
                      'https://images.pexels.com/photos/3184465/pexels-photo-3184465.jpeg',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: primary, size: 24.w),
        ),
        SizedBox(height: 6.h),
        Text(
          label,
          style: caption2.copyWith(color: Colors.grey[700]),
        ),
      ],
    );
  }

  Widget _buildRelatedNewsItem(String title, String imageUrl) {
    return GestureDetector(
      onTap: () {
        // Navigate to the related news (for now, just go back)
        Get.back();
      },
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                imageUrl,
                width: 70.w,
                height: 70.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: body2.copyWith(fontWeight: FontWeight.w500),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16.w, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // Helper method to expand the sample content
  String _getFullContent() {
    // Depending on which article we're showing
    if (title.contains('Plastic Pollution')) {
      return '''New initiatives to clean up plastic pollution in oceans are showing promising results. These efforts combine technology, community action, and policy changes to address this growing environmental crisis.

Marine plastic pollution has become one of the most pressing environmental issues of our time. Each year, millions of tons of plastic waste enter our oceans, harming marine life, damaging ecosystems, and even entering our food chain.

Several innovative approaches are now being implemented globally:

1. Ocean Cleanup Projects: Large-scale systems designed to collect plastic from oceanic garbage patches are now operational. These passive systems use ocean currents to collect plastic while allowing marine life to swim beneath them.

2. River Interception: Since rivers are major pathways for plastic to enter oceans, new technologies are being deployed to intercept waste before it reaches the sea.

3. Biodegradable Alternatives: Companies are developing truly biodegradable alternatives to conventional plastics, particularly for single-use items.

4. Community Cleanup Initiatives: Coastal communities worldwide are organizing regular beach cleanups and awareness campaigns.

5. Policy Changes: More countries are implementing bans on single-use plastics and introducing extended producer responsibility schemes.

Scientists estimate that if these combined approaches continue to gain momentum, we could see a significant reduction in new plastic entering our oceans within the next decade. However, cleaning up existing pollution remains a challenge that will require continued innovation and commitment.

What can individuals do? Reducing personal plastic consumption, properly disposing of waste, participating in local cleanup efforts, and supporting businesses and policies that prioritize environmental protection all make a difference.

The fight against ocean plastic pollution demonstrates how combined efforts across technology, policy, and community action can begin to address even the most daunting environmental challenges.''';
    } else if (title.contains('Sustainable Packaging')) {
      return '''Companies are increasingly adopting eco-friendly packaging solutions to reduce waste and meet growing consumer demand for sustainable products. This shift represents a significant trend in how businesses approach their environmental impact.

The packaging industry is undergoing a transformation driven by environmental concerns, consumer preferences, and regulatory changes. Traditional packaging materials like plastic, which can take hundreds of years to decompose, are being reconsidered in favor of more sustainable alternatives.

Key trends in sustainable packaging include:

1. Biodegradable Materials: Made from plant-based sources like cornstarch, mushrooms, and seaweed, these materials break down naturally in composting conditions.

2. Recycled Content: Brands are increasing the percentage of post-consumer recycled materials in their packaging, creating demand for recycled materials and reducing virgin resource use.

3. Minimalist Design: Companies are rethinking packaging design to use less material while maintaining product protection.

4. Reusable Systems: Some businesses are exploring refillable containers and packaging that can be returned, cleaned, and reused multiple times.

5. Water-Soluble Packaging: For appropriate products, packaging that dissolves in water offers an innovative solution.

Major corporations are leading this change, with companies like Unilever committing to 100% recyclable, reusable, or compostable packaging by 2025. Smaller businesses and startups are often at the cutting edge, developing new materials and approaches that larger companies later adopt.

The shift is being driven not only by environmental concerns but also by changing consumer preferences. Studies show that consumers—particularly younger demographics—are willing to pay more for products with sustainable packaging and favor brands that demonstrate environmental responsibility.

However, challenges remain. Sustainable materials often cost more than conventional options, creating a barrier for widespread adoption. Additionally, some alternatives may not offer the same protective qualities or shelf life as traditional packaging.

Despite these challenges, the trend toward sustainable packaging continues to accelerate. As technology improves and scale increases, costs are expected to decrease, making sustainable options more accessible for businesses of all sizes.

The evolution of packaging demonstrates how environmental considerations are becoming increasingly integrated into business operations—not just as a matter of corporate responsibility but as a response to changing market demands and regulations.''';
    } else {
      return '''More people are joining the zero waste movement to minimize their environmental impact and live more sustainably. This growing lifestyle approach focuses on reducing consumption and waste generation.

The zero waste movement has gained significant traction in recent years as awareness of environmental issues like plastic pollution, climate change, and resource depletion has increased. At its core, the philosophy aims to send nothing to landfill by refusing, reducing, reusing, recycling, and composting resources.

Key principles of the zero waste lifestyle include:

1. Refusing unnecessary items (like single-use plastics and free promotional products)
2. Reducing consumption overall
3. Reusing and repairing items rather than discarding them
4. Recycling what cannot be refused, reduced, or reused
5. Composting organic waste

Proponents of zero waste often adopt specific practices such as:

• Shopping with reusable bags, jars, and containers
• Buying unpackaged produce and bulk foods
• Making homemade versions of products that typically come in packaging
• Choosing durable, long-lasting items over disposable alternatives
• Composting food scraps and other organic materials

While achieving absolute zero waste is nearly impossible in today's society, the movement emphasizes progress over perfection. Many adherents start by focusing on the "top offenders" in their waste stream and gradually incorporate more zero waste practices over time.

The movement has expanded beyond individual actions to influence businesses and municipalities. Some companies now offer package-free products or take-back programs, while cities have implemented composting programs and plastic bag bans.

Critics note that systemic changes in production and waste management are needed alongside individual efforts. They point out that personal zero waste practices alone cannot solve global waste issues, and that access to zero waste options varies greatly depending on location and socioeconomic factors.

Despite these limitations, the zero waste movement continues to grow, inspiring people to reconsider their relationship with consumption and waste. As more individuals adopt these practices, demand for sustainable alternatives increases, potentially driving broader systemic changes.

The movement reflects a growing recognition that current consumption patterns are unsustainable and that reducing waste is an essential component of addressing environmental challenges.''';
    }
  }
} 