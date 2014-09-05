//
//  PhotoViewController.h
//  EverNote
//
//  Created by Jaime Yesid Leon Parada on 9/4/14.
//  Copyright (c) 2014 Yesid Leon. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DetailViewController.h"

@interface PhotoViewController : UIViewController <DetailViewController>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

- (IBAction)takePhoto:(id)sender;
- (IBAction)deletePhoto:(id)sender;
- (IBAction)applyVintageEffect:(id)sender;
- (IBAction)zoomToFaces:(id)sender;


@end
