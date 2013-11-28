//
//  UIKitHelpers.h
//  Classes
//
//  Created by Marcel Ruegenberg on 13.06.11.
//  Copyright 2011 Dustlab. All rights reserved.
//

#include <UIKit/UIKit.h>

UIButton *deleteButtonWithTitle(NSString *title);

void displayInfoAlert(NSString *message);

CGSize contentSizeForTableViewController(UITableViewController *controller, CGFloat minHeight);
