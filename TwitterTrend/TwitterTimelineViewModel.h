//
//  UIViewModel.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/04.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSRequestParams.h"
#import "NSTrendApi.h"

@interface TwitterTimelineViewModel : NSObject
{
    NSMutableArray* _statusesArray;
}

- (void)callApi:(NSString*)api params:(NSRequestParams*)params addTarget:(id)target selector:(SEL)selector;
- (NSMutableArray*)statusesOnPage:(NSInteger)page;

@end
