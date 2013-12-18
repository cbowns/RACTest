//
//  MPSTicker.m
//  RACTest
//
//  Created by Christopher Bowns on 12/17/13.
//  Copyright (c) 2013 Mechanical Pants. All rights reserved.
//

#import "MPSTicker.h"

@interface MPSTicker ()

@property (nonatomic, strong) RACSignal *accumulateSignal;

@end

@implementation MPSTicker

- (id)init
{
    self = [super init];
    if (self) {
		// Create our accumulate signal.
		_accumulateSignal = [RACSignal interval:1 onScheduler:[RACScheduler scheduler]];
    }
    return self;
}

- (RACSignal *)accumulateSignal
{
	return _accumulateSignal;
}

@end
