//
//  YGViewController.m
//  KZPropertyMapperUse
//
//  Created by sunyanguo on 13-11-10.
//  Copyright (c) 2013年 sunyanguo. All rights reserved.
//

#import "YGHotelCityListViewController.h"


@interface YGHotelCityListViewController ()
@property (nonatomic, copy) YGCityList *cityList;
@end

@implementation YGHotelCityListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.requestManager requestHotelCityListWithCompletionBlock:^(YGResponse *responseObject) {
        self.cityList = responseObject.responseObj;
    } failure:^(NSError *error)  {
        
    } checkVersion:NO];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
    
    return cell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
