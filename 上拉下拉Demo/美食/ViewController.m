//
//  ViewController.m
//  美食
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//

#import "ViewController.h"
#import "MyModel.h"
#import "ContentView.h"

@interface ViewController ()

@property(nonatomic,strong)NSArray *dataArray;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取数据
    _dataArray = [MyModel dataArray];
    
    //加载视图
    ContentView *contentView = [ContentView contentView];
    contentView.dataArray = _dataArray;
    [self.view addSubview:contentView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
