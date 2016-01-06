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
    // Do any additional setup after loading the view, typically from a nib.
    
    WaterView *v=[[WaterView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:v];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
