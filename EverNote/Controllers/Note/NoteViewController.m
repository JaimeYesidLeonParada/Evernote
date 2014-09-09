//
//  NoteViewController.m
//  EverNote
//
//  Created by Jaime Yesid Leon Parada on 9/3/14.
//  Copyright (c) 2014 Yesid Leon. All rights reserved.
//

#import "NoteViewController.h"
#import "Note.h"
#import "Notebook.h"
#import "Photo.h"
#import "Location.h"
#import "MapSnapshot.h"
#import "PhotoViewController.h"
#import "LocationViewController.h"

@interface NoteViewController () <UITextFieldDelegate>

@property (nonatomic, strong) Note *model;
@property (nonatomic) BOOL newNote;
@property (nonatomic) BOOL deleteCurrentNote;
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

-(id)initForNewNoteInNotebook:(NoteBook*)notebook
{
    Note *newNote = [Note noteWithName:@""
                              notebook:notebook
                               context:notebook.managedObjectContext];
    _newNote = YES;
    return [self initWithModel:newNote];
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
    
    
    self.mapSnapshotView.image = (!self.model.location.mapSnapshot.image? [UIImage imageNamed:@"noSnapshot.png"]:self.model.location.mapSnapshot.image);
    self.mapSnapshotView.userInteractionEnabled = (self.model.location.mapSnapshot.image? YES:NO);
    
    
    [self startObservingSnapshot];
    [self startObservingKeyboard];
    [self setupInputAccessoryView];
    
    if (_newNote) {
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                               target:self
                                                                               action:@selector(cancel:)];
        self.navigationItem.rightBarButtonItem = cancel;
    }
    self.nameView.delegate = self;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                         action:@selector(displayDetailPhoto:)];
    [self.photoView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *snapTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                             action:@selector(displayDetailLocation:)];
    [self.mapSnapshotView addGestureRecognizer:snapTap];
    
    
    UIBarButtonItem *share = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                          target:self
                                                                          action:@selector(displayShareController:)];
    self.navigationItem.rightBarButtonItem = share;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (_deleteCurrentNote) {
        [self.model.managedObjectContext deleteObject:self.model];
    }else{
        self.model.text = self.textView.text;
        self.model.photo.image = self.photoView.image;
        self.model.name = self.nameView.text;
    }
       
    
    [self stopObservingKeyboard];
    [self stopObservingSnapshot];
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
    if ([self.textView isFirstResponder]) {
        [UIView animateWithDuration:2.0 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:2.5 options:0 animations:^{
            self.textView.frame = CGRectMake(self.textView.frame.origin.x, self.modificationDateView.frame.origin.y, self.textView.frame.size.width, self.textView.frame.size.height);
            self.textView.alpha = 0.8;
        } completion:nil];
    }
}

- (void)notifyThatKeyboardWillDissappear:(NSNotification*)notification
{
    if ([self.textView isFirstResponder]) {
        NSDictionary *dict = notification.userInfo;
        
        double duration = [[dict objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        [UIView animateWithDuration:duration
                              delay:0
                            options:0
                         animations:^{
                             self.textView.frame = CGRectMake(self.textView.frame.origin.x, 320.0, self.textView.frame.size.width, self.textView.frame.size.height);
                             self.textView.alpha = 1;
                         } completion:nil];
    }
}

- (void)setupInputAccessoryView
{
    UIToolbar *textBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0)];
    UIToolbar *nameBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0)];
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                         target:self
                                                                         action:@selector(dismissKeyboard:)];
    
    UIBarButtonItem *doneName = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                         target:self
                                                                         action:@selector(dismissKeyboard:)];
    
    
    UIBarButtonItem *sep = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                        target:nil
                                                                        action:nil];
    UIBarButtonItem *smile = [[UIBarButtonItem alloc]initWithTitle:@":-)"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(insertTitle:)];
    
    [textBar setItems:@[smile, sep, done]];
    [nameBar setItems:@[sep, doneName]];
    
    self.textView.inputAccessoryView = textBar;
    self.nameView.inputAccessoryView = nameBar;
}

- (void)insertTitle:(UIBarButtonItem*)sender
{
    [self.textView insertText:sender.title];
}

- (void)dismissKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

#pragma mark - Actions
-(void)cancel:(id)sender
{
    _deleteCurrentNote = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)displayDetailPhoto:(UIGestureRecognizer*)sender
{
    if (self.model.photo == nil) {
        self.model.photo = [Photo photoWithImage:nil
                                         context:self.model.managedObjectContext];
    }
    
    PhotoViewController *pVC = [[PhotoViewController alloc]initWithModel:self.model.photo];
    [self.navigationController pushViewController:pVC
                                         animated:YES];
}

- (void)displayDetailLocation:(UIGestureRecognizer*)sender
{
    LocationViewController *locVC = [[LocationViewController alloc]initWithLocation:self.model.location];
    [self.navigationController pushViewController:locVC
                                         animated:YES];
}

- (void)displayShareController:(id)sender
{
    UIActivityViewController *aVC = [[UIActivityViewController alloc]initWithActivityItems:[self arrayOfItems] applicationActivities:nil];
    [self presentViewController:aVC
                       animated:YES
                     completion:nil];
}

#pragma mark - Utils
-(NSArray*)arrayOfItems
{
    NSMutableArray *items = [NSMutableArray array];
    
    if (self.model.name) {
        [items addObject:self.model.name];
    }
    
    if (self.model.text) {
        [items addObject:self.model.text];
    }
    
    if (self.model.photo.image) {
        [items addObject:self.model.photo.image];
    }
    
    return items;
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - KVO
- (void)startObservingSnapshot
{
    [self.model addObserver:self
           forKeyPath:@"location.mapSnapshot.snapshotData"
              options:NSKeyValueObservingOptionNew
              context:NULL];
    
}

- (void)stopObservingSnapshot
{
    [self.model removeObserver:self
              forKeyPath:@"location.mapSnapshot.snapshotData"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    self.mapSnapshotView.image = (!self.model.location.mapSnapshot.image? [UIImage imageNamed:@"noSnapshot.png"]:self.model.location.mapSnapshot.image);
    self.mapSnapshotView.userInteractionEnabled = (self.model.location.mapSnapshot.image? YES:NO);
}

@end
