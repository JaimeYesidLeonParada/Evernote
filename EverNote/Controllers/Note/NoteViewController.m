//
//  NoteViewController.m
//  EverNote
//
//  Created by Jaime Yesid Leon Parada on 9/3/14.
//  Copyright (c) 2014 Yesid Leon. All rights reserved.
//

#import "NoteViewController.h"
#import "Note.h"
#import "Photo.h"

@interface NoteViewController ()

@property (nonatomic, strong) Note *model;
@end

@implementation NoteViewController


#pragma mark - Init
- (id)initWithModel:(id)model
{
    if (self = [self initWithNibName:nil bundle:nil]) {
        _model = model;
    }
    return self;
}

#pragma mark - View LifeCicle

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateStyle = NSDateFormatterLongStyle;
    
    self.modificationDateView.text = [fmt stringFromDate:self.model.modificationDate];
    self.nameView.text = self.model.name;
    self.textView.text = self.model.text;
    self.photoView.image = (!self.model.photo.image? [UIImage imageNamed:@"noImage.png"]: self.model.photo.image);
    
    [self startObservingKeyboard];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.model.text = self.textView.text;
    self.model.photo.image = self.photoView.image;
    
    [self stopObservingKeyboard];
}

#pragma mark - Keyboard

- (void)startObservingKeyboard
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(notifyThatKeyboardWillAppear:)
               name:UIKeyboardWillShowNotification
             object:nil];
    
    [nc addObserver:self
           selector:@selector(notifyThatKeyboardWillDissappear:)
               name:UIKeyboardWillHideNotification
             object:nil];
    
}

- (void)stopObservingKeyboard
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}


- (void)notifyThatKeyboardWillAppear:(NSNotification*)notification
{
    NSDictionary *dict = notification.userInfo;
    
    double duration = [[dict objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    
    [UIView animateWithDuration:2.0 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:2.5 options:0 animations:^{
        self.textView.frame = CGRectMake(self.textView.frame.origin.x, self.modificationDateView.frame.origin.y, self.textView.frame.size.width, self.textView.frame.size.height);
    } completion:nil];
    
    
    [UIView animateWithDuration:duration animations:^{
        self.textView.alpha = 0.8;
    }];
    
}

- (void)notifyThatKeyboardWillDissappear:(NSNotification*)notification
{
    NSDictionary *dict = notification.userInfo;
    
    double duration = [[dict objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:0
                     animations:^{
                         self.textView.frame = CGRectMake(self.textView.frame.origin.x, 320.0, self.textView.frame.size.width, self.textView.frame.size.height);
                     } completion:nil];
    
    [UIView animateWithDuration:duration animations:^{
        self.textView.alpha = 1;
    }];
    
}




@end
