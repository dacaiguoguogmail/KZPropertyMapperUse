//
//  UIView+category.m
//  KZPropertyMapperUse
//
//  Created by dacaiguoguo on 13-11-19.
//  Copyright (c) 2013年 sunyanguo. All rights reserved.
//

#import "UIView+category.h"

@implementation UIView (category)

@end

@implementation UIView (showBorder)

- (void)showBorder{
    
    UIView *av = self;
#if TARGET_IPHONE_SIMULATOR
    av.layer.borderWidth = 1.;
    
    [av.subviews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
        obj.layer.borderWidth = 1.;
        obj.layer.borderColor = [[UIColor colorWithRed:.8 green:.3 blue:.6 alpha:1.] CGColor];
    }];
#elif TARGET_OS_IPHONE
    
#endif
}

@end
