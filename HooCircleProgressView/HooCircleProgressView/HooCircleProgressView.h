//
//  HooCircleProgressView.h
//  HooCircleProgressView
//
//  Created by HooJackie on 16/7/31.
//  Copyright © 2016年 PIngAnHealth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HooCircleProgressView : UIView

@property(nonatomic, assign) CGFloat progress;
@property(nonatomic, assign) CGFloat lineWidth;
@property(nonatomic, strong) UIColor *startColor;
@property(nonatomic, strong) UIColor *endColor;
@property(nonatomic, assign) CGFloat startAngle;
@property(nonatomic, assign) CGFloat endAngle;

- (void)setProgress:(CGFloat)progress
    animateWithDuration:(NSTimeInterval)duration;

- (void)abortAnimation;
@end
