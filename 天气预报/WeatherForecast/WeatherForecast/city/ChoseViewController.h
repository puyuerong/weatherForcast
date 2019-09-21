//
//  ChoseViewController.h
//  WeatherForecast
//
//  Created by 蒲悦蓉 on 2019/8/13.
//  Copyright © 2019 蒲悦蓉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface ChoseViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource, NSURLSessionDelegate, searchViewControllerDelegate>
@property NSInteger backTag;
@end

NS_ASSUME_NONNULL_END
