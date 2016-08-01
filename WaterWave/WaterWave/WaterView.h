//
//  WaterView.h
//  WaterWave
//
//  Created by mobi on 16/1/6.
//  Copyright © 2016年 snapking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterView : UIView
/**
 *  WaterView Init
 *
 *  @param frame      view's frame.
 *  @param waveHeight the height of WaterView.
 *  @param waveColors View's backgroundColor,FirstWaveColor,SecondWaveColor.
 *
 *  @return 
 */
-(instancetype)initWithFrame:(CGRect)frame WithWaveHeight:(CGFloat)waveHeight WithColors:(NSArray *)waveColors;
/**
 *  The range of wave can reach,default is 3.0.
 */
@property (nonatomic, assign) CGFloat waveAmplitude;
/**
 *  Initial cycle of wave's animation,default is 1.0.
 */
@property (nonatomic, assign) CGFloat waveCycle;
/**
 *  The speed of wave moving,you can control wave spread speed by this parameter,default is 0.1.
 */
@property (nonatomic, assign) CGFloat waveSpeed;

@end
