//
//  MyCell.h
//  美食
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyModel.h"

@interface MyCell : UITableViewCell

@property(nonatomic,strong)MyModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
