//
//  AppDelegate.h
//  EverNote
//
//  Created by Yesid Leon on 27/07/14.
//  Copyright (c) 2014 Yesid Leon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AGTSimpleCoreDataStack;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AGTSimpleCoreDataStack *model;

@end
