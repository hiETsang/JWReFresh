//
//  MyModel.h
//  美食
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyModel : NSObject

@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *cardNumber;
@property(nonatomic,copy) NSString *note;
@property(nonatomic,copy) NSString *icon;

+ (instancetype)modelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

+ (NSArray *)dataArray;

@end
