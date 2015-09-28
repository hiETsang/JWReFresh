//
//  MyCell.m
//  美食
//
//  Created by qianfeng on 15/9/22.
//  Copyright (c) 2015年 1000phone. All rights reserved.
//

#import "MyCell.h"

@interface MyCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;

@end

@implementation MyCell

-(void)setModel:(MyModel *)model
{
    _model = model;
    
    self.iconView.image = [UIImage imageNamed:model.icon];
    self.titleLabel.text = model.title;
    self.noteLabel.text = model.note;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *nibName = [NSString stringWithFormat:@"%@",self.class];
    [tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:nibName];
    
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:nibName];
    
    return cell;
}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
