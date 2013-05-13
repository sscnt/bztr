//
//  StatusView.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/03.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIStatusView.h"

@implementation UIStatusView

- (id)initWithStatus:(NSStatus *)status
{
    //// Calc Height
    CGRect frame = CGRectMake(16.0f, 0.0f, [UIScreen screenSize].width - 32.0f, 0.0f);
    self = [super initWithFrame:frame];
    if(self){
        //// General Declarations
        _bottomY = 0.0f;
        _status = status;
        _profile_image_url = _status.user.profile_image_url;
        _media_url = _status.photo.media_url;
        _radius = 5.0f;
        
        //// Layout
        [self layoutHeader];
        [self layoutContent];
        [self layoutFooter];
        
        //// Drop Shadow
        UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height) cornerRadius:_radius];
        self.backgroundColor = [UIColor clearColor];
        self.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
        self.layer.shadowRadius = 1.0f;
        self.layer.shadowPath = path.CGPath;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.15f;

    }
    return self;
}

- (void)setSize
{
    //// General Decralations
    CGFloat wrapperPadding = 16.0f;
    CGFloat innerPadding = 12.0f;
    CGFloat footerHeight = 31.0f;

    CGRect frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _bottomY + footerHeight + wrapperPadding + innerPadding);
    self.frame = frame;
}

- (void)drawRect:(CGRect)rect
{
    //// General Declarations
    UIColor* borderColor = [UIColor colorWithWhite:200.0f/255.0f alpha:1.0f];
    UIColor* sepColor = [UIColor colorWithWhite:222.0f/255.0f alpha:1.0f];
    
    //// Draw Base
    UIBezierPath* basePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0f, 0.0f, rect.size.width, rect.size.height) cornerRadius:_radius];
    [[UIColor whiteColor] setFill];
    [basePath fill];
    [borderColor setStroke];
    [basePath stroke];
    
    //// Draw Separator
    UIBezierPath* sepPath = [UIBezierPath bezierPath];
    [sepPath moveToPoint:CGPointMake(16.0f, rect.size.height - 32.0f)];
    [sepPath addLineToPoint:CGPointMake(rect.size.width - 16.0f, rect.size.height - 32.0f)];
    [sepPath closePath];
    [sepColor setStroke];
    sepPath.lineWidth = 1;
    [sepPath stroke];    
}

//// Layout
//////// Header

- (void)layoutHeader
{
    [self layoutHeaderProfileImage];
    [self layoutHeaderName];
    _userOpenWithButton = [[UIStatusUserButton alloc] initWithFrame:CGRectMake(10.0f, 10.0f, self.frame.size.width - 20.0f, 43.0f)];
    _userOpenWithButton.backgroundColor = [UIColor clearColor];
    [_userOpenWithButton addTarget:self action:@selector(didClickUserOpenWithButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_userOpenWithButton];
}

- (void)layoutHeaderProfileImage
{
    //// General Decralacions
    UIImage* image = [UIImage imageNamed:@"placeholder"];
    UIView* wrapper = [[UIView alloc] initWithFrame:CGRectMake(16.0f, 16.0f, 30.0f, 30.0f)];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setFrame:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)];
    imageView.layer.cornerRadius = 3.0f;
    imageView.layer.masksToBounds = YES;
    
    //// Drop Shadow
    CALayer* layer = wrapper.layer;
    UIBezierPath* shadowPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f) cornerRadius:4.0f];
    layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    layer.shadowRadius = 0.5f;
    layer.shadowPath = shadowPath.CGPath;
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOpacity = 0.3f;
    
    //// Load Image
    __weak UIImageView* _weak_imageView = imageView;
    [[JMImageCache sharedCache] imageForURL:[NSURL URLWithString:_status.user.profile_image_url] key:_status.user.profile_image_url completionBlock:^(UIImage* image){
        [_weak_imageView setImage:image];
    } failureBlock:nil];
    
    //// AddSubview
    [wrapper addSubview:imageView];
    [self addSubview:wrapper];
}

- (void)layoutHeaderName
{
    //// Name
    UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(57.0f, 18.0f, self.frame.size.width - 80.0f, 15.0f)];
    nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f];
    nameLabel.text = _status.user.name;
    [self addSubview:nameLabel];
    
    //// ScreenName
    UILabel* screenNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(57.0f, 33.0f, self.frame.size.width - 80.0f, 16.0f)];
    screenNameLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0f];
    screenNameLabel.text = [NSString stringWithFormat:@"@%@", _status.user.screen_name];
    screenNameLabel.textColor = [UIColor colorWithWhite:153.0f/255.0f alpha:1.0f];
    [self addSubview:screenNameLabel];
    
}

//////// Content
- (void)layoutContent
{
    //// Text
    UILabel* textLabel = [[UILabel alloc] initWithFrame:CGRectMake(16.0f, 54.0f, self.frame.size.width - 32.0f, 0.0f)];
    textLabel.text = _status.text;
    textLabel.numberOfLines = 0;
    textLabel.lineBreakMode = UILineBreakModeWordWrap;
    [textLabel setTextAlignment:NSTextAlignmentLeft];
    [textLabel sizeToFit];
    [self addSubview:textLabel];
    _bottomY = textLabel.bottom;
    
    //// Photo
    if([_status.type isEqualToString:@"photo"]){
        
        //// General Declarations
        CGFloat height = _status.photo.height;
        CGFloat width = _status.photo.width;
        CGFloat areaWidth = self.frame.size.width - 32.0f;
        if(width > areaWidth){
            height = _status.photo.height * areaWidth / _status.photo.width;
            width = areaWidth;
        }

        //// Image View
        UIImage* photo = [UIImage imageNamed:@"placeholder"];
        _imageView = [[UIImageView alloc] initWithImage:photo];
        [_imageView setFrame:CGRectMake(0.0f, 0.0f, width, height)];
        
        //// UIButton
        UIButton* wrapper = [[UIButton alloc] initWithFrame:CGRectMake(16.0f, _bottomY + 10.0f, width, height)];
        [wrapper addTarget:self action:@selector(didClickImage) forControlEvents:UIControlEventTouchUpInside];
        
        //// Load Image
        __weak UIImageView* _weak_imageView = _imageView;
        [[JMImageCache sharedCache] imageForURL:[NSURL URLWithString:_status.photo.media_url] key:_status.photo.media_url completionBlock:^(UIImage* image){
            [_weak_imageView setImage:image];
        } failureBlock:nil];
        [wrapper addSubview:_imageView];
        [self addSubview:wrapper];
        _bottomY = wrapper.bottom + 4.0f;
    }
    
    //// Time
    UILabel* dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(16.0f, _bottomY + 5.0f, self.frame.size.width - 32.0f, 16.0f)];
    dateLabel.textColor = [UIColor colorWithWhite:153.0f/255.0f alpha:1.0f];
    dateLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12.0f];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:_status.created_at];
    NSDateFormatter* format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy年MM月dd日 HH時mm分";
    dateLabel.text = [format stringFromDate:date];
    [self addSubview:dateLabel];
    [self setSize];
}

//////// Footer
- (void)layoutFooter
{
    //// General Declarations
    CGFloat baseX = 16.0f;
    
    //// Retweet Count
    NSString* numRtText = [NSString stringWithFormat:@"%d", _status.retweet_count];
    UILabel* numRtLabel = [[UILabel alloc] initWithFrame:CGRectMake(baseX, self.bottom - 23.0f, 0.0f, 15.0f)];
    numRtLabel.text = numRtText;
    numRtLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f];
    [numRtLabel sizeToFit];
    [self addSubview:numRtLabel];
    baseX += numRtLabel.frame.size.width + 1.0f;
    
    //// Retweet Desc
    NSString* rtDescText = @"リツイート";
    UILabel* rtDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(baseX, self.bottom - 22.0f, 0.0f, 15.0f)];
    rtDescLabel.text = rtDescText;
    rtDescLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12.0f];
    [rtDescLabel sizeToFit];
    [self addSubview:rtDescLabel];
    baseX += rtDescLabel.frame.size.width + 5.0f;
    
    //// Favorite Count
    NSString* numFavText = [NSString stringWithFormat:@"%d", _status.favorite_count];
    UILabel* numFavLabel = [[UILabel alloc] initWithFrame:CGRectMake(baseX, self.bottom - 23.0f, 0.0f, 15.0f)];
    numFavLabel.text = numFavText;
    numFavLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f];
    [numFavLabel sizeToFit];
    [self addSubview:numFavLabel];
    baseX += numFavLabel.frame.size.width + 1.0f;
    
    //// Favorite Desc
    NSString* favDescText = @"お気に入り";
    UILabel* favDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(baseX, self.bottom - 22.0f, 0.0f, 15.0f)];
    favDescLabel.text = favDescText;
    favDescLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12.0f];
    [favDescLabel sizeToFit];
    [self addSubview:favDescLabel];
    baseX += favDescLabel.frame.size.width + 5.0f;

}

//// Events
- (void)didClickImage
{
    dlog(@"didClickImage");
    [self.delegate didClickImage:_imageView.image status:_status];
}

- (void)didClickUserOpenWithButton
{
    dlog(@"%@", _status);
    [self.delegate didClickUserOpenWithButton:_status];
}

- (void)didClickStatusOpenWithButton
{
    
}

- (void)dealloc
{
    self.delegate = nil;
    [[JMImageCache sharedCache] removeImageFromMemoryForKey:_media_url];
    [[JMImageCache sharedCache] removeImageFromMemoryForKey:_profile_image_url];
}

@end
