//
//  HooCircleGradientLayer.h
//  HooCircleProgressView
//
//  Created by HooJackie on 16/7/31.
//  Copyright © 2016年 PIngAnHealth. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface HooCircleGradientLayer : CALayer

@property(nonatomic, assign) CGFloat progress;
@property(nonatomic, strong) UIColor *startColor;
@property(nonatomic, strong) UIColor *endColor;
@property(nonatomic, assign) CGFloat startAngle;
@property(nonatomic, assign) CGFloat endAngle;
@property(nonatomic, assign) int numSegments;
@property(nonatomic, assign) CGFloat circleRadius;
@property(nonatomic, assign) CGFloat circleWidth;

@end
