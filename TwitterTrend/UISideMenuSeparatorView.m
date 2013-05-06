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
    CGRect frame = CGRectMake(0.0f, 0.0f, [UIScreen screenRect].size.width, 20.0f);
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor colorWithWhite:60.0f/255.0f alpha:1.0f];
        UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, floorf(frame.size.width * 0.8f), frame.size.height)];
        titleLabel.text = titie;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont fontWithName:@"rounded-mplus-1p-medium" size:12.0f];
        titleLabel.textColor = [UIColor colorWithWhite:210.0f/255.0f alpha:1.0f];
        titleLabel.shadowColor = [UIColor blackColor];
        titleLabel.shadowOffset = CGSizeMake(1.0f, 1.0f);
        [self addSubview:titleLabel];
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
