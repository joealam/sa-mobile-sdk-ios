After setting up the SDK, the first thing you'll want to do is start loading ads. 

To do so, you'll need to make your view or view controller implement the `SALoaderProcol`, which is a custom AwesomeAds protocol:

```
@interface MyViewController () <SALoaderProtocol>
.......
@end

```

The `SALoaderProtocol` defines two methods that any class can implement. Therefore, add the following code to your view or view controller's source file:

```
- (void) didLoadAd:(SAAd *)ad {
    // at this moment the ad data is loaded and ready to be used to display ad contents 
}

- (void) didFailToLoadAdForPlacementId:(NSInteger)placementId {
    // handle error case
}

```

When `didLoadAd:` gets called, the ad data is completely loaded.

Finally, to actually start loading the ad, in the `init` method you'll have to ad:

```
- (id) init {
	if (self = [super init]) {

		// create a Loader object
		SALoader *loader = [[SALoader alloc] init];
		[loader setDelegate: self];
		[loader loadAdForPlacementId: __PLACEMENT_ID__];

	}

	return self;
}

```

Replace `__PLACEMENT_ID__` with a valid ad placement ID from the Dashboard or one of the test placement IDs.
