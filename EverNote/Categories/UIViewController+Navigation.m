//
//  UIViewController+Navigation.m
//  EverNote
//
//  Created by Yesid Leon on 5/08/14.
//  Copyright (c) 2014 Yesid Leon. All rights reserved.
//

#import "UIViewController+Navigation.h"

@implementation UIViewController (Navigation)

- (UINavigationController *)wrappedInNavigation{
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:self];
    return nav;
}

@end
