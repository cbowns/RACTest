//
//  MPSTicker.h
//  RACTest
//
//  Created by Christopher Bowns on 12/17/13.
//  Copyright (c) 2013 Mechanical Pants. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <ReactiveCocoa/ReactiveCocoa.h>

/// MPSTicker provides one signal:
/// An @c accumulate signal that adds one to its previous value, once a second, if @c accumulateEnabled is @c YES.
/// To control the timer, use the custom @c initWithTickSource: initializer.

@interface MPSTicker : NSObject

/// The designated initializer, to allow providing a tick source other than the convenient,
/// once-per-second timer in @c init.
- (instancetype)initWithTickSource:(RACSignal *)tickSource;

/// Convenience initializer. Calls @c initWithTickSource: with a tick-once-per-second time-based signal.
- (instancetype)init;

/// A signal producing increasing NSNumbers.
- (RACSignal *)accumulateSignal;

/// A @c BOOL to control whether or not accumulation is active.
@property (nonatomic, assign) BOOL accumulateEnabled;

@end
