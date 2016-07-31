//
//  HooCircleProgressView.m
//  HooCircleProgressView
//
//  Created by HooJackie on 16/7/31.
//  Copyright © 2016年 PIngAnHealth. All rights reserved.
//

#import "HooCircleProgressView.h"
#import "HooCircleGradientLayer.h"

@implementation HooCircleProgressView {
  HooCircleGradientLayer *_gradientLayer;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];
  if (self) {
    [self initView:[self frame]];
  }
  return self;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    [self initView:CGRectZero];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self initView:frame];
  }
  return self;
}

- (void)initView:(CGRect)frame {
  [self setBackgroundColor:[UIColor clearColor]];

  _gradientLayer = [self progressLayer];
  _gradientLayer.startColor = [UIColor blackColor];
  _gradientLayer.endColor = [UIColor greenColor];

  [self updateLayerData:frame];

  self.progress = 1;
  self.lineWidth = 3;
}

- (void)setProgress:(CGFloat)progress {
  _progress = MAX(0, MIN(1, progress));
  _gradientLayer.progress = progress;
}

- (void)setLineWidth:(CGFloat)value {
  _lineWidth = value;
  [self updateLayerData:self.frame];
}

- (void)setStartColor:(UIColor *)startColor {
  _startColor = startColor;
  _gradientLayer.startColor = startColor;
}

- (void)setEndColor:(UIColor *)endColor {
  _endColor = endColor;
  _gradientLayer.endColor = endColor;
}

- (void)setStartAngle:(CGFloat)startAngle {
  _startAngle = startAngle;
  _gradientLayer.startAngle = startAngle;
}

- (void)setEndAngle:(CGFloat)endAngle {
  _endAngle = endAngle;
  _gradientLayer.endAngle = endAngle;
}

- (void)updateLayerData:(CGRect)frame {
  int numSegments = 16;
  CGFloat circleRadius = MIN(CGRectGetWidth(frame), CGRectGetHeight(frame)) / 2;
  CGFloat circleWidth = _lineWidth;

  _gradientLayer.frame = frame;
  _gradientLayer.numSegments = numSegments;
  _gradientLayer.circleRadius = circleRadius;
  _gradientLayer.circleWidth = circleWidth;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  [self updateLayerData:self.frame];
}

- (void)setProgress:(CGFloat)progress
    animateWithDuration:(NSTimeInterval)duration {
  float currentValue = self.progress;
  self.progress = progress;
  self.progressLayer.progress = progress;

  CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"progress"];
  anim.fromValue = @(currentValue);
  anim.toValue = @(progress);
  anim.duration = duration;
  anim.repeatCount = 0;
  anim.autoreverses = NO;
  anim.removedOnCompletion = YES;
  anim.timingFunction =
      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
  [self.progressLayer addAnimation:anim forKey:@"progress"];
}

- (void)abortAnimation {
  [self.progressLayer removeAnimationForKey:@"progress"];
}

- (HooCircleGradientLayer *)progressLayer {
  HooCircleGradientLayer *layer = (HooCircleGradientLayer *)self.layer;
  layer.contentsScale = [UIScreen mainScreen].scale;
  return layer;
}

+ (Class)layerClass {
  return [HooCircleGradientLayer class];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
