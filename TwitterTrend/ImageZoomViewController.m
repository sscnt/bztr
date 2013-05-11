//
//  ImageZoomViewController.m
//  TwitterTrend
//
//  Created by SSC on 2013/05/05.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "ImageZoomViewController.h"

@interface ImageZoomViewController ()

@end

@implementation ImageZoomViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBarHidden = YES;
    _state = ImageZoomViewStateReady;
    
    //// Scroll View
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen screenRect].size.width, [UIScreen screenRect].size.height - 20.0f)];
    scrollView.delegate = self;
    CGFloat imageRatio = _image.size.width / _image.size.height;
    CGFloat viewRatio = scrollView.frame.size.width / scrollView.frame.size.height;
    CGFloat ratio = 1.0f;
    if(imageRatio > viewRatio){
        //// Adjust by width
        ratio = scrollView.frame.size.width / _image.size.width;
    }else{
        //// Adjust by height
        ratio = scrollView.frame.size.height / _image.size.height;
    }
    CGFloat imageViewWidth = _image.size.width * ratio;
    CGFloat imageViewHeight = _image.size.height * ratio;
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, imageViewWidth, imageViewHeight)];
    _imageView.image = _image;
    [scrollView addSubview:_imageView];
    
    //// Gesture
    UILongPressGestureRecognizer* longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didLongTapped:)];
    [scrollView addGestureRecognizer:longPressGesture];
    
    //// UIScrollView
    CGFloat maximumZoomScale = _image.size.width / imageViewWidth;
    scrollView.maximumZoomScale = maximumZoomScale;
    scrollView.minimumZoomScale = 1.0f;
    [self.view addSubview:scrollView];
    
    //// Adjust
    [self adjustImageViewOrigin:scrollView];
    
    //// Back Button
    UIButton* backButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 43.0f, 43.0f)];
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"close"]];
    imageView.frame = CGRectMake(10.0f, 10.0f, 23.0f, 23.0f);
    [backButton addSubview:imageView];
    [backButton setY:5.0f];
    [backButton setX:[UIScreen screenRect].size.width - 48.0f];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];

}

- (void)adjustImageViewOrigin:(UIScrollView *)scrollView
{
    // Get image view frame
    CGRect  rect;
    rect = _imageView.frame;
    
    // Get scroll view bounds
    CGRect  bounds;
    bounds = scrollView.bounds;
    
    // Compare image size and bounds
    rect.origin = CGPointZero;
    if (CGRectGetWidth(rect) < CGRectGetWidth(bounds)) {
        rect.origin.x = floor((CGRectGetWidth(bounds) - CGRectGetWidth(rect)) * 0.5f);
    }
    if (CGRectGetHeight(rect) < CGRectGetHeight(bounds)) {
        rect.origin.y = floor((CGRectGetHeight(bounds) - CGRectGetHeight(rect)) * 0.5f);
    }
    
    // Set image view frame
    _imageView.frame = rect;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [[scrollView subviews] objectAtIndex:0];
}

- (void)scrollViewDidZoom:(UIScrollView*)scrollView
{
    [self adjustImageViewOrigin:scrollView];
}

- (void)didLongTapped:(id)sender
{
    if(_state == ImageZoomViewStateReady){
        _state = ImageZoomViewStateActionSheetShowing;
        if(!_sheet){
            _sheet = [[UIActionSheet alloc] init];
            _sheet.title = self.status.photo.media_url;
            _sheet.delegate = self;
            _actionSheetBackIndex = [_sheet addButtonWithTitle:@"画像を閉じる"];
            _actionSheetUrlCopyIndex = [_sheet addButtonWithTitle:@"URLをコピー"];
            _actionSheetOpenwithTwitterIndex = [_sheet addButtonWithTitle:@"Twitterアプリで開く"];
            _actionSheetOpenWithSafariIndex = [_sheet addButtonWithTitle:@"Safariで開く"];
            _actionSheetOpenwithChromeIndex = [_sheet addButtonWithTitle:@"Chromeで開く"];
            _actionSheetCancelIndex = [_sheet addButtonWithTitle:@"キャンセル"];
            [_sheet setCancelButtonIndex:_actionSheetCancelIndex];
        }
        [_sheet showInView:self.view];
    }
}

#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //// Back
    if(buttonIndex == _actionSheetBackIndex){
        [_sheet dismissWithClickedButtonIndex:buttonIndex animated:NO];        [self back];
        return;
    }
    
    //// Copy URL
    if (buttonIndex == _actionSheetUrlCopyIndex){
        UIPasteboard *board = [UIPasteboard generalPasteboard];
        [board setValue:_status.photo.media_url forPasteboardType:@"public.utf8-plain-text"];
        UIBlackAlertView* alert = [[UIBlackAlertView alloc] init];
        alert.delegate = nil;
        alert.message = @"コピーしました";
        alert.title = @"";
        int okIndex = [alert addButtonWithTitle:@"OK"];
        [alert setCancelButtonIndex:okIndex];
        [alert show];
        return;
    }
    
    //// Open With Twitter App
    if(buttonIndex == _actionSheetOpenwithTwitterIndex){
        NSString* urlString = [NSString stringWithFormat:@"twitter://status?id=%@", _status.id_string];
        dlog(@"%@", urlString);
        NSURL *url = [NSURL URLWithString:urlString];
        
        if ([[UIApplication sharedApplication] canOpenURL:url]) {            
            [[UIApplication sharedApplication] openURL:url];
        } else {
            UIBlackAlertView* alert = [[UIBlackAlertView alloc] init];
            alert.delegate = nil;
            alert.message = @"URLを開けません";
            alert.title = @"エラー";
            int okIndex = [alert addButtonWithTitle:@"OK"];
            [alert setCancelButtonIndex:okIndex];
            [alert show];
            return;

        }
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    _state = ImageZoomViewStateReady;
}

- (void)back
{
    if(_sheet){
        _sheet.delegate = nil;
        _sheet = nil;
    }
    
    self.navigationController.navigationBarHidden = NO;
    //// Animation
    CATransition* transition = [CATransition animation];
    transition.duration = 0.2f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transition.type = kCATransitionFade;
    
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
