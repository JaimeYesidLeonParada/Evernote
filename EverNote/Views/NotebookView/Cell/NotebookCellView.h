//
//  NotebookCellView.h
//  EverNote
//
//  Created by Yesid Leon on 5/08/14.
//  Copyright (c) 2014 Yesid Leon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotebookCellView : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *nameView;
@property (nonatomic, strong) IBOutlet UILabel *numberOfNotesView;

+(NSString *)cellId;
+(CGFloat) cellHeight;

@end
