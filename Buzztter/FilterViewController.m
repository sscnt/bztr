//
//  FilterViewController.m
//  Buzztter
//
//  Created by SSC on 2013/06/08.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "FilterViewController.h"

@interface FilterViewController ()

@end

@implementation FilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"ページ設定";
    self.view.backgroundColor = [UIColor colorWithWhite:46.0f/255.0f alpha:1.0f];
    [self showBackButton];

    
    _scrollView = [[UITwitterScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen screenSize].width, [UIScreen screenSize].height - 64.0f)];

    [self.view addSubview:_scrollView];
    _filterView = [[UIFilterView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen screenSize].width, 530.0f)];
    [_scrollView appendView:_filterView margin:0];
    

}



#pragma mark UIFilterView

- (void) filterDidChangeNumRetweetMax:(NSInteger)max_rt Min:(NSInteger)min_rt
{
    
}
- (void) filterDidChangeNumFavoriteMax:(NSInteger)max_fav Min:(NSInteger)min_fav
{
    
}
- (void) filterDidApply
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
