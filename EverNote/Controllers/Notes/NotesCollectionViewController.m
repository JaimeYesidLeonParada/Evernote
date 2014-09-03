//
//  NotesCollectionViewController.m
//  EverNote
//
//  Created by Yesid Leon on 27/08/14.
//  Copyright (c) 2014 Yesid Leon. All rights reserved.
//

#import "NotesCollectionViewController.h"
#import "NoteCollectionViewCell.h"
#import "NoteViewController.h"
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
    
    self.detailViewControllerClassName = NSStringFromClass([NoteViewController class]);
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
    Note *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
   
    NoteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    [cell observeNote:note];
        
    return cell;
}

/*
#pragma mark - Delegates
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Note *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    NoteViewController *nVC = [[NoteViewController alloc]initWithModel:note];
    
    [self.navigationController pushViewController:nVC
                                         animated:YES];
}
*/

@end
