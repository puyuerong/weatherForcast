//
//  ChoseViewController.m
//  WeatherForecast
//
//  Created by 蒲悦蓉 on 2019/8/13.
//  Copyright © 2019 蒲悦蓉. All rights reserved.
//

#import "ChoseViewController.h"
#import "ChoseTableViewCell.h"
#import "SearchViewController.h"
#import "CityViewController.h"
@interface ChoseViewController ()
@property NSMutableArray *array;            /*存放城市*/
@property NSMutableArray *choseArray;
@property UITableView *tableView;
@property NSInteger mark;
@property UIButton *addButton;
@property NSMutableArray *contentArray;
@property BOOL select;
@end

@implementation ChoseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backImageView.image = [UIImage imageNamed:@"back1.jpeg"];
    [self.view addSubview:backImageView];
    
    _select = YES;
    _array = [NSMutableArray arrayWithObjects:@"西安", nil];
//    [self creatPost:_array[0]];
    _choseArray = [NSMutableArray array];

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 375, 90) style:UITableViewStylePlain];
    [_tableView registerClass:[ChoseTableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _mark = 0;
    _addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_addButton setFrame:CGRectMake(340, 90 + 15, 23, 23)];
    [_addButton setTitle:@"+" forState:UIControlStateNormal];
    _addButton.tintAdjustmentMode = YES;
    [_addButton addTarget:self action:@selector(pressSearch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addButton];
    _contentArray = [NSMutableArray array];
}

- (void)creatPost:(NSString*)str {
    NSString *str0 = [NSString stringWithFormat:@"https://free-api.heweather.net/s6/weather/?location=%@&key=953d7d1aadc549e9be792d07efcd6973", str];
    str0 = [str0 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    NSURL *url = [NSURL URLWithString:str0];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            id objc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
            [mutableArray addObject:objc[@"HeWeather6"][0][@"update"][@"loc"]];
            [mutableArray addObject:objc[@"HeWeather6"][0][@"basic"][@"location"]];
            [mutableArray addObject:objc[@"HeWeather6"][0][@"now"][@"tmp"]];
            [self.choseArray addObject:mutableArray];
            NSMutableArray *tempArrayToday = [NSMutableArray array];
            tempArrayToday = objc[@"HeWeather6"][0][@"daily_forecast"];
            NSMutableArray *tempArrayToday2 = [NSMutableArray array];
            tempArrayToday2 = objc[@"HeWeather6"];
            mutableArray = [NSMutableArray arrayWithObjects: tempArrayToday[0][@"sr"], tempArrayToday[0][@"ss"], tempArrayToday[0][@"pop"] ,tempArrayToday[0][@"hum"], tempArrayToday[0][@"wind_dir"], tempArrayToday[0][@"tmp_max"], tempArrayToday2[0][@"now"][@"pcpn"], tempArrayToday2[0][@"now"][@"pres"], tempArrayToday2[0][@"now"][@"vis"], tempArrayToday[0][@"uv_index"], nil];
            [self.contentArray addObject:mutableArray];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.tableView reloadData];
            }];
        }
    }];
    [dataTask resume];
}

- (void)pressSearch {
    _select = NO;
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    searchVC.array = [NSMutableArray array];
    searchVC.array = _array;
    searchVC.delegate = self;
    [self presentViewController:searchVC animated:YES completion:nil];
}

- (void)pushSelected:(BOOL)selected
{
    _select = selected;
}
    
- (void)viewWillAppear:(BOOL)animated
{
    _tableView.frame = CGRectMake(0, 0, 375, 90 * [_array count]);
    [_addButton setFrame:CGRectMake(340, 90 * [_array count] + 15, 23, 23)];
    if (_select == YES) {
       [self creatPost:_array[[_array count] - 1]];
    }
    _select = NO;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _array.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChoseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if ([_choseArray count] != 0) {
        cell.timeLabel.text = [_choseArray[indexPath.row][0] substringFromIndex:11];
        cell.locationLabel.text = _choseArray[indexPath.row][1];
        cell.temperatureLabel.text = _choseArray[indexPath.row][2];
        cell.backgroundColor = [UIColor clearColor];
  //      [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    } else {
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CityViewController *cityVC = [[CityViewController alloc] init];
    cityVC.array = [NSMutableArray array];
    cityVC.array = _array;
    NSLog(@"%ld", indexPath.row);
    cityVC.page = indexPath.row;
    cityVC.contentArray = _contentArray;
    [self presentViewController:cityVC animated:YES completion:nil];
}
    
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




@end
