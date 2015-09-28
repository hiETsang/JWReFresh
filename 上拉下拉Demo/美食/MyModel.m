//
//  MyModel.m
//  美食
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//

#import "MyModel.h"

@implementation MyModel

+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (NSArray *)dataArray
{
    NSArray *dicts = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"quanquan.plist" ofType:nil]];
    NSMutableArray *arrayM = [[NSMutableArray alloc] init];
    for(NSDictionary *dict in dicts[1])
    {
        MyModel *model = [MyModel modelWithDict:dict];
        [arrayM addObject:model];
    }
    return arrayM;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@ - %p>", self.class,self];
}

@end
