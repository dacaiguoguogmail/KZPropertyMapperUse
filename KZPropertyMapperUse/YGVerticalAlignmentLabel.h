//
//  YKCustomLabel.h
//  MoonbasaIpad
//
//  Created by zhi.zhu on 11-9-16.
//  Copyright 2011 Yek. All rights reserved.
//
//  扩展UILabel使UILabel能够设置垂直方向的排布方式

#import <UIKit/UIKit.h>
/*!
 @abstract 定义了Label文字在垂直方向上的对齐方式
 @discussion 分别为居上、居中、居下
 */
typedef NS_ENUM(NSInteger, YGTextVerticalAlignment) {
    YGTextVerticalAlignmentTop,
    YGTextVerticalAlignmentMiddle,
    YGTextVerticalAlignmentBottom,
};

/*!
 @abstract 自定义的一个可以设置文字垂直方向对齐方式的UILabel
 */
@interface YGVerticalAlignmentLabel : UILabel
@property (nonatomic, assign) YGTextVerticalAlignment verticalAlignment;

/*!
 @abstract 设置YKCustomLabel文字的垂直排布方式
 @discussion 设置后会刷新文字显示方式
 @param verticalAlignment VerticalAlignment枚举类型中的某种对齐方式
 */
- (void)setVerticalAlignment:(YGTextVerticalAlignment)verticalAlignment;

@end


