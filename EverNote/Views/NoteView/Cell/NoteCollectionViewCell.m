//
//  NoteCollectionViewCell.m
//  EverNote
//
//  Created by Yesid Leon on 27/08/14.
//  Copyright (c) 2014 Yesid Leon. All rights reserved.
//

#import "NoteCollectionViewCell.h"
#import "Note.h"
#import "Photo.h"

@interface NoteCollectionViewCell ()

@property (nonatomic, strong) Note *note;

@end


@implementation NoteCollectionViewCell

#pragma mark - Class Methods
+(NSArray*)keyToObserver
{
    return @[@"title", @"modificationDate", @"photo.image"];
}


- (void)observeNote:(Note*)note
{
    self.note = note;
    
    for (NSString *keys in [NoteCollectionViewCell keyToObserver])
    {
        [self.note addObserver:self
                    forKeyPath:keys
                       options:NSKeyValueObservingOptionNew
                       context:NULL];
    }
    [self syncWhitNote];
}

- (void)syncWhitNote
{
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateStyle = NSDateFormatterMediumStyle;
    
    self.titleView.text = self.note.name;
    self.modificationDateView.text = [fmt stringFromDate:self.note.modificationDate];
    self.photoView.image = (self.note.photo.image == nil? [UIImage imageNamed:@"noImage.png"] : self.note.photo.image);
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    [self syncWhitNote];
}

- (void)prepareForReuse
{
    self.note = nil;
    [self syncWhitNote];
}



@end
