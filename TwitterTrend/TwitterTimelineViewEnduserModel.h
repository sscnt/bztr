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
#import "NSEnduserFetched.h"

@protocol TwitterTimelineViewEnduserModelDelegate <NSObject>

@optional
- (void)didRegisterUserAndSaved;
- (void)didFailToRegisterWithError:(NSString*)error;
- (void)didFetchUserData;
- (void)didFetchUserDataWithAnnouncement:(NSString*)announcement;
- (void)didFailToFetchUserDataWithError:(NSString*)error;
@end

typedef NS_ENUM(NSInteger, TwitterTimelineViewEnduerModelApiIdentifier)
{
    TwitterTimelineViewEnduerModelApiIdentifierError = 0,
    TwitterTimelineViewEnduserModelApiIdentifierRegistration,
    TwitterTimelineViewEnduerModelApiIdentifierFetchingUserData
};

@interface TwitterTimelineViewEnduserModel : NSObject <NSTrendApiDelegate>
{
    NSTrendApi* _apiForRegistration;
    NSTrendApi* _apiForFetchingUserData;
}
@property (nonatomic, weak) id<TwitterTimelineViewEnduserModelDelegate> delegate;

- (void)registerUser;

- (void)fetchUser;

@end
