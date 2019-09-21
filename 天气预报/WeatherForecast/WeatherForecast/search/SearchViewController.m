//
//  SearchViewController.m
//  WeatherForecast
//
//  Created by 蒲悦蓉 on 2019/8/12.
//  Copyright © 2019 蒲悦蓉. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()
@property UITextField *searchTextFiled;
@property NSMutableArray *searchArray;
@property UITableView *tableView;
@end

@implementation SearchViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backImageView.image = [UIImage imageNamed:@"back2.jpg"];
    [self.view addSubview:backImageView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 110)];
    view.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 375, 20)];
    label.font = [UIFont systemFontOfSize:12];
    label.text = @"输入城市、邮政编码或机场位置";
    label.textAlignment = NSTextAlignmentCenter;
    _searchTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, 300, 40)];
    _searchTextFiled.backgroundColor = [UIColor whiteColor];
    [_searchTextFiled addTarget:self action:@selector(textFiledChange) forControlEvents:UIControlEventEditingChanged];
    _searchTextFiled.delegate = self;
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(325, 60, 50, 40)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(pressCancel) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [view addSubview:_searchTextFiled];
    [view addSubview:cancelButton];
    [view addSubview:label];
    
    [self.view addSubview:view];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 110, 375, 557) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _searchArray = [NSMutableArray array];
    
}

- (void)pressCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)textFiledChange {
    if (_searchTextFiled.text != nil) {
//        NSLog(@"%@", _searchTextFiled.text);
        [_searchArray removeAllObjects];
        [self creatPost];
    }
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_searchArray count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if ([_searchArray count] != 0) {
        cell.textLabel.text = _searchArray[indexPath.row];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    return cell;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_searchTextFiled resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_searchTextFiled resignFirstResponder];
    return YES;
}

- (void)creatPost {

    NSString *str = [NSString stringWithFormat:@"https://search.heweather.net/find?location=%@&key=953d7d1aadc549e9be792d07efcd6973", _searchTextFiled.text];
//    NSLog(@"%@", _searchTextFiled.text);
//    NSLog(@"%@", str);
    str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            id objc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            NSMutableArray *tempArray = [NSMutableArray array];
//            tempArray = objc[@"HeWeather6"][0][@"basic"];
//            NSLog(@"%ld", [tempArray count]);
            
            NSArray *basic = objc[@"HeWeather6"][0][@"basic"];
            
            for(int i = 0; i < basic.count; i++) {
                [self.searchArray addObject:basic[i][@"location"]];
                
            }
//            NSLog(@"%ld", [self.searchArray count]);
            //self.searchArray = objc[@"HeWeather6"][0][@"basic"];
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.tableView reloadData];
            }];
        }
    }];
    [dataTask resume];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (int i = 0; i < [_array count]; i++) {
        if ([_searchArray[indexPath.row] isEqualToString:_array[i]]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"所选地区已存在" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:sureAction];
            [self presentViewController:alertController animated:YES completion:nil];
            return;
        }
    }
    [_array addObject:_searchArray[indexPath.row]];
    [self.delegate pushSelected:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
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
