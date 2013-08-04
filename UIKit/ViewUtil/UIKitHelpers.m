//
//  UIKitHelpers.m
//  Classes
//
//  Created by Marcel Ruegenberg on 13.06.11.
//  Copyright 2011 Dustlab. All rights reserved.
//

#import "UIKitHelpers.h"
#import "UIKit+DrawingHelpers.h"
#import "Util.h"


UIButton *deleteButtonWithTitle(NSString *title) {
	UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
	
	deleteButton.frame = CGRectMake(0, 0, 300, 40);
	[deleteButton setTitle:title forState:UIControlStateNormal];
    
    UIImage *deleteButtonBG = nil;
    if(majorOSVersion() < 7) {
        deleteButtonBG = [[UIImage imageNamed:@"delete_button.png"] stretchableImageWithLeftCapWidth:9 topCapHeight:0];
    }
    else {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(21, 40), NO, deleteButton.contentScaleFactor);
        CGContextRef c = UIGraphicsGetCurrentContext();
        [[UIColor colorWithWhite:1.0 alpha:0.8] setFill];
        CGContextFillRoundedRect(c, CGRectMake(0, 0, 21, 40), 10);
        deleteButtonBG = [UIGraphicsGetImageFromCurrentImageContext() stretchableImageWithLeftCapWidth:10 topCapHeight:0];
        UIGraphicsEndImageContext();
    }
	[deleteButton setBackgroundImage:deleteButtonBG forState:UIControlStateNormal];
    if(majorOSVersion() < 7) {
        deleteButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [deleteButton setTitleShadowColor:[UIColor colorWithRed:0.5 green:0 blue:0 alpha:1.0] forState:UIControlStateNormal];
        deleteButton.titleLabel.shadowOffset = CGSizeMake(0, -1);
    }
    else {
        deleteButton.titleLabel.font = [UIFont systemFontOfSize:18.0];
        deleteButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        deleteButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [deleteButton setTitleColor:[UIColor colorWithRed:0.99 green:0.27 blue:0.15 alpha:1.0] forState:UIControlStateNormal];
    }
	
	return deleteButton;
}

void displayInfoAlert(NSString *message) {
    static UIAlertView *currentAlert = nil;
    currentAlert = [[UIAlertView alloc] initWithTitle:message message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[currentAlert show];
}

CGSize contentSizeForTableViewController(UITableViewController *controller, CGFloat minHeight) {
    CGFloat totalHeight = controller.tableView.sectionHeaderHeight;
    NSUInteger sC = [controller numberOfSectionsInTableView:controller.tableView];
    for(NSUInteger s = 0; s < sC; ++s) {
        totalHeight += [controller respondsToSelector:@selector(tableView:heightForHeaderInSection:)] ? [controller tableView:controller.tableView heightForHeaderInSection:s] : controller.tableView.sectionHeaderHeight;
        NSUInteger rC = [controller tableView:controller.tableView numberOfRowsInSection:s];
        if([controller respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
            for(NSUInteger r = 0; r < rC; ++r)
                totalHeight += [controller tableView:controller.tableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:r inSection:s]];
        }
        else {
            totalHeight += rC * controller.tableView.rowHeight;
        }
        totalHeight += [controller respondsToSelector:@selector(tableView:heightForFooterInSection:)] ? [controller tableView:controller.tableView heightForFooterInSection:s] : controller.tableView.sectionFooterHeight;
    }
    return CGSizeMake(320, MAX(minHeight, totalHeight));
}
