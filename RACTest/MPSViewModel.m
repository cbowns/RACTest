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

/// The accumulated string, readwrite.
@property (nonatomic, strong, readwrite) NSString *tickString;

@end

@implementation MPSViewModel

- (instancetype)init
{
	self = [super init];
	if (self) {
		// Set up our MPSTicker.
		_ticker = [[MPSTicker alloc] init];

		// Subscribe to its values.
		@weakify(self);
		[[[_ticker accumulateSignal]
		  // Start with 0, since we don't send a zero-th tick.
		  startWith:@(0)]
		 subscribeNext:^(NSNumber *tick) {
			@strongify(self);
			// Unpack the value and format our string for the UI.
			NSUInteger count = 0;
			if (tick) {
				count = tick.unsignedIntegerValue;
			}
			NSString *formattedString = [NSString stringWithFormat:@"%i tick%@ since launch", count, (count != 1 ? @"s" : @"")];
			self.tickString = formattedString;
		}];
	}
	return self;
}

@end
