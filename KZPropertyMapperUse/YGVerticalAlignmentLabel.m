//
//  YKCustomLabel.m
//  MoonbasaIpad
//
//  Created by zhi.zhu on 11-9-16.
//  Copyright 2011 Yek. All rights reserved.
//

#import "YGVerticalAlignmentLabel.h"


@implementation YGVerticalAlignmentLabel

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = 
        // Initialization code.
        self.verticalAlignment = YGTextVerticalAlignmentTop;
    }
    return self;
}
- (void)setVerticalAlignment:(YGTextVerticalAlignment)verticalAlignment {
	_verticalAlignment = verticalAlignment;
	[self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
	CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
	switch (self.verticalAlignment) {
		case YGTextVerticalAlignmentTop:
			textRect.origin.y = bounds.origin.y;
			break;
		case YGTextVerticalAlignmentBottom:
			textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
			break;
		case YGTextVerticalAlignmentMiddle:
			// Fall through.
		default:
			textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
	}

	return textRect;
}
-(void)drawTextInRect:(CGRect)requestedRect {
	CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
	[super drawTextInRect:actualRect];
}
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







