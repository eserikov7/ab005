//
//  UIStoryboard+instant.m
//  ExpocentrClient
//
//  Created by Evgeny Serikov on 01.08.15.
//  Copyright (c) 2015 Mobis. All rights reserved.
//

#import "UIStoryboard+instant.h"

static UIStoryboard* mainStoryboard;
static UIStoryboard* commonStoryboard;

@implementation UIStoryboard(instant)

+ (UIStoryboard*) mainStoryboardIstance
{
    if(mainStoryboard == nil)
    {
            mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
    return mainStoryboard;
}

+(UINavigationController*)instantRootNC
{
    return [[self mainStoryboardIstance] instantiateViewControllerWithIdentifier:@"appNC"];
}

+ (UIWebVC*)instantWebVC
{
    return [[self mainStoryboardIstance] instantiateViewControllerWithIdentifier:@"UIWebVC"];
}


@end
