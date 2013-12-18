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
/// A @c enabled signal that controls whether accumulate adds or not.
/// A @c tick signal generated once per second that automatically increments acculumate.

@interface MPSTicker : NSObject

- (RACSignal *)accumulateSignal;

@end
