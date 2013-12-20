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

- (id)init
{
    self = [super init];
    if (self) {
		// Create our tick signal.
		_tickSignal = [RACSignal interval:1 onScheduler:[RACScheduler scheduler]];

		/*
		 The accumulate signal takes the tick signal and conditionally adds one to its previous value.
		 If @c self.isAccumulateEnabled, it will increment by kAccumulationEnabled;
		 If @c !self.isAccumulateEnabled, it will return the same value.
		 */
		@weakify(self);
		_accumulateSignal = [_tickSignal scanWithStart:@(0) reduce:^id(NSNumber *previous, id next) {
			@strongify(self);
			NSUInteger accumulation = (self.isAccumulateEnabled ? kAccumulationEnabled : kAccumulationDisabled);
			// On each tick, we add one to the previous value of the accumulate signal.
			return @(previous.unsignedIntegerValue + accumulation);
		}];

		// Accumulate by default.
		_accumulateEnabled = YES;

		// For testing…
		double delayInSeconds = 2.0;
		dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
		dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
			self.accumulateEnabled = NO;
		});
	}
    return self;
}

- (RACSignal *)accumulateSignal
{
	return _accumulateSignal;
}

@end