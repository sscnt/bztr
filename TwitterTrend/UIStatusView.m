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
    CGRect frame = CGRectMake(6.0f, 0.0f, size.width, size.height);
    self = [super initWithFrame:frame];
    if(self){
        _status = status;
        _radius = 5.0f;
        UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height) cornerRadius:_radius];
        self.backgroundColor = [UIColor clearColor];
        self.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
        self.layer.shadowRadius = 1.0f;
        self.layer.shadowPath = path.CGPath;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.15f;
        
        [self layoutHeader:status];
    }
    return self;
}

- (CGSize)sizeWithStatus:(NSStatus *)status
{
    //// General Decralations
    CGFloat wrapperPadding = 8.0f;
    CGFloat innerPadding = 12.0f;
    CGFloat headerHeight = 43.0f;
    CGFloat footerHeight = 27.0f;
    CGFloat textHeight = 0.0f;
    CGFloat photoHeight = 0.0f;
    
    //// Calc Text Height
    CGSize constrainedSize = CGSizeMake([UIScreen screenSize].width - 30.0f, 9999);
    CGSize textSize = [status.text sizeWithFont:[UIFont fontWithName:@"Verdana" size:16.0f] constrainedToSize:constrainedSize lineBreakMode:UILineBreakModeWordWrap];
    textHeight = textSize.height;
    
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
    return CGSizeMake([UIScreen screenSize].width - 32.0f, ceil(wrapperPadding + innerPadding + headerHeight + footerHeight + textHeight + photoHeight));
    
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

- (void)layoutHeader:(NSStatus *)status
{
    [self layoutHeaderProfileImage:status];
    [self layoutHeaderName:status];
    _userOpenWithButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 8.0f, self.frame.size.width, 43.0f)];
    _userOpenWithButton.backgroundColor = [UIColor clearColor];
    [_userOpenWithButton addTarget:self action:@selector(didClickUserOpenWithButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_userOpenWithButton];
}

- (void)layoutHeaderProfileImage:(NSStatus *)status
{
    //// General Decralacions
    UIImage* image = [UIImage imageNamed:@"profile_image_placeholder"];
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
    [[JMImageCache sharedCache] imageForURL:[NSURL URLWithString:status.user.profile_image_url] completionBlock:^(UIImage* image){
        [_weak_imageView setImage:image];
    } failureBlock:nil];
    
    //// AddSubview
    [wrapper addSubview:imageView];
    [self addSubview:wrapper];
}

- (void)layoutHeaderName:(NSStatus *)status
{
    //// Name
    UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(57.0f, 18.0f, self.frame.size.width - 80.0f, 15.0f)];
    nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f];
    nameLabel.text = status.user.name;
    [self addSubview:nameLabel];
    
    //// ScreenName
    UILabel* screenNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(57.0f, 33.0f, self.frame.size.width - 80.0f, 16.0f)];
    screenNameLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0f];
    screenNameLabel.text = [NSString stringWithFormat:@"@%@", status.user.screen_name];
    screenNameLabel.textColor = [UIColor colorWithWhite:153.0f/255.0f alpha:1.0f];
    [self addSubview:screenNameLabel];
    
}

//////// Content
- (void)layoutContent:(NSStatus *)status
{
    
}

//////// Footer
- (void)layoutFooter:(NSStatus *)status
{
    
}

//// Events
- (void)didClickUserOpenWithButton
{
    dlog(@"Clicked! %@", _status.user.name);
}

@end
