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
#import "NSStatus.h"

@protocol TwitterTimelineViewModelDelegate <NSObject>
- (void)didLoadStatuses:(NSArray*)statuses;
@end

@interface TwitterTimelineViewModel : NSObject <NSTrendApiDelegate>
{
    NSMutableArray* _statusesArray;
    NSTrendApi* _api;
}

@property (nonatomic, weak) id<TwitterTimelineViewModelDelegate> delegate;

- (void)callApi:(NSString*)api params:(NSRequestParams*)params;
- (NSMutableArray*)statusesOnPage:(NSInteger)page;

@end
