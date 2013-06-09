//
//  UIFilterPickerLabel.m
//  Buzztter
//
//  Created by SSC on 2013/06/09.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIFilterPickerLabel.h"

@implementation UIFilterPickerLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _label = [[UILabel alloc] initWithFrame:self.bounds];
        _label.font = [UIFont fontWithName:@"HelveticaNeue" size:40.0f];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.backgroundColor = [UIColor clearColor];
        _label.textColor = [UIColor whiteColor];
        _label.shadowColor = [UIColor blackColor];
        _label.shadowOffset = CGSizeMake(1, 1);
        [self addSubview:_label];
    }
    return self;
}

- (void)setText:(NSString *)text
{
    _label.text = text;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGFloat x = 0.0f;
    CGFloat y = rect.size.height / 2.0f - 1.0f;
    UIColor* topStrokeColor = [UIColor colorWithWhite:57.0f/255.0f alpha:1.0f];
    UIColor* bottomStrokeColor = [UIColor colorWithWhite:80.0f/255.0f alpha:1.0f];
    UIBezierPath* path;
    
    //// Draw Top Stroke
    path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(x, y)];
    [path addLineToPoint:CGPointMake(rect.size.width, y)];
    [topStrokeColor setStroke];
    path.lineWidth = 1.0f;
    [path stroke];
    
    //// Draw Top Stroke
    y++;
    path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(x, y)];
    [path addLineToPoint:CGPointMake(rect.size.width, y)];
    [bottomStrokeColor setStroke];
    path.lineWidth = 1.0f;
    [path stroke];
    
}


@end
