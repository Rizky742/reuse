import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StarDynamic extends StatelessWidget {
  final double rating;
  final int maxStars;
  final double size;
  final Color activeColor;
  final Color inactiveColor;
  final bool showRating;
  final bool allowHalfRating;
  final EdgeInsetsGeometry? padding;
  final Function(double)? onRatingChanged; // For interactive rating

  const StarDynamic({
    super.key,
    required this.rating,
    this.maxStars = 5,
    this.size = 20,
    this.activeColor = Colors.amber,
    this.inactiveColor = Colors.grey,
    this.showRating = false,
    this.allowHalfRating = true,
    this.padding,
    this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Stars
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(maxStars, (index) {
              return GestureDetector(
                onTap: onRatingChanged != null 
                    ? () => onRatingChanged!(index + 1.0)
                    : null,
                child: _buildStar(index),
              );
            }),
          ),
          
          // Rating text (optional)
          if (showRating) ...[
            SizedBox(width: 6.w),
            Text(
              rating.toStringAsFixed(1),
              style: TextStyle(
                fontSize: (size * 0.7).sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStar(int index) {
    double starRating = rating - index;
    
    if (starRating >= 1.0) {
      // Full star
      return Icon(
        Icons.star,
        size: size.w,
        color: activeColor,
      );
    } else if (starRating >= 0.5 && allowHalfRating) {
      // Half star
      return Icon(
        Icons.star_half,
        size: size.w,
        color: activeColor,
      );
    } else if (starRating > 0 && starRating < 0.5 && allowHalfRating) {
      // Quarter star (using stack for more precise partial stars)
      return _buildPartialStar(starRating);
    } else {
      // Empty star
      return Icon(
        Icons.star_border,
        size: size.w,
        color: inactiveColor,
      );
    }
  }

  Widget _buildPartialStar(double fillPercentage) {
    return Stack(
      children: [
        Icon(
          Icons.star_border,
          size: size.w,
          color: inactiveColor,
        ),
        ClipRect(
          child: Align(
            alignment: Alignment.centerLeft,
            widthFactor: fillPercentage,
            child: Icon(
              Icons.star,
              size: size.w,
              color: activeColor,
            ),
          ),
        ),
      ],
    );
  }
}

// Alternative animated version
class StarDynamicAnimated extends StatefulWidget {
  final double rating;
  final int maxStars;
  final double size;
  final Color activeColor;
  final Color inactiveColor;
  final bool showRating;
  final Duration animationDuration;

  const StarDynamicAnimated({
    super.key,
    required this.rating,
    this.maxStars = 5,
    this.size = 20,
    this.activeColor = Colors.amber,
    this.inactiveColor = Colors.grey,
    this.showRating = false,
    this.animationDuration = const Duration(milliseconds: 500),
  });

  @override
  State<StarDynamicAnimated> createState() => _StarDynamicAnimatedState();
}

class _StarDynamicAnimatedState extends State<StarDynamicAnimated>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controllers = List.generate(
      widget.maxStars,
      (index) => AnimationController(
        duration: Duration(
          milliseconds: widget.animationDuration.inMilliseconds + (index * 100),
        ),
        vsync: this,
      ),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.elasticOut),
      );
    }).toList();

    _startAnimations();
  }

  void _startAnimations() {
    for (int i = 0; i < widget.maxStars; i++) {
      if (i < widget.rating) {
        _controllers[i].forward();
      }
    }
  }

  @override
  void didUpdateWidget(StarDynamicAnimated oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rating != widget.rating) {
      _resetAndStartAnimations();
    }
  }

  void _resetAndStartAnimations() {
    for (var controller in _controllers) {
      controller.reset();
    }
    _startAnimations();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(widget.maxStars, (index) {
            return AnimatedBuilder(
              animation: _animations[index],
              builder: (context, child) {
                return Transform.scale(
                  scale: _animations[index].value,
                  child: _buildAnimatedStar(index),
                );
              },
            );
          }),
        ),
        if (widget.showRating) ...[
          SizedBox(width: 6.w),
          Text(
            widget.rating.toStringAsFixed(1),
            style: TextStyle(
              fontSize: (widget.size * 0.7).sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildAnimatedStar(int index) {
    double starRating = widget.rating - index;
    
    if (starRating >= 1.0) {
      return Icon(
        Icons.star,
        size: widget.size.w,
        color: widget.activeColor,
      );
    } else if (starRating >= 0.5) {
      return Icon(
        Icons.star_half,
        size: widget.size.w,
        color: widget.activeColor,
      );
    } else {
      return Icon(
        Icons.star_border,
        size: widget.size.w,
        color: widget.inactiveColor,
      );
    }
  }
}

// Interactive rating widget
class StarRating extends StatefulWidget {
  final double initialRating;
  final int maxStars;
  final double size;
  final Color activeColor;
  final Color inactiveColor;
  final Function(double) onRatingChanged;
  final bool allowHalfRating;

  const StarRating({
    super.key,
    this.initialRating = 0.0,
    this.maxStars = 5,
    this.size = 30,
    this.activeColor = Colors.amber,
    this.inactiveColor = Colors.grey,
    required this.onRatingChanged,
    this.allowHalfRating = true,
  });

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.maxStars, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _currentRating = index + 1.0;
            });
            widget.onRatingChanged(_currentRating);
          },
          onPanUpdate: widget.allowHalfRating
              ? (details) {
                  RenderBox box = context.findRenderObject() as RenderBox;
                  double pos = box.globalToLocal(details.globalPosition).dx;
                  double starWidth = widget.size;
                  double rating = pos / starWidth;
                  
                  if (rating < 0) rating = 0;
                  if (rating > widget.maxStars) rating = widget.maxStars.toDouble();
                  
                  setState(() {
                    _currentRating = double.parse(rating.toStringAsFixed(1));
                  });
                  widget.onRatingChanged(_currentRating);
                }
              : null,
          child: Icon(
            _getStarIcon(index),
            size: widget.size.w,
            color: _getStarColor(index),
          ),
        );
      }),
    );
  }

  IconData _getStarIcon(int index) {
    double starRating = _currentRating - index;
    
    if (starRating >= 1.0) {
      return Icons.star;
    } else if (starRating >= 0.5 && widget.allowHalfRating) {
      return Icons.star_half;
    } else {
      return Icons.star_border;
    }
  }

  Color _getStarColor(int index) {
    return index < _currentRating ? widget.activeColor : widget.inactiveColor;
  }
}