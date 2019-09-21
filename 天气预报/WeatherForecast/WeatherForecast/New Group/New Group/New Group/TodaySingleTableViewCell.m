//
//  TodaySingleTableViewCell.m
//  WeatherForecast
//
//  Created by 蒲悦蓉 on 2019/8/12.
//  Copyright © 2019 蒲悦蓉. All rights reserved.
//

#import "TodaySingleTableViewCell.h"

@implementation TodaySingleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.titleLabel = [[UILabel alloc] init];
    self.contentLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(20, 10, 375, 20);
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    self.contentLabel.frame = CGRectMake(20, 35, 375, 40);
    self.contentLabel.font = [UIFont systemFontOfSize:30];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
