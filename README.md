# 开源控件HooCircleProgressView


>工作中开发健康走步的功能，需要用到一个环形计步的控件，看了几个开源项目，没有达到自己理想，所以动手写了一个，今天再把它整理了一下，方便开源给需要的朋友调用。


A circular gradient progress view implementation for iOS with efficient drawing using a series of arcs with linear gradient.

一个圆环形进度条，支持颜色渐变


`HooCircleProgressView Demo picture:`


![HooCircleProgressView Demo](https://github.com/jakciehoo/HooCircleProgressView/blob/master/HooCircleProgressView/HooCircleProgressViewDemo.jpg)

## 下载地址链接:[HooCircleProgressView](https://github.com/jakciehoo/HooCircleProgressView)


# `如何使用How To Use:`
==================================================

```java  
HooCircleProgressView *progressView =
      [[HooCircleProgressView alloc] initWithFrame:(CGRect){0, 0, 240, 240}];
  [_progressView setCenter:self.view.center];
  [_progressView setLineWidth:6.0f];
  [_progressView setProgress:0.0f];
    [_progressView setStartColor:[UIColor greenColor]];
  [_progressView setEndColor:[UIColor yellowColor]];
  [self.view addSubview:_progressView];
  [progressView setProgress:1.0f animateWithDuration:AnimationDuration];

```   
