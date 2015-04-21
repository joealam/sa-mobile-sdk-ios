//
//  SAInterstitialView.h
//  SAMobileSDK
//
//  Created by Balázs Kiss on 12/08/14.
//  Copyright (c) 2014 SuperAwesome Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SAPlacementView.h"
#import "SAParentalGate.h"

/**
 * Defines the interface the delegate of an interstitial ads
 */
@class SAInterstitialView;

@protocol SAInterstitialViewDelegate <NSObject>
@optional

/**
 * Called when the interstial ad is fetched from a campaign and available to be displayed.
 * You should put up the ad on the screen at this time.
 *
 * @param interstitialView The interstitial ad view that fetched the ad.
 */
- (void)didSuccessfullyFetchInterstitialAd:(SAInterstitialView *)interstitialView;

/**
 * The ad was hidden from view. It gets called either when the ad is dismissed by the user or the refresh timer fires for the ad.
 * You should take down the interstitial ad from the screen at this time.
 *
 * @param interstitialView The interstitial ad view that was shown.
 *
 * @note You must implement and take action when this method is called on the delegate.
 */
- (void)didHideInterstitialView:(SAInterstitialView *)interstitialView;

/**
 * Called when an ad fails to be fetched. Usually this happens because of networking conditions and in rare cases if an exceptions occurs on the server.
 * You can call load to try again, if you think the conditions leading to the error have changed.
 *
 * @param interstitialView The interstitial ad view that fetched the ad.
 */
- (void)didFailFetchingInterstitialAd:(SAInterstitialView *)interstitialView;

/**
 * Called when the user interaction with the ad triggers leaving the application.
 * This can be, for example, opening a URL in Safari or Maps or another application registered to handle the URL specified by the ad.
 * You should save the state of the application when you get this call.
 *
 * @param interstitialView The interstitial ad view that fetched the ad.
 *
 */
- (void)willLeaveApplicationForInterstitialAd:(SAInterstitialView *)interstitialView;
@end


@interface SAInterstitialView : SAPlacementView <ATInterstitialViewDelegate, SAParentalGateDelegate>

/**
 * The delegate gets notified of different events in the lifecycle of the ad.
 * Your presenting view controller should register itself as delegate of the ad view.
 *
 * @see SAInterstitialViewDelegate
 */
@property (nonatomic,weak) id<SAInterstitialViewDelegate> delegate;

/**
 * Returns YES when an interstitial ad is ready to be presented.
 * The delegate's  didSuccessfullyFetchInterstitialAd: is called when the value switches from NO to YES.
 * Once an interstitial is presented, the value changes to NO. You need to load again in order
 * to be able to present another interstitial view.
 */
@property (nonatomic, readonly) BOOL isReady;

/**
 *  Initialises the interstitial ad in the given view controller
 *
 *  @param viewController The view controller that is the owner of the ad view being shown.
 *
 *  @return New interstitial instance
 */
- (instancetype)initWithViewController:(UIViewController *)viewController;

/**
 * Presents the interstitial view modally on top of the view controller.
 * Call this method after receiving the [SAInterstitialViewDelegate didSuccessfullyFetchInterstitialAd:] callback in order
 * to present the interstitial. It will be automatically dismissed after the refresh interval or when the user chooses to close it.
 * Calling this method before receiving the above callbacks will have no effect.
 */
- (void)present;

/**
 * Begins loading a new ad. The view should be configured before calling this method.
 */
- (void)load;

/**
 * Sets the background color for the interstitial.
 * The default color is clear on iOS 8 and above and white on iOS 6 and 7.
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor;

@end
