//
//  PhotoViewController.m
//  EverNote
//
//  Created by Jaime Yesid Leon Parada on 9/4/14.
//  Copyright (c) 2014 Yesid Leon. All rights reserved.
//

#import "PhotoViewController.h"
#import "Photo.h"
#import "UIImage+Resize.h"

@import CoreImage;

@interface PhotoViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) Photo *model;

@end

@implementation PhotoViewController

#pragma mark - Init
-(id)initWithModel:(id)model
{
    NSAssert(model, @"Model can not be nil");
    
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        _model = model;
    }
    return self;
}

#pragma mark - LifeCicle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.photoView.image = self.model.image;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.model.image = self.photoView.image;
}


#pragma mark - IBAction

- (IBAction)takePhoto:(id)sender
{
    UIImagePickerController *picker = [UIImagePickerController new];

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    picker.delegate = self;
    picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:picker
                       animated:YES
                     completion:^{
                         
                     }];
}

- (IBAction)deletePhoto:(id)sender
{
    CGRect oldBounds = self.photoView.bounds;
    
    [UIView animateWithDuration:0.6
                     animations:^{
                         self.photoView.alpha = 0;
                         self.photoView.bounds = CGRectZero;
                         self.photoView.transform = CGAffineTransformMakeRotation(M_2_PI);
                     }
                     completion:^(BOOL finished) {
                         self.photoView.image = nil;
                         self.photoView.alpha = 1.0;
                         self.photoView.bounds = oldBounds;
                         self.photoView.transform = CGAffineTransformIdentity;
                     }];
    self.model.image = nil;
}

- (IBAction)applyVintageEffect:(id)sender
{
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CIImage *image = [CIImage imageWithCGImage:self.model.image.CGImage];
    
    CIFilter *old = [CIFilter filterWithName:@"CIFalseColor"];
    [old setDefaults];
    [old setValue:image forKey:kCIInputImageKey];
    
    CIFilter *vignette = [CIFilter filterWithName:@"CIVignette"];
    [vignette setDefaults];
    [vignette setValue:@12 forKey:kCIInputIntensityKey];
    [vignette setValue:old.outputImage forKey:kCIInputImageKey];
    
    [self.activityView startAnimating];
    
    CIImage *output = vignette.outputImage;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CGImageRef res = [context createCGImage:output
                                       fromRect:[output extent]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.activityView stopAnimating];
            UIImage *img = [UIImage imageWithCGImage:res];
            self.photoView.image = img;
            CGImageRelease(res);
        });
    });
}

- (IBAction)zoomToFaces:(id)sender
{
    NSArray *features = [self featuresInImage:self.photoView.image];
    
    if (features) {
        CIFeature *face = [features lastObject];
        CGRect faceBounds = face.bounds;
        
        CIImage *image = [CIImage imageWithCGImage:self.photoView.image.CGImage];
        CIImage *crop = [image imageByCroppingToRect:faceBounds];
        
        UIImage *newImage = [UIImage imageWithCIImage:crop];
        self.photoView.image = newImage;
    }
    
}

- (NSArray*)featuresInImage:(UIImage*)image
{
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                              context:context
                                              options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    CIImage *img = [CIImage imageWithCGImage:image.CGImage];
    
    NSArray *features = [detector featuresInImage:img];
    
    return [features count]? features:nil;
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    __block UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CGRect screenBounds = [[UIScreen mainScreen]bounds];
    CGFloat screenScale = [[UIScreen mainScreen]scale];
    CGSize screenSize = CGSizeMake(screenBounds.size.width *screenScale, screenBounds.size.height *screenScale);
    
    
    [self.activityView startAnimating];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        img = [img resizedImage:screenSize interpolationQuality:kCGInterpolationMedium];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.photoView.image = img;
            [self.activityView stopAnimating];
            self.model.image = img;
        });
    });
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}



@end
