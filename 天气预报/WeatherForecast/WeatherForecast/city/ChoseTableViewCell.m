//
//  ChoseTableViewCell.m
//  WeatherForecast
//
//  Created by 蒲悦蓉 on 2019/8/13.
//  Copyright © 2019 蒲悦蓉. All rights reserved.
//

#import "ChoseTableViewCell.h"

@implementation ChoseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
   /*行高90*/
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.timeLabel = [[UILabel alloc] init];
    self.locationLabel = [[UILabel alloc] init];
    self.temperatureLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.locationLabel];
    [self.contentView addSubview:self.temperatureLabel];
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.timeLabel.frame = CGRectMake(20, 15, 250, 20);
    self.timeLabel.font = [UIFont systemFontOfSize:16];
    self.locationLabel.frame = CGRectMake(20, 40, 250, 35);
    self.locationLabel.font = [UIFont systemFontOfSize:30];
    self.temperatureLabel.frame = CGRectMake(260, 20, 100, 50);
    self.temperatureLabel.font = [UIFont systemFontOfSize:50];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
