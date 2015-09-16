//
//  UIStoryboard+instant.h
//  ExpocentrClient
//
//  Created by Evgeny Serikov on 01.08.15.
//  Copyright (c) 2015 Mobis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIMainMenuVC.h"
#import "UIWebVC.h"


@interface UIStoryboard(instant)

+ (UINavigationController*)instantRootNC;
+ (UIWebVC*)instantWebVC;

@end
