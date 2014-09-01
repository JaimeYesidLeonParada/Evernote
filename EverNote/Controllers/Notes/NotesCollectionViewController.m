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

#pragma mark - Data Source

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //OBtener el objeto
    Note *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //Obtener una celda
    NoteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    //Configurar la celda
    cell.titleView.text = note.name;
    cell.photoView.image = note.photo.p
    
    
    //Devolver la celda
}

@end
