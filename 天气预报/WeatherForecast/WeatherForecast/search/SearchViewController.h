//
//  SearchViewController.h
//  WeatherForecast
//
//  Created by 蒲悦蓉 on 2019/8/12.
//  Copyright © 2019 蒲悦蓉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol searchViewControllerDelegate <NSObject>
- (void)pushSelected:(BOOL)selected;
@end

@interface SearchViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property NSMutableArray *array;
@property id<searchViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
