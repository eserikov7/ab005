//
//  UIMainMenuVC.m
//  ExpocentrClient
//
//  Created by Evgeny Serikov on 01.08.15.
//  Copyright (c) 2015 Mobis. All rights reserved.
//

#import "UIMainMenuVC.h"
#import "UIStoryboard+instant.h"
#import "UIColor+colors.h"
#import <RESideMenu.h>
#import <UIViewController+RESideMenu.h>
#import "Constants.h"
#import <FXBlurView.h>

static NSString*  kRowTitleKey = @"TitleKey";
static NSString*  kActionKey = @"ActionKey";
static NSString*  kActiveStateKey = @"kActiveStateKey";
static NSString*  kCellIDKey = @"CellIDKey";


static NSString * kMenuItemCellID = @"menuItemCellID";


@interface UIMainMenuVC ()<UITableViewDataSource, UITableViewDelegate,RESideMenuDelegate>

@property(nonatomic,weak) IBOutlet UITableView * table;
@property(nonatomic,weak) IBOutlet UIImageView * blurBg;

@property(nonatomic) NSArray* dataSource;

@property(nonatomic) NSInteger selectedIndex;

@end

@implementation UIMainMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.blurBg.image = [UIImage imageNamed:@"menu_background"];
    [self updateDataSource];
    [self.table reloadData];
    
    self.sideMenuViewController.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)presentWebByUrl:(NSString*)url
{
    UIWebVC* vc = [UIStoryboard instantWebVC];
    vc.url = url;
    [self presentViewController:vc];
}

- (void)presentViewController:(UIViewController*)vc
{
    [self.sideMenuViewController hideMenuViewController];
    
    if(vc)
    {
        ((UINavigationController*)self.sideMenuViewController.contentViewController).viewControllers = @[vc];
    }
}


- (void)updateDataSource
{
    __weak typeof(self) weekSelf = self;
    
    NSMutableArray* ds = [NSMutableArray array];

    [ds addObject:@{kCellIDKey:kMenuItemCellID,
                    kRowTitleKey:NSLocalizedString(@"MenuNew", @""),
                    kActiveStateKey:(self.selectedIndex == ds.count)?@(1):@(0),
                    kActionKey:^{[weekSelf presentWebByUrl:kNewUrl];}}];

    [ds addObject:@{kCellIDKey:kMenuItemCellID,
                    kRowTitleKey:NSLocalizedString(@"MenuPopular", @""),
                    kActiveStateKey:(self.selectedIndex == ds.count)?@(1):@(0),
                    kActionKey:^{[weekSelf presentWebByUrl:kPopularUrl];}}];

    [ds addObject:@{kCellIDKey:kMenuItemCellID,
                    kRowTitleKey:NSLocalizedString(@"MenuМood", @""),
                    kActiveStateKey:(self.selectedIndex == ds.count)?@(1):@(0),
                    kActionKey:^{[weekSelf presentWebByUrl:kMoodUrl];}}];

    [ds addObject:@{kCellIDKey:kMenuItemCellID,
                    kRowTitleKey:NSLocalizedString(@"MenuBeside", @""),
                    kActiveStateKey:(self.selectedIndex == ds.count)?@(1):@(0),
                    kActionKey:^{[weekSelf presentWebByUrl:kBesideUrl];}}];

    [ds addObject:@{kCellIDKey:kMenuItemCellID,
                    kRowTitleKey:NSLocalizedString(@"MenuDialogs", @""),
                    kActiveStateKey:(self.selectedIndex == ds.count)?@(1):@(0),
                    kActionKey:^{[weekSelf presentWebByUrl:kDialogsUrl];}}];

    [ds addObject:@{kCellIDKey:kMenuItemCellID,
                    kRowTitleKey:NSLocalizedString(@"MenuEvents", @""),
                    kActiveStateKey:(self.selectedIndex == ds.count)?@(1):@(0),
                    kActionKey:^{[weekSelf presentWebByUrl:kEventsUrl];}}];

    self.dataSource = ds;
}

- (UIImage*)takeSnapShot
{
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.sideMenuViewController.contentViewController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snapShotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapShotImage;
}


#pragma mark Actions

- (IBAction)showVKAction:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://vk.com/abbigli"]];
}

- (IBAction)showFBAction:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/groups/abbigli/"]];
}

#pragma mark RESideMenuDelegate
- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
  //  self.blurBg.image = [[self takeSnapShot] blurredImageWithRadius:30 iterations:9 tintColor:[UIColor redColor]];
}

#pragma mark UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* dict = [self.dataSource objectAtIndex:indexPath.row];
    
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:dict[kCellIDKey]];
    
    if(cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dict[kCellIDKey]];
    
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    
    
    if([dict[kActiveStateKey] boolValue])
    {
        cell.textLabel.attributedText = nil;
        cell.textLabel.textColor = [UIColor menuAciveColor];
        cell.textLabel.text = [dict[kRowTitleKey] uppercaseString];
    }
    else
    {
        cell.textLabel.textColor = [UIColor menuAciveColor];
        cell.textLabel.text = [dict[kRowTitleKey] uppercaseString];

    }

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.selectedIndex = indexPath.row;
    
    [self updateDataSource];
    
    [tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];

    NSDictionary* dict = [self.dataSource objectAtIndex:indexPath.row];
    
    void(^block)() = dict[kActionKey];
    
    if (block) {
        block();
    }
    
}

@end
