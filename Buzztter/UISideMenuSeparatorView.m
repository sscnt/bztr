//
//  UISideMenuSeparatorView.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/06.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UISideMenuSeparatorView.h"

@implementation UISideMenuSeparatorView

- (id)initWithTitle:(NSString *)titie
{
    CGRect frame = CGRectMake(0.0f, 0.0f, [UIScreen screenRect].size.width, 22.0f);
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor colorWithWhite:40.0f/255.0f alpha:1.0f];
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, floorf(frame.size.width * 0.8f), frame.size.height)];
        titleLabel.text = titie;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont fontWithName:@"rounded-mplus-1p-medium" size:12.0f];
        titleLabel.textColor = [UIColor colorWithWhite:240.0f/255.0f alpha:1.0f];
        titleLabel.shadowColor = [UIColor blackColor];
        titleLabel.shadowOffset = CGSizeMake(1.0f, 1.0f);
        [self addSubview:titleLabel];
    }
    return self;
}



- (void)drawRect:(CGRect)rect
{
    UIBezierPath* topStrokePath = [UIBezierPath bezierPath];
    [topStrokePath moveToPoint:CGPointMake(0.0f, 0.0f)];
    [topStrokePath addLineToPoint:CGPointMake(rect.size.width, 0.0f)];
    [topStrokePath closePath];
    [[UIColor colorWithWhite:0.0f alpha:0.6f] setStroke];
    [topStrokePath stroke];
    
    UIBezierPath* bottomStrokePath = [UIBezierPath bezierPath];
    [bottomStrokePath moveToPoint:CGPointMake(0.0f, rect.size.height)];
    [bottomStrokePath addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
    [bottomStrokePath closePath];
    [[UIColor colorWithWhite:0.0f alpha:0.05f] setStroke];
    [bottomStrokePath stroke];
    
}


@end
