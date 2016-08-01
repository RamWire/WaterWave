//
//  ViewController.m
//  WaterWave
//
//  Created by snapking on 16/1/6.
//  Copyright © 2016年 snapking. All rights reserved.
//

#import "ViewController.h"
#import "WaterView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WaterView *v = [[WaterView alloc] initWithFrame:CGRectMake(0, 100, [[UIScreen mainScreen] bounds].size.width, 80) WithWaveHeight:40 WithColors:@[[UIColor clearColor],[UIColor grayColor],[UIColor yellowColor]]];
    v.waveAmplitude = 4.0;
    v.waveCycle = 1.0;
    v.waveSpeed = 0.03;
    [self.view addSubview:v];
}

@end
