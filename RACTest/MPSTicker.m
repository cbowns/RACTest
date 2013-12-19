//
//  MPSTicker.m
//  RACTest
//
//  Created by Christopher Bowns on 12/17/13.
//  Copyright (c) 2013 Mechanical Pants. All rights reserved.
//

#import "MPSTicker.h"

@interface MPSTicker ()

/// A private @c tick signal that generates an event once per second.
/// This signal is an input to @c accumulateSignal.
@property (nonatomic, strong) RACSignal *tickSignal;

@property (nonatomic, strong) RACSignal *accumulateSignal;

@end

@implementation MPSTicker

- (id)init
{
    self = [super init];
    if (self) {
		// Create our tick signal.
		_tickSignal = [RACSignal interval:1 onScheduler:[RACScheduler scheduler]];

		// Create our accumulate signal.
		_accumulateSignal = [_tickSignal scanWithStart:@(0) reduce:^id(NSNumber *previous, id next) {
			// On each tick, we add one to the previous value of the accumulate signal.
			return @(previous.unsignedIntegerValue + 1);
		}];
    }
    return self;
}

- (RACSignal *)accumulateSignal
{
	return _accumulateSignal;
}

@end
