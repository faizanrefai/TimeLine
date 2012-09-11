
#import "RootView.h"
#import "RootViewDelegate.h"

@implementation RootView

@synthesize delegate = _delegate;
@synthesize type;


- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		_orientation = UIDeviceOrientationUnknown;
		_delegate = nil;
	}
	
	return self;
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldRotateToOrientation:(UIDeviceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	if (interfaceOrientation == _orientation) {
		return NO;
	} else {
	return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft 
			|| interfaceOrientation == UIInterfaceOrientationLandscapeRight);
	}
}


- (CGAffineTransform)transformForOrientation {
	UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
	if (orientation == UIInterfaceOrientationLandscapeLeft) {
		return CGAffineTransformMakeRotation(M_PI*1.5);
	} else if (orientation == UIInterfaceOrientationLandscapeRight) {
		return CGAffineTransformMakeRotation(M_PI/2);
	} else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
		return CGAffineTransformMakeRotation(-M_PI);
	} else {
		return CGAffineTransformIdentity;
	}
}


- (void)sizeToFitOrientation:(BOOL)transform {
	if (transform) {
		self.transform = CGAffineTransformIdentity;
	}
	
	_orientation = [UIApplication sharedApplication].statusBarOrientation;
	
	CGRect frame = [UIScreen mainScreen].applicationFrame;
	CGPoint center = CGPointMake(
								 frame.origin.x + ceil(frame.size.width/2),
								 frame.origin.y + ceil(frame.size.height/2));
	self.center = center;
	
	if (transform) {
		self.transform = [self transformForOrientation];
	}
}


- (void)addObservers {
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(deviceOrientationDidChange:)
												 name:@"UIDeviceOrientationDidChangeNotification" object:nil];
}

- (void)removeObservers {
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:@"UIDeviceOrientationDidChangeNotification" object:nil];
}

- (void)postDismissCleanup {
	[self removeObservers];
	[self removeFromSuperview];
}

- (void)dismiss:(BOOL)animated {
	[self dialogWillDisappear];
	
	// Handle animation in subclass.
}


- (IBAction)cancel:(id)sender {
	[self dismissWithSuccess:NO animated:YES];
}

#pragma mark -
#pragma mark UIDeviceOrientationDidChangeNotification

- (void)deviceOrientationDidChange:(void*)object {
	UIDeviceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
	if ([self shouldRotateToOrientation:orientation]) {
		
		CGFloat duration = [UIApplication sharedApplication].statusBarOrientationAnimationDuration;
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:duration];
		[self sizeToFitOrientation:YES];
		[UIView commitAnimations];
	}
}


- (void)show {
	[self load];
	[self sizeToFitOrientation:NO];
	
	UIWindow* window = [UIApplication sharedApplication].keyWindow;
	if (!window) {
		window = [[UIApplication sharedApplication].windows objectAtIndex:0];
	}
	[window addSubview:self];
	
	[self dialogWillAppear];
	
	[self addObservers];
	
	// Handle animation in subclass.
}


- (void)dismissWithSuccess:(BOOL)success animated:(BOOL)animated {
	if (success) {
		if ([_delegate respondsToSelector:@selector(dialogDidComplete:)]) {
			[_delegate dialogDidComplete:self];
		}
	} else {
		if ([_delegate respondsToSelector:@selector(dialogDidNotComplete:)]) {
			[_delegate dialogDidNotComplete:self];
		}
	}
	
	[self dismiss:animated];
}

- (void)dismissWithError:(NSError*)error animated:(BOOL)animated {
	if ([_delegate respondsToSelector:@selector(dialog:didFailWithError:)]) {
		[_delegate dialog:self didFailWithError:error];
	}
	
	[self dismiss:animated];
}


- (BOOL)isVisible {
	return visible;
}

// Intended for subclasses to override
- (void)load {
}


- (void)dialogWillAppear {
	self.alpha = 1.0;
//	TickerFriendsAppDelegate *appDelegate = (TickerFriendsAppDelegate *)[[UIApplication sharedApplication] delegate];
//	[appDelegate.window getSubviewsInFront];
	
	visible = YES;
}


- (void)dialogWillDisappear {
	visible = NO;
}


- (void)dealloc {
	self.type = nil;
    [super dealloc];
}


@end
