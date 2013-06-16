//
//  NSAnnouncementItem.h
//  Buzztter
//
//  Created by SSC on 2013/06/16.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAnnouncementItem : NSObject

@property (nonatomic, assign) int created_at;
@property (nonatomic, strong) NSString* text;

- (id)initWithJson:(NSDictionary*)json;

@end
