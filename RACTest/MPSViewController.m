//
//  MPSViewController.m
//  RACTest
//
//  Created by Christopher Bowns on 12/9/13.
//  Copyright (c) 2013 Mechanical Pants. All rights reserved.
//

#import "MPSViewController.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

// ViewModel:
#import "MPSViewModel.h"

@interface MPSViewController ()

@property (nonatomic, weak) IBOutlet UIButton *startStopButton;

@property (nonatomic, weak) IBOutlet UILabel *currentTimeLabel;

@property (nonatomic, strong) MPSViewModel *viewModel;

@end

@implementation MPSViewController

#pragma mark - Initializers

/// The designated initialization chain in iOS 7 is balls.
- (void)finishInitialization
{
	// Custom initialization goes here:
	_viewModel = [[MPSViewModel alloc] init];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self finishInitialization];
	}
	return self;
}

- (id)init
{
	self = [super init];
	if (self) {
		[self finishInitialization];
	}
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		[self finishInitialization];
	}
	return self;
}

#pragma mark - View lifecycle

/// Binds RAC signals from the viewmodel to views.
- (void)viewDidLoad
{
    [super viewDidLoad];

	// Bind our label's text to the viewmodel's label string.
	RAC(self.currentTimeLabel, text) = RACObserve(self.viewModel, tickString);

	// Map our button's label text to the viewModel's state string.
	RAC(self.startStopButton.titleLabel, text) = RACObserve(self.viewModel, tickStateString);

	// Bind the button presses up to the viewmodel's paused property.
	[[self.startStopButton rac_signalForControlEvents:UIControlEventTouchUpInside]
	 subscribeNext:^(id x) {

		 NSLog(@"%s x: %@", __func__, x);
	 }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
