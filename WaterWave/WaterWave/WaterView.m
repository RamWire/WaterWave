//
//  WaterView.m
//  WaterWave
//
//  Created by mobi on 16/1/6.
//  Copyright © 2016年 snapking. All rights reserved.
//

#import "WaterView.h"

@interface WaterView()

@end

@implementation WaterView {
    UIColor *waterFirstColor;
    UIColor *waterSecondColor;
    CGFloat waterLineY;
    BOOL increase;
}

-(instancetype)initWithFrame:(CGRect)frame WithWaveHeight:(CGFloat)waveHeight WithColors:(NSArray *)waveColors {
    self=[super initWithFrame:frame];
    if (self) {
        _waveAmplitude = 3.0;
        _waveCycle = 1.0;
        increase = NO;
        if (waveColors.count > 1) {
            for (NSInteger i = 0; i < waveColors.count; i++) {
                if ([waveColors[i] isKindOfClass:[UIColor class]]) {
                    switch (i) {
                        case 0:
                            [self setBackgroundColor:waveColors[0]];
                            break;
                        case 1:
                            waterFirstColor = waveColors[1];
                            break;
                        case 2:
                            waterSecondColor = waveColors[2];
                            break;
                        default:
                            break;
                    }
                }
            }
        }
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height > 25?frame.size.height:25);
        waterLineY = (self.frame.size.height > waveHeight)?self.frame.size.height - waveHeight:20.0;
        CADisplayLink *waveDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(runWave)];
        [waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}

#pragma mark - SetMethod
- (void)setWaveAmplitudes:(CGFloat)waveAmplitudes {
    _waveAmplitude = waveAmplitudes;
}

- (void)setWaveCycle:(CGFloat)waveCycle {
    _waveCycle = waveCycle;
}

- (void)setWaveSpeed:(CGFloat)waveSpeed {
    _waveSpeed = waveSpeed;
}

#pragma mark - WaveChange
-(void)runWave {
    if (increase) {
        _waveAmplitude += 0.02;
    }else{
        _waveAmplitude -= 0.02;
    }
    if (_waveAmplitude<=1) {
        increase = YES;
    }
    if (_waveAmplitude>=1.5) {
        increase = NO;
    }
    _waveCycle+= _waveSpeed > 0?_waveSpeed:0.1;
    [self setNeedsDisplay];
}

#pragma mark - DrawRect
- (void)drawRect:(CGRect)rect {
    //初始化画布
    CGContextRef context = UIGraphicsGetCurrentContext();
    //推入
    CGContextSaveGState(context);
    //定义前波浪path
    CGMutablePathRef frontPath = CGPathCreateMutable();
    //定义后波浪path
    CGMutablePathRef backPath = CGPathCreateMutable();
    //定义前波浪反色path
    CGMutablePathRef frontReversePath = CGPathCreateMutable();
    //定义后波浪反色path
    CGMutablePathRef backReversePath = CGPathCreateMutable();
    //画水
    CGContextSetLineWidth(context, 1);
    //前波浪位置初始化
    float frontY = waterLineY;
    CGPathMoveToPoint(frontPath, NULL, 0, frontY);
    //前波浪反色位置初始化
    float frontReverseY = waterLineY;
    CGPathMoveToPoint(frontReversePath, NULL, 0,frontReverseY);
    //后波浪位置初始化
    float backY = waterLineY;
    CGPathMoveToPoint(backPath, NULL, 0, backY);
    //后波浪反色位置初始化
    float backReverseY = waterLineY;
    CGPathMoveToPoint(backReversePath, NULL, 0, backReverseY);
    for(float x = 0;x <= [[UIScreen mainScreen] bounds].size.width;x++){
        //前波浪绘制
        frontY = _waveAmplitude * sin( x/180*M_PI + 4*_waveCycle/M_PI ) * 5 + waterLineY;
        CGPathAddLineToPoint(frontPath, nil, x, frontY);
        //后波浪绘制
        backY = _waveAmplitude * cos( x/180*M_PI + 3*_waveCycle/M_PI ) * 5 + waterLineY;
        CGPathAddLineToPoint(backPath, nil, x, backY);
        if (x>=100) {
            //后波浪反色绘制
            backReverseY =  _waveAmplitude * cos( x/180*M_PI + 3*_waveCycle/M_PI ) * 5 + waterLineY;
            CGPathAddLineToPoint(backReversePath, nil, x, backReverseY);
            //前波浪反色绘制
            frontReverseY =  _waveAmplitude * sin( x/180*M_PI + 4*_waveCycle/M_PI ) * 5 + waterLineY;
            CGPathAddLineToPoint(frontReversePath, nil, x, frontReverseY);
        }
    }
    //后波浪绘制
    CGContextSetFillColorWithColor(context, [waterSecondColor CGColor]);
    CGPathAddLineToPoint(backPath, nil, [[UIScreen mainScreen] bounds].size.width, rect.size.height);
    CGPathAddLineToPoint(backPath, nil, 0, rect.size.height);
    CGPathAddLineToPoint(backPath, nil, 0, waterLineY);
    CGPathCloseSubpath(backPath);
    CGContextAddPath(context, backPath);
    CGContextFillPath(context);
    //推入
    CGContextSaveGState(context);
    //后波浪反色绘制
    CGPathAddLineToPoint(backReversePath, nil, [[UIScreen mainScreen] bounds].size.width, rect.size.height);
    CGPathAddLineToPoint(backReversePath, nil, 100, rect.size.height);
    CGPathAddLineToPoint(backReversePath, nil, 100, waterLineY);
    CGContextAddPath(context, backReversePath);
    CGContextClip(context);
    // CGContextSaveGState(context);
    //弹出
    CGContextRestoreGState(context);
    //前波浪绘制
    CGContextSetFillColorWithColor(context, [waterFirstColor CGColor]);
    CGPathAddLineToPoint(frontPath, nil, [[UIScreen mainScreen] bounds].size.width, rect.size.height);
    CGPathAddLineToPoint(frontPath, nil, 0, rect.size.height);
    CGPathAddLineToPoint(frontPath, nil, 0, waterLineY);
    CGPathCloseSubpath(frontPath);
    CGContextAddPath(context, frontPath);
    CGContextFillPath(context);
    //推入
    CGContextSaveGState(context);
    //前波浪反色绘制
    CGPathAddLineToPoint(frontReversePath, nil, [[UIScreen mainScreen] bounds].size.width, rect.size.height);
    CGPathAddLineToPoint(frontReversePath, nil, 100, rect.size.height);
    CGPathAddLineToPoint(frontReversePath, nil, 100, waterLineY);
    CGContextAddPath(context, frontReversePath);
    CGContextClip(context);
    //推入
    CGContextSaveGState(context);
    //释放
    CGPathRelease(backPath);
    CGPathRelease(backReversePath);
    CGPathRelease(frontPath);
    CGPathRelease(frontReversePath);    
}

@end
