//
//  NotesTableViewController.h
//  EverNote
//
//  Created by Yesid Leon on 15/08/14.
//  Copyright (c) 2014 Yesid Leon. All rights reserved.
//

#import "AGTCoreDataTableViewController.h"
@class NoteBook;

@interface NotesTableViewController : AGTCoreDataTableViewController

-(id)initWithNotebook:(NoteBook *)notebook;

@end
