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
    scrollView.contentSize = scrollView.bounds.size;
    CGFloat imageRatio = _image.size.width / _image.size.height;
    CGFloat viewRatio = scrollView.frame.size.width / scrollView.frame.size.height;
    CGFloat ratio = 1.0f;
    if(imageRatio > viewRatio){
        //// Adjust by width
        dlog(@"Adjust by width");
        ratio = scrollView.frame.size.width / _image.size.width;
    }else{
        ratio = scrollView.frame.size.height / _image.size.height;
    }
    CGFloat imageViewWidth = _image.size.width * ratio;
    CGFloat imageViewHeight = _image.size.height * ratio;
    CGFloat imageViewPositionY = ceil((scrollView.frame.size.height - imageViewHeight) / 2.0f);
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, imageViewPositionY, imageViewWidth, imageViewHeight)];
    imageView.image = _image;
    [scrollView addSubview:imageView];
    
    CGFloat maximumZoomScale = _image.size.width / imageViewWidth;
    scrollView.maximumZoomScale = maximumZoomScale;
    scrollView.minimumZoomScale = 1.0f;
    [self.view addSubview:scrollView];
    
    //// Back Button
    UIButton* backButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 50.0f, 50.0f)];
    backButton.backgroundColor = [UIColor redColor];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];

}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [[scrollView subviews] objectAtIndex:0];
}

- (void)back
{
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
