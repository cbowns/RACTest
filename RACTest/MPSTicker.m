//
//  MPSTicker.m
//  RACTest
//
//  Created by Christopher Bowns on 12/17/13.
//  Copyright (c) 2013 Mechanical Pants. All rights reserved.
//

#import "MPSTicker.h"

@interface MPSTicker ()

@property (nonatomic, strong) RACSignal *tickSignal;
@property (nonatomic, strong) RACSignal *enabledSignal;

@end

@implementation MPSTicker

- (id)init
{
    self = [super init];
    if (self) {
		// Create our tick signal.
		_tickSignal = [RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]];
    }
    return self;
}

- (RACSignal *)tickSignal
{
	return _tickSignal;
}

- (RACSignal *)enabledSignal
{
	return _enabledSignal;
}

@end
