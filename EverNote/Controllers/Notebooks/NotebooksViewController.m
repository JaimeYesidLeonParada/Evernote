//
//  NotebooksViewController.m
//  EverNote
//
//  Created by Yesid Leon on 4/08/14.
//  Copyright (c) 2014 Yesid Leon. All rights reserved.
//

#import "NotebooksViewController.h"
#import "NoteBook.h"
#import "Note.h"
#import "NotebookCellView.h"
#import "NotesTableViewController.h"
#import "NotesCollectionViewController.h"

@interface NotebooksViewController ()

@end

@implementation NotebooksViewController

#pragma mark - View Lifecycle
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"Evernote";
    
    //Crear un boton con un target y un action
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(addNotebook:)];
    self.navigationItem.rightBarButtonItem = addButton;

    //Boton de edicion
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    //alta notificaciones sensor de proximidad
    UIDevice *dev = [UIDevice currentDevice];
    
    if ([self hasProximitySensor]) {
        [dev setProximityMonitoringEnabled:YES];
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        
        [center addObserver:self
                   selector:@selector(proximityStateDidChange:)
                       name:UIDeviceProximityStateDidChangeNotification
                     object:nil];
    }
    
    //Registramos el nib
    UINib *cellNib = [UINib nibWithNibName:@"NotebookCellView" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:[NotebookCellView cellId]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}


#pragma mark - Actios
- (void)addNotebook:(id)sender{
    
    [NoteBook notebookWithName:@"New Notebook"
                       context:self.fetchedResultsController.managedObjectContext];
}


#pragma mark - Data Source
- (void)tableView:(UITableView *)tableView
    commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
      forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NoteBook *del = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.fetchedResultsController.managedObjectContext deleteObject:del];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Averiguar el notebook
    NoteBook *nb = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //Crear una celda
    NotebookCellView *cell = [tableView dequeueReusableCellWithIdentifier:[NotebookCellView cellId]];
    
    
    //Sincronizar libreta --> celda
    cell.nameView.text = nb.name;
    cell.numberOfNotesView.text = [NSString stringWithFormat:@"%lu", (unsigned long)nb.notes.count];
    
    return cell;
}

#pragma mark - TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [NotebookCellView cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    NoteBook *nb = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NotesTableViewController *notesVC = [[NotesTableViewController alloc]initWithNotebook:nb];
    [self.navigationController pushViewController:notesVC
                                         animated:YES];
     */
    
    
   
    //Crear  fetch request
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[Note entityName]];
    req.sortDescriptors = @[[NSSortDescriptor
                             sortDescriptorWithKey:NamedEntityAttributes.name
                             ascending:YES],
                            [NSSortDescriptor sortDescriptorWithKey:NamedEntityAttributes.modificationDate
                                                          ascending:NO],
                            [NSSortDescriptor sortDescriptorWithKey:NamedEntityAttributes.creationDate
                                                          ascending:NO]];
    req.fetchBatchSize = 20;
    
    req.predicate = [NSPredicate predicateWithFormat:@"notebook == %@",
                     [self.fetchedResultsController objectAtIndexPath:indexPath]];
    
     // Crear fetch result controller
    NSFetchedResultsController *fC = [[NSFetchedResultsController alloc]initWithFetchRequest:req managedObjectContext:self.fetchedResultsController.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    
    //Layout
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(140, 150);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    // Creamos el control de notas
    NotesCollectionViewController *notesVC = [NotesCollectionViewController coreDataCollectionViewControllerWithFetchedResultsController:fC layout:layout];
    notesVC.notebook = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self.navigationController pushViewController:notesVC animated:YES];
     
}



#pragma mark Sensor Proximity

- (BOOL) hasProximitySensor{
    
    UIDevice *dev = [UIDevice currentDevice];
    BOOL oldValue = [dev isProximityMonitoringEnabled];
    [dev setProximityMonitoringEnabled:!oldValue];
    BOOL newValue = [dev isProximityMonitoringEnabled];
    [dev setProximityMonitoringEnabled:oldValue];
    
    return (oldValue != newValue);
}

 //UIDeviceProximityStateDidChangeNotification
- (void)proximityStateDidChange:(NSNotification *)notification{
   
    [self.fetchedResultsController.managedObjectContext.undoManager undo];
}




@end
