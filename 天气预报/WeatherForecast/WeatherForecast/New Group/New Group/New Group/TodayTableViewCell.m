//
//  TodayTableViewCell.m
//  WeatherForecast
//
//  Created by 蒲悦蓉 on 2019/8/12.
//  Copyright © 2019 蒲悦蓉. All rights reserved.
//

#import "TodayTableViewCell.h"

@implementation TodayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
  /*行高70*/

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.title1Label = [[UILabel alloc] init];
    self.title2Label = [[UILabel alloc] init];
    self.leftLabel = [[UILabel alloc] init];
    self.rightLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.title1Label];
    [self.contentView addSubview:self.title2Label];
    [self.contentView addSubview:self.leftLabel];
    [self.contentView addSubview:self.rightLabel];
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.title1Label.frame = CGRectMake(20, 10, 150, 20);
    self.title1Label.font = [UIFont systemFontOfSize:12];
    self.title1Label.textColor = [UIColor colorWithRed:0.38f green:0.38f blue:0.41f alpha:1.00f];
    self.title2Label.frame = CGRectMake(190, 10, 150, 20);
    self.title2Label.font = [UIFont systemFontOfSize:12];
    self.title2Label.textColor = [UIColor colorWithRed:0.38f green:0.38f blue:0.41f alpha:1.00f];
    self.leftLabel.frame = CGRectMake(20, 30, 150, 40);
    self.leftLabel.font = [UIFont systemFontOfSize:16];
    self.leftLabel.textColor = [UIColor whiteColor];
    self.rightLabel.frame = CGRectMake(190, 30, 150, 40);
    self.rightLabel.font = [UIFont systemFontOfSize:16];
    self.rightLabel.textColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
