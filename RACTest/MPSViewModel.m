//
//  MPSViewModel.m
//  RACTest
//
//  Created by Christopher Bowns on 12/10/13.
//  Copyright (c) 2013 Mechanical Pants. All rights reserved.
//

#import "MPSViewModel.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

#import "MPSTicker.h"

@interface MPSViewModel ()

@property (nonatomic, strong) MPSTicker *ticker;

/// The time string, readwrite.
@property (nonatomic, strong, readwrite) NSString *timeString;

@end

@implementation MPSViewModel

- (instancetype)init
{
	self = [super init];
	if (self) {
		// Set up our MPSTicker.
		_ticker = [[MPSTicker alloc] init];

		// Subscribe to its next value.
		@weakify(self);
		[_ticker.tickSignal subscribeNext:^(id obj) {
			@strongify(self);
			self.timeString = [obj description];
			NSLog(@"%s x: %@", __func__, obj);
		}];
	}
	return self;
}

@end
