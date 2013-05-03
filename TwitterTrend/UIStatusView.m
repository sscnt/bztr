//
//  StatusView.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/03.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIStatusView.h"

@implementation UIStatusView

- (id)initWithStatus:(NSStatus *)status
{
    //// Calc Height
    return nil;
}

- (CGSize)sizeWithStatus:(NSStatus *)status
{
    //// General Decralations
    CGFloat wrapperPadding = 8.0f;
    CGFloat innerPadding = 12.0f;
    CGFloat headerHeight = 43.0f;
    CGFloat footerHeight = 27.0f;
    CGFloat textHeight = 0.0f;
    CGFloat photoHeight = 0.0f;
    
    //// Calc Text Height
    CGSize constrainedSize = CGSizeMake([UIScreen screenSize].width - 30.0f, 9999);
    CGSize textSize = [status.text sizeWithFont:[UIFont fontWithName:@"Verdana" size:16.0f] constrainedToSize:constrainedSize lineBreakMode:UILineBreakModeWordWrap];
    textHeight = textSize.height;
    
    //// Calc Photo Height
    if([status.type isEqualToString:@"photo"]){
        CGFloat padding = 10.0f;
        CGFloat height = status.photo.height;
        CGFloat areaWidth = [UIScreen screenSize].width - 66.0f;
        if(status.photo.width > areaWidth){
            height = status.photo.height * areaWidth / status.photo.width;
        }
        photoHeight = height + padding;
    }
    return CGSizeMake([UIScreen screenSize].width - 23.0f, ceil(wrapperPadding + innerPadding + headerHeight + footerHeight + textHeight + photoHeight));
    
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
}

@end
