//
//  NotebookCellView.m
//  EverNote
//
//  Created by Yesid Leon on 5/08/14.
//  Copyright (c) 2014 Yesid Leon. All rights reserved.
//

#import "NotebookCellView.h"

@implementation NotebookCellView


#pragma mark - Class Methods
+(NSString *)cellId{
    return NSStringFromClass(self);
}

+(CGFloat) cellHeight{
    return 60.0f;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
