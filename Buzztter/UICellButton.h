//
//  UICellButton.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/19.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CALayer.h>

@interface UICellButton : UIButton
{
    UIRectCorner _corner;
}

- (id)initWithFrame:(CGRect)frame byRoundingCouners:(UIRectCorner)corner;

@end
