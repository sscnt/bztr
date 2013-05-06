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
    
    //// UIScrollView
    CGFloat maximumZoomScale = _image.size.width / imageViewWidth;
    scrollView.maximumZoomScale = maximumZoomScale;
    scrollView.minimumZoomScale = 1.0f;
    [self.view addSubview:scrollView];
    
    //// Adjust
    [self adjustImageViewOrigin:scrollView];
    
    //// Back Button
    UIButton* backButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 50.0f, 50.0f)];
    backButton.backgroundColor = [UIColor redColor];
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

- (void)back
{
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
