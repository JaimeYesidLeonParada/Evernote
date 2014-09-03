//
//  NoteViewController.h
//  EverNote
//
//  Created by Jaime Yesid Leon Parada on 9/3/14.
//  Copyright (c) 2014 Yesid Leon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@class Note;

@interface NoteViewController : UIViewController <DetailViewController>
@property (weak, nonatomic) IBOutlet UILabel *modificationDateView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextView *textView;



@end
