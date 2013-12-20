//
//  MPSTicker.h
//  RACTest
//
//  Created by Christopher Bowns on 12/17/13.
//  Copyright (c) 2013 Mechanical Pants. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <ReactiveCocoa/ReactiveCocoa.h>

/// MPSTicker provides several signals:
/// A @c accumulate signal that adds one to its previous value.

@interface MPSTicker : NSObject

/// A signal producing increasing NSNumbers.
- (RACSignal *)accumulateSignal;

/// A @c BOOL to control whether or not accumulation is active.
@property (nonatomic, assign) BOOL accumulateEnabled;

@end
