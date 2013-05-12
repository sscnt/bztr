//
//  TwitterTimelineViewUserModel.h
//  TwitterTrend
//
//  Created by SSC on 2013/05/11.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSEnduserData.h"
#import "NSTrendApi.h"
#import "NSRequestParams.h"
#import "NSEnduserRegistration.h"

@protocol TwitterTimelineViewEnduserModelDelegate <NSObject>

@optional
- (void)didRegisterUserAndSaved;
- (void)didRegistrationFailedWithError:(NSString*)error;
@end

typedef NS_ENUM(NSInteger, TwitterTimelineViewEnduerModelApiIdentifier)
{
    TwitterTimelineViewEnduerModelApiIdentifierError = 0,
    TwitterTimelineViewEnduserModelApiIdentifierRegistration
};

@interface TwitterTimelineViewEnduserModel : NSObject <NSTrendApiDelegate>
{
    NSTrendApi* _apiForRegistration;
}
@property (nonatomic, weak) id<TwitterTimelineViewEnduserModelDelegate> delegate;

- (void)registerUser;

@end
