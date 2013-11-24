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
#import "RegexKitLite.h"
#import "UIView+category.h"

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
    [self testRegexkit];
}

- (void)testRegexkit{
    
    NSString *postJsion = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://localhost/phpPost/json.php"] encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"postJsion:\n%@",postJsion);
    NSString *phoneRegex = @"\\d{3}-\\d{8}|\\d{4}-\\d{7}";
//    NSString *phoneRegex = @"^(13[0-9]|14[0-9]|15[0-9]|18[0-9])\\d{8}$";

//    - (NSString *)RKL_METHOD_PREPEND(stringByMatching):(NSString *)regex;
    NSString *test = @"0212-22334444,我 0311-99043333，13300002222";
//    NSString *test = @"13300002222";

    test = [test stringByMatching:phoneRegex];
    NSLog(@"test%@",test);
    
    
    NSString *phone = @"0212-22331234*,我 0311-99043333，13300002222";
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789-"];
    int j = [phone length];
    for (int i=0; i<[phone length]; i++) {
        unichar ch = [phone characterAtIndex:i];
        if (![set characterIsMember:ch]) {
            j = i;
            break;
        }
    }
    phone = [phone substringWithRange:NSMakeRange(0, j)];
    NSLog(@"phone:%@",phone);

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
