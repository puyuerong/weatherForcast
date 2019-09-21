//
//  CityViewController.m
//  WeatherForecast
//
//  Created by 蒲悦蓉 on 2019/8/13.
//  Copyright © 2019 蒲悦蓉. All rights reserved.
//

#import "CityViewController.h"
#import "ForecastTableViewCell.h"
#import "TodayTableViewCell.h"
#import "TodaySingleTableViewCell.h"
#import "SearchViewController.h"
#import "ChoseViewController.h"

@interface CityViewController ()
@property NSMutableArray *headViewArray;
@property NSMutableArray *hourlyArray;
@property NSMutableArray *forecastArray;
@property NSMutableArray *todayArray;                   
@property NSMutableArray *tempArray;
@property NSString *str;
@property UIScrollView *scrollerView;
@property NSInteger i;
@property UIView *headView;
@property BOOL access;
@end
@implementation CityViewController
@synthesize i;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imageView.image = [UIImage imageNamed:@"back4.JPG"];
    [self.view addSubview:imageView];
    
    
    _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 375, 630)];
    _scrollerView.contentSize = CGSizeMake([_array count] * 375, 630);
    _scrollerView.pagingEnabled = YES;
    _scrollerView.delegate = self;
    
   
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [leftButton setImage:[UIImage imageNamed:@"leftImage"] forState:UIControlStateNormal];
    [leftButton setFrame:CGRectMake(20, 630, 30, 30)];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [rightButton setImage:[UIImage imageNamed:@"rightImage"] forState:UIControlStateNormal];
    [rightButton setFrame:CGRectMake(330, 630, 30, 30)];
    [rightButton addTarget:self action:@selector(pressAdd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    [self.view addSubview:rightButton];
    
    _tempArray = [NSMutableArray arrayWithObjects:@"日出", @"日落", @"降雨概率", @"湿度", @"风", @"体感温度", @"降水量", @"气压", @"能见度", @"紫外线指数", nil];
    _todayArray = [[NSMutableArray alloc] init];
    _forecastArray = [[NSMutableArray alloc] init];
    [self.view addSubview:_scrollerView];

    NSLog(@"array = %@", _array);
    
    _headViewArray = [NSMutableArray array];
    _hourlyArray = [NSMutableArray array];
    _forecastArray = [NSMutableArray array];
//    _access = NO;
//    for (i = 0; i < [_array count]; i++) {
//        [self creatPost:_array[i] tableView:nil];
//    }
//    _access = YES;
    for (i = 0; i < [_array count]; i++) {
       
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(375 * i, 0, 375, 630) style:UITableViewStyleGrouped];
        tableView.tag = i;
        [tableView registerClass:[ForecastTableViewCell class] forCellReuseIdentifier:@"forecastCell"];
        [tableView registerClass:[TodaySingleTableViewCell class] forCellReuseIdentifier:@"todaySingelCell"];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor clearColor];
        [self creatPost:_array[i] tableView:tableView];
        [_scrollerView addSubview:tableView];
    }
    [_scrollerView setContentOffset:CGPointMake(_page * 375, 0)];
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 410;
    } else {
        return 0;
    }
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 410)];
        UIScrollView *smallScrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 280, 375, 130)];
        smallScrollerView.contentSize = CGSizeMake(1500, 130);
        
        UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 375, 50)];
        cityLabel.font = [UIFont systemFontOfSize:40];
        cityLabel.textAlignment = NSTextAlignmentCenter;
        UILabel *weatherLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 110, 375, 20)];
        weatherLabel.font = [UIFont systemFontOfSize:20];
        weatherLabel.textAlignment = NSTextAlignmentCenter;
        UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 140, 375, 80)];
        tempLabel.font = [UIFont systemFontOfSize:60];
        tempLabel.textAlignment = NSTextAlignmentCenter;
        UILabel *todayLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 230, 100, 30)];
        todayLabel.font = [UIFont systemFontOfSize:25];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(110, 230, 50, 30)];
        label.text = @"今天";
        label.font = [UIFont systemFontOfSize:20];
        UILabel *maxlabel = [[UILabel alloc] initWithFrame:CGRectMake(255, 230, 50, 25)];
        maxlabel.font = [UIFont systemFontOfSize:30];
        maxlabel.textAlignment = NSTextAlignmentCenter;
        UILabel *minLabel = [[UILabel alloc] initWithFrame:CGRectMake(315, 230, 50, 25)];
        minLabel.font = [UIFont systemFontOfSize:30];
        minLabel.textAlignment = NSTextAlignmentCenter;
        [headView addSubview:todayLabel];
        [headView addSubview:label];
        [headView addSubview:maxlabel];
        [headView addSubview:minLabel];
        [headView addSubview:cityLabel];
        [headView addSubview:weatherLabel];
        [headView addSubview:tempLabel];
        [headView addSubview:smallScrollerView];
        
        NSInteger j;
        
        if ([_headViewArray count] != 0) {
            for (j = 0; j < [_array count]; j++) {
                NSLog(@"%@", _headViewArray[j][5]);
                if ([_headViewArray[j][5] isEqualToString:_array[tableView.tag]]) {
                    break;
                }
            }
            cityLabel.text = _headViewArray[j][5];
            weatherLabel.text = _headViewArray[j][0];
            tempLabel.text = _headViewArray[j][1];
            todayLabel.text = _headViewArray[j][2];
            maxlabel.text = _headViewArray[j][3];
            minLabel.text = _headViewArray[j][4];
            
        }
        
        
        UILabel *tempLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 62.5, 20)];
        tempLabel1.textAlignment = NSTextAlignmentCenter;
        UIImageView *imageView0 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 62.5, 20)];
        UILabel *todayLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 62.5, 20)];
        todayLabel1.textAlignment = NSTextAlignmentCenter;
        todayLabel1.text = @"现在";
        [smallScrollerView addSubview:tempLabel1];
        [smallScrollerView addSubview:imageView0];
        [smallScrollerView addSubview:todayLabel1];
        if ([_forecastArray count] != 0) {
            for (j = 0; j < [_array count]; j++) {
                NSLog(@"%@", _headViewArray[j][5]);
                if ([_headViewArray[j][5] isEqualToString:_array[tableView.tag]]) {
                    break;
                }
            }
            NSLog(@"%@", _forecastArray[j][0][@"wtNm"]);
            imageView0.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", _forecastArray[j][0][@"wtNm"]]];
            tempLabel1.text = _headViewArray[j][1];
        }
        
        
        for (int i = 1; i < 24; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(62.5 * i, 10, 62.5, 20)];
            label.textAlignment = NSTextAlignmentCenter;
            UIImageView *imageViewHour = [[UIImageView alloc] initWithFrame:CGRectMake(62.5 * i, 40, 62.5, 20)];
           UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(62.5 * i, 80, 62.5, 20)];
            tempLabel.textAlignment = NSTextAlignmentCenter;
            if ([_hourlyArray count] != 0) {
                for (j = 0; j < [_array count]; j++) {
                    NSLog(@"%@", _headViewArray[j][5]);
                    if ([_headViewArray[j][5] isEqualToString:_array[tableView.tag]]) {
                        break;
                    }
                }
                tempLabel.text = _hourlyArray[j][i - 1][@"wtTemp"];
                imageViewHour.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", _hourlyArray[j][i - 1][@"wtNm"]]];
                label.text = _hourlyArray[j][i - 1][@"dateYmdh"];
            }
            [smallScrollerView addSubview:label];
            [smallScrollerView addSubview:imageViewHour];
            [smallScrollerView addSubview:tempLabel];
        }
        
        headView.backgroundColor = [UIColor clearColor];
        return headView;
    } else {
        return nil;
    }
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (void)creatPost: (NSString*)str tableView:(UITableView *)tableView {
    NSString *str0 = [NSString stringWithFormat:@"http://api.k780.com/?app=weather.realtime&weaid=%@&ag=today,futureDay,lifeIndex,futureHour&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json", str];
    str0 = [str0 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    NSURL *url = [NSURL URLWithString:str0];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
  //          if (self.access == NO) {
                id objc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"str = %@", str);
               NSMutableArray *tempArray1 = [NSMutableArray arrayWithObjects:objc[@"result"][@"today"][@"wtNm1"],objc[@"result"][@"realTime"][@"wtTemp"], objc[@"result"][@"realTime"][@"week"], objc[@"result"][@"today"][@"wtTemp1"],objc[@"result"][@"today"][@"wtTemp2"],str, nil];
                [self.headViewArray addObject:tempArray1];
               
                
                [self.forecastArray addObject:objc[@"result"][@"futureDay"]];
                
    //            self.todayArray = [NSMutableArray array];
                
               
                [self.hourlyArray addObject:objc[@"result"][@"futureHour"]];
 //           } else {
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [tableView reloadData];
                }];
     //       }
        } else {
            NSLog(@"%@", error);
        }
    }];
    [dataTask resume];
}
- (void)pressAdd {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        if (indexPath.section == 0) {
            return 40;
        } else {
            return 70;
        }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
        if (section == 0) {
            return 5;
        } else {
            if (section == 1) {
                return 1;
            } else {
                return 10;
            }
        }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_forecastArray.count != 0) {
        NSInteger j;
        for (j = 0; j < [_array count]; j++) {
            NSLog(@"%@,arraytableview.tag =  %@", _headViewArray[j][5], _array[tableView.tag]);
            if ([_headViewArray[j][5] isEqualToString:_array[tableView.tag]]) {
                
                break;
            }
        }
        NSLog(@"%ld", j);
        if (indexPath.section == 0) {
            ForecastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"forecastCell" forIndexPath:indexPath];
            NSLog(@"%ld", tableView.tag);
//            NSLog(@"%@", _forecastArray[j][indexPath.row][@"week"]);
            cell.dataLabel.text = _forecastArray[j][indexPath.row][@"week"];
            cell.weatherImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", _forecastArray[j][indexPath.row][@"wtIcon1"]]];
            //            NSLog(@"%@", _forecastArray[tableView.tag][indexPath.row][@"wtTemp1"]);
            cell.maxLabel.text = _forecastArray[j][indexPath.row][@"wtTemp1"];
            cell.minLabel.text = _forecastArray[j][indexPath.row][@"wtTemp2"];
            cell.backgroundColor = [UIColor clearColor];
            return cell;
        } else {
            if (indexPath.section == 2) {
                TodaySingleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"todaySingelCell" forIndexPath:indexPath];
                cell.titleLabel.text = _tempArray[indexPath.row];
                cell.contentLabel.text = _contentArray[_page][indexPath.row];
                cell.backgroundColor = [UIColor clearColor];
                return cell;
            } else {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lifeStyleCell"];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"lifeStyleCell"];
                }
                cell.textLabel.text = [NSString stringWithFormat:@"今天：当前%@。气温%@， 预计最高气温%@。", _headViewArray[j][0], _headViewArray[j][1], _headViewArray[j][4]];
                cell.backgroundColor = [UIColor clearColor];
                return cell;
            }
        }
        
    } else {
        ForecastTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"forecastCell" forIndexPath:indexPath];
        return cell;
    }
}
@end
/*
 "daily_forecast":[
 {
 "cond_code_d":"100",
 "cond_code_n":"100",
 "cond_txt_d":"晴",
 "cond_txt_n":"晴",
 "date":"2019-08-12",
 //相对湿度                "hum":"36",
 "mr":"17:32",
 "ms":"02:50",
 //降水量                 "pcpn":"0.0",
 //降水概率                 "pop":"1",
 //气压                 "pres":"952",
 //日出                 "sr":"06:03",
 //日落                 "ss":"19:33",
 //体感温度                 "tmp_max":"35",
 "tmp_min":"19",
 //紫外线指数             "uv_index":"11",
 //能见度                 "vis":"25",
 "wind_deg":"268",
 "wind_dir":"西风",
 "wind_sc":"1-2",
 "wind_spd":"2"
 },
 {
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


