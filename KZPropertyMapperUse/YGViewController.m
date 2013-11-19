//
//  YGViewController.m
//  KZPropertyMapperUse
//
//  Created by sunyanguo on 13-11-10.
//  Copyright (c) 2013年 sunyanguo. All rights reserved.
//

#import "YGViewController.h"
#import "AFNetWorking.h"
#import "YGBaseRequest.h"
#import "YGVerticalAlignmentLabel.h"


@interface YGViewController ()
- (IBAction)requestAction:(id)sender;
@end

@implementation YGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    YGOrderList *orderList = nil;
    NSString *path = nil;
    path = [NSString stringWithFormat:@"%@/Documents/orderList.plist",NSHomeDirectory()];
    NSLog(@"path:%@",path);
    orderList = [YGOrderList entityFromFile:path];
    NSLog(@"list:%@",orderList.orderDetailResults);

    
    YGVerticalAlignmentLabel *verAlignLabel = [[YGVerticalAlignmentLabel alloc] initWithFrame:CGRectMake(100, 20, 100, 220)];
    verAlignLabel.text = @"YGVerticalAlignmentLabelYGVerticalAlignmentLabelYGVerticalAlignmentLabel";
    verAlignLabel.numberOfLines = 0;
//    verAlignLabel.verticalAlignment = YGTextVerticalAlignmentTop;
    [self.view addSubview:verAlignLabel];
    [self.view showBorder];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)requestAction:(id)sender {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"testOrderList" withExtension:@"txt"];
    [YGBaseRequest requestOrderListWithUrl:url completionBlock:^(AFHTTPRequestOperation *operation, YGResponse* responseObject) {
        YGOrderList *orderList = responseObject.responseObj;
        NSLog(@"%@",orderList.orderDetailResults);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}
@end
