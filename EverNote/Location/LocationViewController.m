//
//  LocationViewController.m
//  EverNote
//
//  Created by Jaime Yesid Leon Parada on 9/9/14.
//  Copyright (c) 2014 Yesid Leon. All rights reserved.
//

#import "LocationViewController.h"

#import "Location.h"

@interface LocationViewController () <MKMapViewDelegate>

@property (nonatomic, strong) Location *model;

@end

@implementation LocationViewController

#pragma mark - Init

- (id)initWithLocation:(Location*)location
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = location;
    }
    return self;
}

#pragma mark - LifeCicle View
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.mapView addAnnotation:self.model];
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(self.model.coordinate, 2000000, 2000000)];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(self.model.coordinate, 500, 500)];
    });
}

#pragma mark - Actions

- (IBAction)standardMap:(id)sender
{
    self.mapView.mapType = MKMapTypeStandard;
}

- (IBAction)satelliteMap:(id)sender
{
    self.mapView.mapType = MKMapTypeSatellite;
}

- (IBAction)hybridMap:(id)sender
{
    self.mapView.mapType = MKMapTypeHybrid;
}

#pragma mark - MKMapViewDelegate




@end
