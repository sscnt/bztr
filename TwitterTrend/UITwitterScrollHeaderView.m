//
//  UITwitterScrollHeaderView.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/05.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UITwitterScrollHeaderView.h"

@implementation UITwitterScrollHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setTitle:(NSString *)title page:(NSInteger)page
{
    //// General Declarations
    CGSize constrainedSize = CGSizeMake([UIScreen screenSize].width - 30.0f, 9999);
    
    //// Title
    CGSize textSize = [title sizeWithFont:[UIFont fontWithName:@"rounded-mplus-1p-bold" size:16.0f] constrainedToSize:constrainedSize lineBreakMode:UILineBreakModeWordWrap];
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 4.0f, textSize.width, textSize.height)];
    titleLabel.text = title;
    titleLabel.font = [UIFont fontWithName:@"rounded-mplus-1p-bold" size:16.0f];
    titleLabel.textColor = [UIColor colorWithWhite:44.0f/255.0f alpha:1.0f];
    [self addSubview:titleLabel];
    
    //// Page
    UILabel* pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 24.0f, 200.0f, 17.0f)];
    pageLabel.text = [NSString stringWithFormat:@"ページ%d", page];
    pageLabel.font = [UIFont fontWithName:@"rounded-mplus-1p-medium" size:12.0f];
    pageLabel.textColor = [UIColor colorWithWhite:133.0f/255.0f alpha:1.0f];
    [self addSubview:pageLabel];
}

- (void)drawRect:(CGRect)rect
{
    //// Stroke
    UIBezierPath* strokePath = [UIBezierPath bezierPath];
    [strokePath moveToPoint:CGPointMake(0.0f, self.frame.size.height - 1)];
    [strokePath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height - 1)];
    [strokePath closePath];
    strokePath.lineWidth = 1;
    [[UIColor timelineBackgroundColorStrokeColor] setStroke];
    [strokePath stroke];    
}


@end
