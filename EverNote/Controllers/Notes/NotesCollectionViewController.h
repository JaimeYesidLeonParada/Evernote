//
//  NotesCollectionViewController.h
//  EverNote
//
//  Created by Yesid Leon on 27/08/14.
//  Copyright (c) 2014 Yesid Leon. All rights reserved.
//

#import "AGTCoreDataCollectionViewController.h"

@class NoteBook;

@interface NotesCollectionViewController : AGTCoreDataCollectionViewController

@property (nonatomic, strong) NoteBook *notebook;

@end
