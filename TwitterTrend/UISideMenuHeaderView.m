//
//  UISideMenuHeaderView.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/06.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UISideMenuHeaderView.h"

@implementation UISideMenuHeaderView

- (id)initWithTitle:(NSString *)titie
{
    CGRect frame = CGRectMake(0.0f, 0.0f, [UIScreen screenRect].size.width, 44.0f);
    self = [super initWithFrame:frame];
    if(self){        
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, floorf(frame.size.width * 0.8f), frame.size.height)];
        titleLabel.textAlignment = UITextAlignmentCenter;
        titleLabel.text = titie;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont fontWithName:@"rounded-mplus-1p-bold" size:18.0f];
        titleLabel.textColor = [UIColor colorWithWhite:210.0f/255.0f alpha:1.0f];
        titleLabel.shadowColor = [UIColor blackColor];
        titleLabel.shadowOffset = CGSizeMake(1.0f, 1.0f);
        [self addSubview:titleLabel];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    UIBezierPath* bgPath = [UIBezierPath bezierPathWithRect:rect];
    [[UIColor colorWithWhite:40.0f/255.0f alpha:1.0f] setFill];
    [bgPath fill];
}

@end
