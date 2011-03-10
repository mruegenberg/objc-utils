//
//  DLFolding.h
//  CheckLists
//
//  Created by Marcel Ruegenberg on 30.11.10.
//  Copyright 2010 Dustlab. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 This protocol implements a fold mechanism, known from functional programming languages;
 You probably want a tail-optimizing compiler when using this.
 */
@protocol DLFolding <NSObject>

- (id)dl_foldWithAction:(id (^)(id acc, id val))action accumulator:(id)acc;

/**
 Fold on all children and accumulate the results, but leave out the root element.
 */
- (id)dl_foldOnChildrenWithAction:(id (^)(id acc, id val))action accumulator:(id)acc;

@end
