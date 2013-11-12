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
@interface YGViewController ()
- (IBAction)requestAction:(id)sender;
@property (strong, nonatomic) AFHTTPRequestOperation* request;
@end

@implementation YGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)requestAction:(id)sender {
    [self.request cancel];
    if (self.request) {
        [self.request start];
    }else{
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"testOrderList" withExtension:@"txt"];
        self.request = [YGBaseRequest requestOrderDetailWithUrl:url completionBlock:^(AFHTTPRequestOperation *operation, YGOrderDetailModel* responseObject) {
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }

}
@end
