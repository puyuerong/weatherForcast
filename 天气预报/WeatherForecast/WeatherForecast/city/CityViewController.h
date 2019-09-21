//
//  CityViewController.h
//  WeatherForecast
//
//  Created by 蒲悦蓉 on 2019/8/13.
//  Copyright © 2019 蒲悦蓉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CityViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property NSMutableArray *array;
@property NSInteger page;
@property NSMutableArray *contentArray;
@end

NS_ASSUME_NONNULL_END
