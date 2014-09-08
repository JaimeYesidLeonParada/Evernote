//
//  NoteCollectionViewCell.h
//  EverNote
//
//  Created by Yesid Leon on 27/08/14.
//  Copyright (c) 2014 Yesid Leon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Note;

@interface NoteCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *modificationDateView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UIImageView *locationView;

- (void)observeNote:(Note*)note;

@end
