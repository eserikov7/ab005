//
//  UIBaseVC.m
//  ExpocentrClient
//
//  Created by Evgeny Serikov on 10.08.15.
//  Copyright (c) 2015 Mobis. All rights reserved.
//

#import "UIBaseVC.h"
#import "UIStoryboard+instant.h"
//#import "UIColor+colors.h"
#import <RESideMenu.h>
#import <UIViewController+RESideMenu.h>
#import "Constants.h"

@interface UIBaseVC ()

@property(nonatomic)UIView* waitingView;

@end

@implementation UIBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    if(self.navigationController.viewControllers.count<=1)
    {
        
        UIImage * img = [UIImage imageNamed:@"icon_menu"];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:img forState:UIControlStateNormal];
        btn.frame = CGRectMake(0,0,img.size.width, img.size.height);
        [btn addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
    }
}


- (void) showActivityIndicator
{
    if(self.waitingView == nil)
    {
        self.waitingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        self.waitingView.backgroundColor = [UIColor blackColor];
        self.waitingView.alpha = 0.5;
        UIActivityIndicatorView * activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [activity startAnimating];
        activity.center = self.waitingView.center;
        [self.waitingView addSubview:activity];
        self.waitingView.center = CGPointMake(self.view.center.x, self.view.center.y-self.navigationController.navigationBar.frame.size.height);
        self.waitingView.layer.cornerRadius = kDefaultCornerRadius;
        [self.view addSubview:self.waitingView];
    }
}

- (void) hideActivityIndicator
{
    if(self.waitingView != nil)
    {
        [self.waitingView removeFromSuperview];
        self.waitingView = nil;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
