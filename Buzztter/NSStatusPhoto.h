//
//  NSStatusPhoto.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/03.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSStatusPhoto : NSDictionary

- (id)initWithJsonObject:(NSDictionary*)json;

@property (nonatomic, strong) NSString* media_url;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;

@end
