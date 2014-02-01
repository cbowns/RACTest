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

static NSString * const kStopTickString = @"Stop Tick";
static NSString * const kStartTickString = @"Start Tick";

@interface MPSViewModel ()

@property (nonatomic, strong) MPSTicker *ticker;

// Redeclared as readwrite:
@property (nonatomic, strong, readwrite) NSString *tickString;
@property (nonatomic, strong, readwrite) NSString *tickStateString;

@end

@implementation MPSViewModel

- (instancetype)init
{
	self = [super init];
	if (self) {
		// Set up our MPSTicker.
		_ticker = [[MPSTicker alloc] init];

		// Weakify the self for the below subscribe: blocks.
		@weakify(self);

		// Map the ticker's accumulate signal to our tickString.
		// Deliver this signal on the main thread since we're a view model.
		[[[[_ticker accumulateSignal] deliverOn:[RACScheduler mainThreadScheduler]]
		  // Start with 0.
		  startWith:@(0)]
		 subscribeNext:^(NSNumber *tick) {
			@strongify(self);
			 // Unpack the value and format our string for the UI.
			 NSUInteger count = tick.unsignedIntegerValue;
			 NSString *formattedString = [NSString stringWithFormat:@"%lu tick%@ since launch", (unsigned long)count, (count != 1 ? @"s" : @"")];
			 self.tickString = formattedString;
		}];


		// Map the ticker's isAccumulationEnabled property to self.isPaused.
		RACChannelTo(self, paused) = RACChannelTo(_ticker, accumulateEnabled);
		// To deliver this on a specific thread:
		/*
		 RACChannelTerminal *accumulateChannel = RACChannelTo(_ticker, accumulateEnabled);
		 RAC(self, paused) = [accumulateChannel deliverOn:RACScheduler.mainThreadScheduler];
		 [[RACObserve(self, paused) skip:1] subscribe:accumulateChannel];
		 */


		// Observe the accumulate enabled property and update the UI-facing string for what actions are available.
		[[[RACObserve(_ticker, accumulateEnabled) deliverOn:[RACScheduler mainThreadScheduler]]
		  // Start with the stop tick string.
		  startWith:kStopTickString]
		 subscribeNext:^(NSNumber *enabled) {
			 @strongify(self);
			 self.tickStateString = (enabled.boolValue ? kStopTickString : kStartTickString);
		}];
	}
	return self;
}

@end
