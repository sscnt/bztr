//
//  UISideMenuButton.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/06.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScreen+twitter.h"

@interface UISideMenuButton : UIButton
{
    UILabel* _titleLabel;
}

@property (nonatomic, strong) NSString* segueName;

- (id)initWithTitle:(NSString*)titie;

@end
