//
//  YGBaseViewController.h
//  KZPropertyMapperUse
//
//  Created by sunyanguo on 13-11-24.
//  Copyright (c) 2013年 sunyanguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGBaseRequest.h"

@interface YGBaseViewController : UIViewController
@property (nonatomic, retain) YGBaseRequest* requestManager;
- (void)initUI;
- (void)initParams;
@end
