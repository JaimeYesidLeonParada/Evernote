//
//  NotesCollectionViewController.m
//  EverNote
//
//  Created by Yesid Leon on 27/08/14.
//  Copyright (c) 2014 Yesid Leon. All rights reserved.
//

#import "NotesCollectionViewController.h"
#import "NoteCollectionViewCell.h"
#import "Note.h"
#import "Photo.h"

static NSString *cellId = @"NoteCellId";

@interface NotesCollectionViewController ()

@end

@implementation NotesCollectionViewController

#pragma mark - View LifeCicle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self registerNib];
    
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    self.title = @"Notas";
}


#pragma mark - Nib Registration
- (void)registerNib
{
    UINib *nib = [UINib nibWithNibName:@"NoteCollectionViewCell"
                                bundle:nil];
    [self.collectionView registerNib:nib
          forCellWithReuseIdentifier:cellId];
}


#pragma mark - Data Source

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //OBtener el objeto
    Note *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
   
    //Obtener una celda
    NoteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    [cell observeNote:note];
    /*
    //Configurar la celda
    cell.titleView.text = note.name;
    cell.photoView.image = note.photo.image;
    
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateStyle = NSDateFormatterMediumStyle;
    
    cell.modificationDateView.text = [fmt stringFromDate:note.modificationDate];
    */
    //Devolver la celda
    
    return cell;
}

@end
