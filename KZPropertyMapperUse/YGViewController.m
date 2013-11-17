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
    YGVerticalAlignmentLabel *verAlignLabel = [[YGVerticalAlignmentLabel alloc] initWithFrame:CGRectMake(100, 20, 100, 20)];
    verAlignLabel.text = @"YGVerticalAlignmentLabelYGVerticalAlignmentLabelYGVerticalAlignmentLabel";
    verAlignLabel.numberOfLines = 0;
    verAlignLabel.verticalAlignment = YGTextVerticalAlignmentMiddle;
    [self.view addSubview:verAlignLabel];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)requestAction:(id)sender {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"testOrderList" withExtension:@"txt"];
    [YGBaseRequest requestOrderDetailWithUrl:url completionBlock:^(AFHTTPRequestOperation *operation, YGResponse* responseObject) {
        YGOrderList *orderList = responseObject.responseObj;
        NSLog(@"%@",orderList.orderDetailResults);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}
@end
