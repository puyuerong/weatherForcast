//
//  ForecastTableViewCell.h
//  WeatherForecast
//
//  Created by 蒲悦蓉 on 2019/8/12.
//  Copyright © 2019 蒲悦蓉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ForecastTableViewCell : UITableViewCell
@property UILabel *dataLabel;
@property UIImageView *weatherImageView;
@property UILabel *maxLabel;
@property UILabel *minLabel;
@end

NS_ASSUME_NONNULL_END
