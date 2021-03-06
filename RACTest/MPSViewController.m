//
//  MPSViewController.m
//  RACTest
//
//  Created by Christopher Bowns on 12/9/13.
//  Copyright (c) 2013 Mechanical Pants. All rights reserved.
//

#import "MPSViewController.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>

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
	[RACObserve(self.viewModel, tickStateString) subscribeNext:^(id x) {
		[self.startStopButton setTitle:x forState:UIControlStateNormal];
	}];


	// Bind the button to toggle the viewmodel's paused property.
	@weakify(self);
	[[self.startStopButton rac_signalForControlEvents:UIControlEventTouchUpInside]
	 subscribeNext:^(id x) {
		 @strongify(self);
		 // Flip the view model's paused bool.
		 self.viewModel.paused = !self.viewModel.paused;
	 }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
