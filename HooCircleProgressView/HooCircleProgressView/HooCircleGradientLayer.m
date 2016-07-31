//
//  HooCircleGradientLayer.m
//  HooCircleProgressView
//
//  Created by HooJackie on 16/7/31.
//  Copyright © 2016年 PIngAnHealth. All rights reserved.
//

#import "HooCircleGradientLayer.h"

@implementation HooCircleGradientLayer

- (instancetype)init {
  if (self = [super init]) {
    self.startAngle = -M_PI_2;
    self.endAngle = 2 * M_PI - M_PI_2;
  }
  return self;
}

- (instancetype)initWithLayer:(id)param {
  if (self = [super initWithLayer:param]) {
    HooCircleGradientLayer *layer = (HooCircleGradientLayer *)param;
    self.progress = layer.progress;
    self.startColor = layer.startColor;
    self.endColor = layer.endColor;
    self.startAngle = layer.startAngle;
    self.endAngle = layer.endAngle;
    self.numSegments = layer.numSegments;
    self.circleRadius = layer.circleRadius;
    self.circleWidth = layer.circleWidth;
  }
  return self;
}

- (void)setNumSegments:(int)numSegments {
  _numSegments = MAX(2, numSegments);
  [self setNeedsDisplay];
}

- (void)setCircleRadius:(CGFloat)circleRadius {
  _circleRadius = circleRadius;
  [self setNeedsDisplay];
}

- (void)setCircleWidth:(CGFloat)circleWidth {
  _circleWidth = circleWidth;
  [self setNeedsDisplay];
}

- (void)setProgress:(CGFloat)progress {
  _progress = MAX(0, MIN(1, progress));
  [self setNeedsDisplay];
}

+ (BOOL)needsDisplayForKey:(NSString *)key {
  if ([key isEqualToString:@"startColor"]) {
    return YES;
  }
  if ([key isEqualToString:@"endColor"]) {
    return YES;
  }
  if ([key isEqualToString:@"startAngle"]) {
    return YES;
  }
  if ([key isEqualToString:@"endAngle"]) {
    return YES;
  }
  if ([key isEqualToString:@"progress"]) {
    return YES;
  }
  return [super needsDisplayForKey:key];
}

- (void)drawInContext:(CGContextRef)ctx {
  [super drawInContext:ctx];
  [self drawWithSegmentNumber:_numSegments - 1 contex:ctx];
  [self drawWithSegmentNumber:_numSegments contex:ctx];
}

- (void)drawWithSegmentNumber:(int)segmentCount contex:(CGContextRef)ctx {
  CGRect bounds = self.bounds;
  CGPoint centerPoint =
      CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));

  CGFloat c1[4];
  [_startColor getRed:&c1[0] green:&c1[1] blue:&c1[2] alpha:&c1[3]];
  CGFloat c2[4];
  [_endColor getRed:&c2[0] green:&c2[1] blue:&c2[2] alpha:&c2[3]];

  UIColor *fromColor = self.startColor;
  float endAngle =
      self.startAngle + (self.endAngle - self.startAngle) * self.progress;
  for (int i = 0; i < segmentCount; ++i) {
    float f_cur = (float)(i) / segmentCount;
    float f = (float)(i + 1) / segmentCount;

    UIColor *toColor = [UIColor colorWithRed:f * c2[0] + (1 - f) * c1[0]
                                       green:f * c2[1] + (1 - f) * c1[1]
                                        blue:f * c2[2] + (1 - f) * c1[2]
                                       alpha:f * c2[3] + (1 - f) * c1[3]];

    float fromAngleCur = self.startAngle + f_cur * (endAngle - self.startAngle);
    float toAngleCur = self.startAngle + f * (endAngle - self.startAngle);
    [self drawSegmentAtCenter:centerPoint
                         from:fromAngleCur
                           to:toAngleCur
                       radius:_circleRadius
                        width:_circleWidth
                   startColor:fromColor
                     endColor:toColor
                       contex:ctx];

    fromColor = toColor;
  }
}

- (void)drawSegmentAtCenter:(CGPoint)center
                       from:(CGFloat)startAngle
                         to:(CGFloat)endAngle
                     radius:(CGFloat)radius
                      width:(CGFloat)width
                 startColor:(UIColor *)startColor
                   endColor:(UIColor *)endColor
                     contex:(CGContextRef)ctx {
  CGContextSaveGState(ctx);
  CGContextSetLineWidth(ctx, width);

  UIBezierPath *path = [UIBezierPath bezierPath];
  [path addArcWithCenter:center
                  radius:radius - width * 0.5f
              startAngle:startAngle
                endAngle:endAngle
               clockwise:YES];
  CGContextAddPath(ctx, path.CGPath);
  CGContextReplacePathWithStrokedPath(ctx);
  CGContextClip(ctx);

  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGFloat locations[] = {0.0, 1.0};
  NSArray *colors =
      @[ (__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor ];
  CGGradientRef gradient = CGGradientCreateWithColors(
      colorSpace, (__bridge CFArrayRef)colors, locations);

  CGPoint startPoint =
      CGPointMake(center.x - sinf(startAngle - M_PI_2) * radius,
                  center.y + cosf(startAngle - M_PI_2) * radius);
  CGPoint endPoint = CGPointMake(center.x - sinf(endAngle - M_PI_2) * radius,
                                 center.y + cosf(endAngle - M_PI_2) * radius);
  CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint,
                              kCGGradientDrawsAfterEndLocation |
                                  kCGGradientDrawsBeforeStartLocation);

  CGGradientRelease(gradient);
  CGColorSpaceRelease(colorSpace);

  CGContextRestoreGState(ctx);
}

@end
