
#import "RootView.h"

/*
 * Delegate for handling events in subclasses.
 */
@protocol RootViewDelegate <NSObject>

@optional

/**
 * Called when the dialog succeeds and is about to be dismissed.
 */
- (void)dialogDidComplete:(RootView *)view;


/**
 * Called when the dialog is cancelled and is about to be dismissed.
 */
- (void)dialogDidNotComplete:(RootView *)view;

/**
 * Called when dialog failed to load due to an error.
 */
- (void)dialog:(RootView *)view didFailWithError:(NSError *)error;

@end
