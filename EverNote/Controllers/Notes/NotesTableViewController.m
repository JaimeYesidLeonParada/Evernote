//
//  NotesTableViewController.m
//  EverNote
//
//  Created by Yesid Leon on 15/08/14.
//  Copyright (c) 2014 Yesid Leon. All rights reserved.
//

#import "NotesTableViewController.h"
#import "NoteBook.h"
#include "Note.h"

@interface NotesTableViewController ()
@property (strong, nonatomic) NoteBook *model;
@end

@implementation NotesTableViewController

- (id)initWithNotebook:(NoteBook *)notebook
{
    //Creamos el fetch request
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[Note entityName]];
    req.predicate = [NSPredicate predicateWithFormat:@"notebook == %@", notebook];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:NamedEntityAttributes.name ascending:YES]];
    
    NSFetchedResultsController *fetched = [[NSFetchedResultsController alloc] initWithFetchRequest:req
                                                                              managedObjectContext:notebook.managedObjectContext sectionNameKeyPath:nil
                                                                                         cacheName:nil];
    if (self = [super initWithFetchedResultsController:fetched
                                                 style:UITableViewStylePlain]) {
        self.fetchedResultsController = fetched;
        self.model = notebook;
        self.title = notebook.name;
    }
    
    return self;
}


#pragma mark - DatSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Note *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    static NSString *cellId = @"NoteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellId];
    }
    
    cell.textLabel.text = note.name;
    
    return cell;
}



@end
