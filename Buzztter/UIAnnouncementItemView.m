//
//  UIAnnouncementItemView.m
//  Buzztter
//
//  Created by SSC on 2013/06/16.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIAnnouncementItemView.h"

@implementation UIAnnouncementItemView

- (id)initWithItem:(NSAnnouncementItem *)item
{
    self = [super initWithFrame:CGRectZero];
    if(self){        UILabel* label;
        CGFloat viewWidth = [UIScreen screenSize].width - 20.0f;
        CGFloat bottom = 10.0f;
        
        //// Date
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:item.created_at];
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY年MM月dd日"];
        label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, bottom, viewWidth - 20.0f, 0.0f)];
        label.font = [UIFont fontWithName:@"rounded-mplus-1p-light" size:14.0f];
        label.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate:date]];
        [label initOptions];
        label.textColor = [UIColor colorWithWhite:30.0f/255.0f alpha:1.0f];
        [label sizeToFit];
        [self addSubview:label];
        bottom = label.bottom;
        
        //// Text
        label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, bottom, viewWidth - 20.0f, 0.0f)];
        label.font = [UIFont fontWithName:@"rounded-mplus-1p-regular" size:16.0f];
        label.text = item.text;
        [label initOptions];
        label.textColor = [UIColor colorWithWhite:0.0f/255.0f alpha:1.0f];
        [label sizeToFit];
        [self addSubview:label];
        bottom = label.bottom;
        
        self.frame = CGRectMake(10.0f, 0.0f, viewWidth, bottom + 10.0f);
        UIBezierPath* path = [UIBezierPath bezierPathWithRect:self.bounds];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
        self.layer.shadowRadius = 1.5f;
        self.layer.shadowPath = path.CGPath;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.2f;
        

    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}


@end
