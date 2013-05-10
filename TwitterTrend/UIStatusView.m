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
    CGSize size = [self sizeWithStatus:status];
    CGRect frame = CGRectMake(16.0f, 0.0f, size.width, size.height);
    self = [super initWithFrame:frame];
    if(self){
        //// General Declarations
        _status = status;
        _profile_image_url = _status.user.profile_image_url;
        _media_url = _status.photo.media_url;
        _radius = 5.0f;
        UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height) cornerRadius:_radius];
        self.backgroundColor = [UIColor clearColor];
        self.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
        self.layer.shadowRadius = 1.0f;
        self.layer.shadowPath = path.CGPath;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.15f;
        
        //// Layout
        [self layoutHeader];
        [self layoutContent];
        [self layoutFooter];
    }
    return self;
}

- (CGSize)sizeWithStatus:(NSStatus *)status
{
    //// General Decralations
    CGFloat viewWidth = [UIScreen screenSize].width - 32.0f;
    CGFloat wrapperPadding = 8.0f;
    CGFloat innerPadding = 12.0f;
    CGFloat headerHeight = 47.0f;
    CGFloat footerHeight = 27.0f;
    CGFloat textHeight = 0.0f;
    CGFloat photoHeight = 0.0f;
    
    //// Calc Text Height
    UILabel* textLabel = [[UILabel alloc] initWithFrame:CGRectMake(16.0f, 54.0f, viewWidth - 32.0f, 0.0f)];
    textLabel.text = status.text;
    textLabel.numberOfLines = 0;
    textLabel.lineBreakMode = UILineBreakModeWordWrap;
    [textLabel setTextAlignment:NSTextAlignmentLeft];
    [textLabel sizeToFit];
    textHeight = textLabel.frame.size.height + 21.0f;
    textLabel = nil;
    
    //// Calc Photo Height
    if([status.type isEqualToString:@"photo"]){
        CGFloat padding = 10.0f;
        CGFloat height = status.photo.height;
        CGFloat areaWidth = [UIScreen screenSize].width - 66.0f;
        if(status.photo.width > areaWidth){
            height = status.photo.height * areaWidth / status.photo.width;
        }
        photoHeight = height + padding;
    }
    return CGSizeMake(viewWidth, ceil(wrapperPadding + innerPadding + headerHeight + footerHeight + textHeight + photoHeight));
    
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
    _userOpenWithButton = [[UIButton alloc] initWithFrame:CGRectMake(10.0f, 10.0f, self.frame.size.width - 20.0f, 43.0f)];
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
    CGFloat bottomY = 0.0f;
    //// Text
    UILabel* textLabel = [[UILabel alloc] initWithFrame:CGRectMake(16.0f, 54.0f, self.frame.size.width - 32.0f, 0.0f)];
    textLabel.text = _status.text;
    textLabel.numberOfLines = 0;
    textLabel.lineBreakMode = UILineBreakModeWordWrap;
    [textLabel setTextAlignment:NSTextAlignmentLeft];
    [textLabel sizeToFit];
    [self addSubview:textLabel];
    bottomY = textLabel.bottom;
    
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
        UIButton* wrapper = [[UIButton alloc] initWithFrame:CGRectMake(16.0f, bottomY + 10.0f, width, height)];
        [wrapper addTarget:self action:@selector(didClickImage) forControlEvents:UIControlEventTouchUpInside];
        
        //// Load Image
        __weak UIImageView* _weak_imageView = _imageView;
        [[JMImageCache sharedCache] imageForURL:[NSURL URLWithString:_status.photo.media_url] key:_status.photo.media_url completionBlock:^(UIImage* image){
            [_weak_imageView setImage:image];
        } failureBlock:nil];
        [wrapper addSubview:_imageView];
        [self addSubview:wrapper];
        bottomY = wrapper.bottom;
    }
    
    //// Time
    UILabel* dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(16.0f, bottomY + 5.0f, self.frame.size.width - 32.0f, 16.0f)];
    dateLabel.textColor = [UIColor colorWithWhite:153.0f/255.0f alpha:1.0f];
    dateLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12.0f];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:_status.created_at];
    NSDateFormatter* format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy年MM月dd日 HH時mm分";
    dateLabel.text = [format stringFromDate:date];
    [self addSubview:dateLabel];
    

    
}

//////// Footer
- (void)layoutFooter
{
    //// General Declarations
    CGFloat baseX = 16.0f;
    CGSize constrainedSize = CGSizeMake([UIScreen screenSize].width - 30.0f, 9999);
    
    //// Retweet Count
    NSString* numRtText = [NSString stringWithFormat:@"%d", _status.retweet_count];
    CGSize textSize = [numRtText sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f] constrainedToSize:constrainedSize lineBreakMode:UILineBreakModeWordWrap];
    UILabel* numRtLabel = [[UILabel alloc] initWithFrame:CGRectMake(baseX, self.bottom - 23.0f, textSize.width, 15.0f)];
    numRtLabel.text = numRtText;
    numRtLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f];
    [self addSubview:numRtLabel];
    baseX += textSize.width + 1.0f;
    
    //// Retweet Desc
    NSString* rtDescText = @"リツイート";
    textSize = [rtDescText sizeWithFont:[UIFont fontWithName:@"HelveticaNeue" size:12.0f] constrainedToSize:constrainedSize lineBreakMode:UILineBreakModeWordWrap];
    UILabel* rtDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(baseX, self.bottom - 22.0f, textSize.width, 15.0f)];
    rtDescLabel.text = rtDescText;
    rtDescLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12.0f];
    [self addSubview:rtDescLabel];
    baseX += textSize.width + 5.0f;
    
    //// Favorite Count
    NSString* numFavText = [NSString stringWithFormat:@"%d", _status.favorite_count];
    textSize = [numFavText sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f] constrainedToSize:constrainedSize lineBreakMode:UILineBreakModeWordWrap];
    UILabel* numFavLabel = [[UILabel alloc] initWithFrame:CGRectMake(baseX, self.bottom - 23.0f, textSize.width, 15.0f)];
    numFavLabel.text = numFavText;
    numFavLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0f];
    [self addSubview:numFavLabel];
    baseX += textSize.width + 1.0f;
    
    //// Favorite Desc
    NSString* favDescText = @"お気に入り";
    textSize = [favDescText sizeWithFont:[UIFont fontWithName:@"HelveticaNeue" size:12.0f] constrainedToSize:constrainedSize lineBreakMode:UILineBreakModeWordWrap];
    UILabel* favDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(baseX, self.bottom - 22.0f, textSize.width, 15.0f)];
    favDescLabel.text = favDescText;
    favDescLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12.0f];
    [self addSubview:favDescLabel];
    baseX += textSize.width + 5.0f;

}

//// Events
- (void)didClickImage
{
    dlog(@"didClickImage");
    [self.delegate didClickImage:_imageView.image];
}

- (void)didClickUserOpenWithButton
{
    dlog(@"Clicked! %@", _status.user.name);
}

- (void)didClickStatusOpenWithButton
{
    
}

- (void)dealloc
{
    [[JMImageCache sharedCache] removeImageFromMemoryForKey:_media_url];
    [[JMImageCache sharedCache] removeImageFromMemoryForKey:_profile_image_url];
}

@end
