//
//  UICellButton.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/19.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UICellButton.h"

@implementation UICellButton

- (id)initWithFrame:(CGRect)frame byRoundingCouners:(UIRectCorner)corner
{
    self = [super initWithFrame:frame];
    if (self) {
        _corner = corner;
        self.backgroundColor = [UIColor clearColor];
        UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:4.0f];
        self.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
        self.layer.shadowRadius = 1.5f;
        self.layer.shadowPath = path.CGPath;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.2f;
        
        [self.titleLabel setFont:[UIFont fontWithName:@"rounded-mplus-1p-medium" size:15.0f]];
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.titleEdgeInsets = UIEdgeInsetsMake(2.0f, 10.0f, 0.0f, 0.0f);
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:_corner cornerRadii:CGSizeMake(4.0f, 4.0f)];
    if(self.highlighted){
        [[UIColor colorWithWhite:245.0f/255.0f alpha:1.0f] setFill];
    }else{
        [[UIColor whiteColor] setFill];
    }
    [path fill];
    
    if(_corner != (UIRectCornerBottomLeft | UIRectCornerBottomRight)){
        UIBezierPath* bottomStrokePath = [UIBezierPath bezierPath];
        [bottomStrokePath moveToPoint:CGPointMake(0.0f, rect.size.height)];
        [bottomStrokePath addLineToPoint:CGPointMake(rect.size.width, rect.size.height )];
        [bottomStrokePath closePath];
        [[UIColor colorWithWhite:0.0f alpha:0.1f] setStroke];
        [bottomStrokePath stroke];
    }
    
    //// Arrow
    UIColor* arrowColor = [UIColor colorWithWhite:0.8f alpha:1.0f];
    if(self.highlighted){
        arrowColor = [UIColor colorWithWhite:0.7f alpha:1.0f];
    }
    CGFloat marginX = rect.size.width - 20.0f;
    CGFloat marginY = 11.0f;
    path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(marginX,3 + marginY)];
    [path addLineToPoint:CGPointMake(6 + marginX, 9 + marginY)];
    [path addLineToPoint:CGPointMake(0 + marginX, 15 + marginY)];
    [path addLineToPoint:CGPointMake(3 + marginX, 18 + marginY)];
    [path addLineToPoint:CGPointMake(12 + marginX, 9 + marginY)];
    [path addLineToPoint:CGPointMake(3 + marginX, 0 + marginY)];
    [path addLineToPoint:CGPointMake(0 + marginX, 3 + marginY)];
    [path closePath];
    [arrowColor setFill];
    [path fill];
    
}


@end
