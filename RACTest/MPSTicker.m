//
//  MPSTicker.m
//  RACTest
//
//  Created by Christopher Bowns on 12/17/13.
//  Copyright (c) 2013 Mechanical Pants. All rights reserved.
//

#import "MPSTicker.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

static NSUInteger const kAccumulationEnabled = 1;
static NSUInteger const kAccumulationDisabled = 0;

@interface MPSTicker ()

/// A private @c tick signal that generates an event once per second.
/// This signal is an input to @c accumulateSignal.
@property (nonatomic, strong) RACSignal *tickSignal;

/// A public read-only signal for the accumulator.
@property (nonatomic, strong) RACSignal *accumulateSignal;

@end

@implementation MPSTicker

- (instancetype)initWithTickSource:(RACSignal *)tickSource
{
    self = [super init];
    if (self) {
		// Save the passed tickSource as our tick signal.
		_tickSignal = tickSource;

		/*
		 The accumulate signal takes the tick signal and conditionally adds one to its previous value.
		 If @c self.isAccumulateEnabled, it will increment by kAccumulationEnabled;
		 If @c !self.isAccumulateEnabled, it will return the same value.
		 */
		@weakify(self);
		_accumulateSignal = [[_tickSignal filter:^BOOL(id value) {
			@strongify(self);
			return self.accumulateEnabled;
		}] scanWithStart:@(0) reduce:^id(NSNumber *previous, id next) {
			NSLog(@"%s accumulating.", __func__);
			// On each tick, we add one to the previous value of the accumulate signal.
			return @(previous.unsignedIntegerValue + kAccumulationEnabled);
		}];

		// Accumulate by default.
		_accumulateEnabled = YES;
	}
    return self;
}

- (instancetype)init
{
	RACSignal *timedTickSource = [RACSignal interval:1 onScheduler:[RACScheduler scheduler]];
	return [self initWithTickSource:timedTickSource];
}

- (RACSignal *)accumulateSignal
{
	return _accumulateSignal;
}

@end
