//
//  YGBaseViewController.m
//  KZPropertyMapperUse
//
//  Created by sunyanguo on 13-11-24.
//  Copyright (c) 2013年 sunyanguo. All rights reserved.
//

#import "YGBaseViewController.h"

@interface YGBaseViewController ()

@end

@implementation YGBaseViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.requestManager = [[YGBaseRequest alloc] init];
}

- (void)initUI{
    [self doesNotRecognizeSelector:_cmd];
}

- (void)initParams{
    [self doesNotRecognizeSelector:_cmd];
}

- (void)dealloc{
    [self.requestManager cancelAllRequest];
}


@end
