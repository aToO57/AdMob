using Uno;
using Uno.UX;
using Uno.Compiler.ExportTargetInterop;

using Fuse;
using Fuse.Controls;
using Fuse.Controls.Native;

public class AdMob : Panel
{
    protected override IView CreateNativeView()
    {
        if defined(Android)
        {
            return new Android.AdMobView();
        }
        else if defined(iOS)
        {
            throw new NotImplementedException();
        }
        else
        {
            return base.CreateNativeView();
        }
    }
}

namespace Android
{
    using Fuse.Controls.Native.Android;

    [Require("Gradle.Repository","mavenCentral()")]
	[Require("Gradle.Dependency","compile('com.google.gms:google-services:3.0.0')")]
	[Require("Gradle.Dependency","compile('com.google.firebase:firebase-ads:9.4.0')")]

	[ForeignInclude(Language.Java, "com.google.android.gms.ads.AdRequest")]
	[ForeignInclude(Language.Java, "com.google.android.gms.ads.NativeExpressAdView")]
	[ForeignInclude(Language.Java, "com.google.android.gms.ads.AdSize")]
	[ForeignInclude(Language.Java, "com.google.android.gms.ads.MobileAds")]

	[ForeignInclude(Language.Java, "android.content.Intent")]
	[ForeignInclude(Language.Java, "com.fuse.Activity")]

    //extern(Android) public class AdMobView { }

    extern(Android) public class AdMobView : LeafView
    {

        static AdMobView()
        {
            Initialize();
        }

        public AdMobView() : base(Create())
        {

        }

        [Foreign(Language.Java)]
        static Java.Object Create()
        @{
            AdRequest adRequest = new AdRequest.Builder()
					.build();

			NativeExpressAdView adView = new NativeExpressAdView(Activity.getRootActivity());
	        adView.setAdSize(new AdSize(320,450));
	        adView.setAdUnitId("ca-app-pub-1817717249774584/3512298558");
	        adView.loadAd(adRequest);

			return adView;
        @}

        [Foreign(Language.Java)]
        static void Initialize()
        @{
            MobileAds.initialize(Activity.getRootActivity(), "ca-app-pub-3940256099942544~3347511713");
        @}

    }
}