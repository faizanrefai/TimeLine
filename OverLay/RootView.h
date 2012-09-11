
#import <UIKit/UIKit.h>


@protocol RootViewDelegate;

@interface RootView : UIView {
	id<RootViewDelegate> _delegate;
	NSString *type;
	
	BOOL visible;
	
	UIDeviceOrientation _orientation;
}

/**
 * The delegate.
 */
@property(nonatomic,assign) id<RootViewDelegate> delegate;

/**
 * Type of View to seach from stack.
 */
@property(nonatomic, retain) NSString *type;

/**
 * Returns true if the Menu is already visible on screen.
 */
- (BOOL)isVisible;

/**
 * Displays the view with an animation.
 *
 * The view will be added to the top of the current key window.
 */
- (void)show;

/**
 * Displays the first page of the dialog.
 *
 * Do not ever call this directly.  It is intended to be overriden by subclasses.
 */
- (void)load;

/**
 * Removes the overlay view from superview without informing delegates
 */
- (void)dismiss:(BOOL)animated;

/**
 * Hides the view and notifies delegates of success or cancellation.
 */
- (void)dismissWithSuccess:(BOOL)success animated:(BOOL)animated;

/**
 * Hides the view and notifies delegates of an error.
 */
- (void)dismissWithError:(NSError*)error animated:(BOOL)animated;

/**
 * Subclasses may override to perform actions just prior to showing the dialog.
 */
- (void)dialogWillAppear;

/**
 * Subclasses may override to perform actions just after the dialog is hidden.
 */
- (void)dialogWillDisappear;

/**
 * Close the overlay view.
 */
- (IBAction)cancel:(id)sender;

/**
 * Override to allow orientations other than the default portrait orientation.
 */
- (BOOL)shouldRotateToOrientation:(UIDeviceOrientation)interfaceOrientation;

- (CGAffineTransform)transformForOrientation;

- (void)postDismissCleanup;

@end