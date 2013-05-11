//
//  NSFilter.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/04.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSStatus.h"

@interface NSFilter : NSObject
{
    NSMutableArray* _NGWords;
    NSMutableArray* _NGUsers;
    __weak NSStatus* _status;
}

+ (NSFilter*)sharedFilter;
- (BOOL)isDisplayable:(NSStatus*)status;
- (BOOL)ifConatainNGWord;
- (BOOL)ifNGUser;

@end
