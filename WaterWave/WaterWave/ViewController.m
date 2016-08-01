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
    WaterView *v=[[WaterView alloc] initWithFrame:CGRectMake(0, 100, [[UIScreen mainScreen] bounds].size.width, 10) WithWaveHeight:100 WithColors:@[[UIColor blueColor],[UIColor grayColor],[UIColor yellowColor]]];
    [self.view addSubview:v];
}

@end
