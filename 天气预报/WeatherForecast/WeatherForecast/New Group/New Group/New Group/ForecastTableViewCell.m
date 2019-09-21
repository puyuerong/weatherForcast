//
//  ForecastTableViewCell.m
//  WeatherForecast
//utf8 urlencode
//  Created by 蒲悦蓉 on 2019/8/12.
//  Copyright © 2019 蒲悦蓉. All rights reserved.
//

#import "ForecastTableViewCell.h"

@implementation ForecastTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}            /*行高40*/

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.dataLabel = [[UILabel alloc] init];
    self.weatherImageView = [[UIImageView alloc] init];
    self.maxLabel = [[UILabel alloc] init];
    self.minLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.dataLabel];
    [self.contentView addSubview:self.weatherImageView];
    [self.contentView addSubview:self.maxLabel];
    [self.contentView addSubview:self.minLabel];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.dataLabel.frame = CGRectMake(20, 10, 120, 30);
    self.weatherImageView.frame = CGRectMake(170, 10, 30, 30);
    self.maxLabel.frame = CGRectMake(270, 10, 30, 30);
    self.minLabel.frame = CGRectMake(320, 10, 30, 30);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
