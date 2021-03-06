Display Ads
===========

In the next sections we'll see how to display banners, inline video ads, interstitials and fullscreen video ads.

We'll suppose we have the same setup as the previous section:

.. code-block:: objective-c

    @interface MyViewController () <SALoaderProtocol>
    // three SAAd objects to hold data for placements
    // 30471, 30473 and 30479
    @property (nonatomic, strong) SAAd *bannerAdData;
    @property (nonatomic, strong) SAAd *interstitialAdData;
    @property (nonatomic, strong) SAAd *videoAdData;
    @end

Additionally we'll also create four display objects we'll want to show at the press of a button in our app:

.. code-block:: objective-c

    @interface MyViewController () <SALoaderProtocol>
    // rest of category implementation ...
    // then define four SuperAwesome ad display objects
    @property (nonatomic, strong) SABannerAd *banner;
    @property (nonatomic, strong) SAVideoAd *video;
    @property (nonatomic, strong) SAInterstitialAd *interstitial;
    @property (nonatomic, strong) SAFullscreenVideoAd *fvideo;
    @end

Banner ads
^^^^^^^^^^

To following code snippet shows you how to init and add a **SABannerAd** object to your view controller.

.. code-block:: objective-c

    @implementation MyViewController
    // rest of your implementation ...

    - (IBAction) showBanner {
      CGRect top = CGRectMake(0, 0, 320, 50);
      _banner = [[SABannerAd alloc] initWithFrame:top];
      [_banner setAd:bannerAdData];

      [self.view addSubview:_banner];
      [_banner play];
    }

    @end

Notice that SABannerAd is a subclass of the generic UIView class from Cocoa. Thus it needs to be initialized using
**initWithFrame:** and needs to be added to the view hierarchy.

The two functions to pay attention here are **setAd:** and **play**.

* **setAd:** takes a SAAd object as parameter, in this case bannerAdData. It tells the banner what ad data to try to display.
* **play** actually starts the display process on screen.

In-Line Video ads
^^^^^^^^^^^^^^^^^

**SAVideoAd** gets initialized and added in a similar way:

.. code-block:: objective-c

    @implementation MyViewController
    // rest of your implementation ...

    - (IBAction) showInLineVideo {
      CGRect frame = CGRectMake(0, 0, 480, 240);
      _video = [[SAVideoAd alloc] initWithFrame:frame];
      [_video setAd:videoAdData];

      [self.view addSubview: _video];
      [_video play];
    }

    @end

As with SABannerAd, the SAVideoAd class is a subclass of UIView and must be added to the view hierarchy.
It also implements the same two functions: setAd: and play.

Interstitial ads
^^^^^^^^^^^^^^^^

Interstitial ads are represented by objects of type **SAInterstitialAd**.

.. code-block:: objective-c

    @implementation MyViewController
    // rest of your implementation ...

    - (IBAction) showInterstitial {
      _interstitial = [[SAInterstitialAd alloc] init];
      [_interstitial setAd:interstitialAdData];

      [self presentViewController:_interstitial animated:YES completion:^{
        [_interstitial play];
      }];
    }

    @end

Again, notice the presence of setAd: and play - they perform the same role as for banner or video ads.

The difference here is that the SAInterstitialAd class subclasses UIViewController, so it must be presented on screen as such.

Interstitials can be closed by calling the **close** function.

Fullscreen video ads
^^^^^^^^^^^^^^^^^^^^

Finally, fullscreen video ads are represented by **SAFullscreenVideoAd**.

.. code-block:: objective-c

    @implementation MyViewController
    // rest of your implementation ...

    - (IBAction) showVideo {
      _fvideo = [[SAFullscreenVideoAd alloc] init];
      [_fvideo setAd:videoAdData];

      [self presentViewController:_fvideo animated:YES completion:^{
        [_fvideo play];
      }];
    }

    @end

SAFullscreenVideoAd is also a subclasses of UIViewController, and implements the setAd: and play methods.
Notice also the fact that we're *reusing the videoAdData* object when displaying video.

Additionally, a fullscreen video ad can have two more parameters that can be set:

.. code-block:: objective-c

    @implementation MyViewController
    // rest of your implementation ...

    - (IBAction) showVideo {
      _fvideo = [[SAFullscreenVideoAd alloc] init];
      [_fvideo setAd:videoAdData];
      [_fvideo setShouldAutomaticallyCloseAtEnd:NO];
      [_fvideo setShouldShowCloseButton:YES];

      // rest of the function ...
    }

    @end

Fullscreen video ads can be closed by calling the **close** function.
