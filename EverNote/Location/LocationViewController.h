//
//  LocationViewController.h
//  EverNote
//
//  Created by Jaime Yesid Leon Parada on 9/9/14.
//  Copyright (c) 2014 Yesid Leon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Location;

@interface LocationViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)standardMap:(id)sender;
- (IBAction)satelliteMap:(id)sender;
- (IBAction)hybridMap:(id)sender;

- (id)initWithLocation:(Location*)location;

@end
