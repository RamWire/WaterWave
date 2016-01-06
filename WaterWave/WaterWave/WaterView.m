//
//  WaterView.m
//  WaterWave
//
//  Created by mobi on 16/1/6.
//  Copyright © 2016年 snapking. All rights reserved.
//

#import "WaterView.h"

@interface WaterView()
{
    UIColor *_waterColor;
    CGFloat _waterLineY;
    CGFloat _waveAmplitude;
    CGFloat _waveCycle;
    BOOL increase;
    NSTimer *_waveTimer;
}

@end

@implementation WaterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor grayColor]];
        _waveAmplitude=3.0;
        _waveCycle=1.0;
        increase=NO;
        _waterColor=[UIColor colorWithRed:88/255.0f green:202/255.0f blue:139/255.0f alpha:1];
        _waterLineY=120.0;
        
        //run wave
        _waveTimer =  [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(runWave) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_waveTimer forMode:NSRunLoopCommonModes];
    }
    return self;
}

-(void)runWave
{
    
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
    
    _waveCycle+=0.1;
    
    [self setNeedsDisplay];
}

-(NSMutableAttributedString *) formatBatteryLevel:(NSInteger)percent
{
    UIColor *textColor=[UIColor redColor];
    //设置
    NSMutableAttributedString *mutableText;
    
    NSString *percentText=[NSString stringWithFormat:@"%ld%%",(long)percent];
    
    NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
    [paragrahStyle setAlignment:NSTextAlignmentCenter];
    if (percent<10) {
        mutableText=[[NSMutableAttributedString alloc] initWithString:percentText];
        UIFont *capacityNumberFont=[UIFont fontWithName:@"HelveticaNeue-Thin" size:80];
        UIFont *capacityPercentFont=[UIFont fontWithName:@"HelveticaNeue-Thin" size:40];
        [mutableText addAttribute:NSFontAttributeName value:capacityNumberFont range:NSMakeRange(0, 1)];
        [mutableText addAttribute:NSFontAttributeName value:capacityPercentFont range:NSMakeRange(1, 1)];
        [mutableText addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(0, 2)];
        [mutableText  addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:NSMakeRange(0, 2)];
        
    }
    else
    {
        mutableText=[[NSMutableAttributedString alloc] initWithString:percentText];
        UIFont *capacityNumberFont=[UIFont fontWithName:@"HelveticaNeue-Thin" size:80];
        UIFont *capacityPercentFont=[UIFont fontWithName:@"HelveticaNeue-Thin" size:40];
        
        
        if (percent>=100) {
            
            [mutableText addAttribute:NSFontAttributeName value:capacityNumberFont range:NSMakeRange(0, 3)];
            [mutableText addAttribute:NSFontAttributeName value:capacityPercentFont range:NSMakeRange(3, 1)];
            [mutableText addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(0, 4)];
            [mutableText addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:NSMakeRange(0, 4)];
        }
        else
        {
            [mutableText addAttribute:NSFontAttributeName value:capacityNumberFont range:NSMakeRange(0, 2)];
            [mutableText addAttribute:NSFontAttributeName value:capacityPercentFont range:NSMakeRange(2, 1)];
            [mutableText addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(0, 3)];
            [mutableText  addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:NSMakeRange(0, 3)];
        }
        
    }
    
    
    return mutableText;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //初始化画布
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSMutableAttributedString *attriButedText=[self formatBatteryLevel:50];
    CGRect textSize = [attriButedText boundingRectWithSize:CGSizeMake(400, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    CGPoint textPoint = CGPointMake(320/2-textSize.size.width/2, 70);
    [attriButedText drawAtPoint:textPoint];
    
    //推入
    CGContextSaveGState(context);
    
    
    //定义前波浪path
    CGMutablePathRef frontPath = CGPathCreateMutable();
    
    //定义后波浪path
    CGMutablePathRef backPath=CGPathCreateMutable();
    
    //定义前波浪反色path
    CGMutablePathRef frontInversePath = CGPathCreateMutable();
    
    //定义后波浪反色path
    CGMutablePathRef backInversePath=CGPathCreateMutable();
    
    //画水
    CGContextSetLineWidth(context, 1);
    
    
    //前波浪位置初始化
    float frontY=_waterLineY;
    CGPathMoveToPoint(frontPath, NULL, 0, frontY);
    
    //前波浪反色位置初始化
    float frontInverseY=_waterLineY;
    CGPathMoveToPoint(frontInversePath, NULL, 0,frontInverseY);
    
    //后波浪位置初始化
    float backY=_waterLineY;
    CGPathMoveToPoint(backPath, NULL, 0, backY);
    
    //后波浪反色位置初始化
    float backInverseY=_waterLineY;
    CGPathMoveToPoint(backInversePath, NULL, 0, backInverseY);
    
    for(float x=0;x<=320;x++){
        
        //前波浪绘制
        frontY= _waveAmplitude * sin( x/180*M_PI + 4*_waveCycle/M_PI ) * 5 + _waterLineY;
        CGPathAddLineToPoint(frontPath, nil, x, frontY);
        
        //后波浪绘制
        backY= _waveAmplitude * cos( x/180*M_PI + 3*_waveCycle/M_PI ) * 5 + _waterLineY;
        CGPathAddLineToPoint(backPath, nil, x, backY);
        
        
        if (x>=100) {
            
            //后波浪反色绘制
            backInverseY= _waveAmplitude * cos( x/180*M_PI + 3*_waveCycle/M_PI ) * 5 + _waterLineY;
            CGPathAddLineToPoint(backInversePath, nil, x, backInverseY);
            
            //前波浪反色绘制
            frontInverseY= _waveAmplitude * sin( x/180*M_PI + 4*_waveCycle/M_PI ) * 5 + _waterLineY;
            CGPathAddLineToPoint(frontInversePath, nil, x, frontInverseY);
        }
    }
    
    //后波浪绘制
    CGContextSetFillColorWithColor(context, [[UIColor orangeColor] CGColor]);
    CGPathAddLineToPoint(backPath, nil, 320, rect.size.height);
    CGPathAddLineToPoint(backPath, nil, 0, rect.size.height);
    CGPathAddLineToPoint(backPath, nil, 0, _waterLineY);
    CGPathCloseSubpath(backPath);
    CGContextAddPath(context, backPath);
    CGContextFillPath(context);
    
    //推入
    CGContextSaveGState(context);
    
    //后波浪反色绘制
    CGPathAddLineToPoint(backInversePath, nil, 320, rect.size.height);
    CGPathAddLineToPoint(backInversePath, nil, 100, rect.size.height);
    CGPathAddLineToPoint(backInversePath, nil, 100, _waterLineY);
    
    CGContextAddPath(context, backInversePath);
    CGContextClip(context);
    [attriButedText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, attriButedText.length)];
    [attriButedText drawAtPoint:textPoint];
    
    
    // CGContextSaveGState(context);
    //弹出
    CGContextRestoreGState(context);
    
    //前波浪绘制
    CGContextSetFillColorWithColor(context, [_waterColor CGColor]);
    CGPathAddLineToPoint(frontPath, nil, 320, rect.size.height);
    CGPathAddLineToPoint(frontPath, nil, 0, rect.size.height);
    CGPathAddLineToPoint(frontPath, nil, 0, _waterLineY);
    CGPathCloseSubpath(frontPath);
    CGContextAddPath(context, frontPath);
    CGContextFillPath(context);
    
    //推入
    CGContextSaveGState(context);
    
    
    //前波浪反色绘制
    CGPathAddLineToPoint(frontInversePath, nil, 320, rect.size.height);
    CGPathAddLineToPoint(frontInversePath, nil, 100, rect.size.height);
    CGPathAddLineToPoint(frontInversePath, nil, 100, _waterLineY);
    
    CGContextAddPath(context, frontInversePath);
    CGContextClip(context);
    [attriButedText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, attriButedText.length)];
    [attriButedText drawAtPoint:textPoint];
    
    //推入
    CGContextSaveGState(context);
    
    
    //释放
    CGPathRelease(backPath);
    CGPathRelease(backInversePath);
    CGPathRelease(frontPath);
    CGPathRelease(frontInversePath);
    
}

@end
