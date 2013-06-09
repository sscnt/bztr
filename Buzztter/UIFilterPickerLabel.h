//
//  UIFilterPickerLabel.h
//  Buzztter
//
//  Created by SSC on 2013/06/09.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFilterPickerLabel : UIView
{
    UILabel* _label;
}

@property (nonatomic, strong) NSString* text;

@end
