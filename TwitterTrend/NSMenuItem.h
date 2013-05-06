//
//  NSMenuItem.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/06.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, NSMenuItemType){
    NSMenuItemTypeTimeline = 0,
    NSMenuItemTypeSettings,
    NSMenuItemTypeHelp,
    NSMenuItemTypeAsk,
    NSMenuItemTypePremium
};

@interface NSMenuItem : NSObject
@property (nonatomic, strong) NSString* buttonTitle;
@property (nonatomic, strong) NSString* api;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSString* navigationBarTitle;
@property (nonatomic, strong) NSString* headerTitle;
@property (nonatomic, assign) NSMenuItemType type;
@end
