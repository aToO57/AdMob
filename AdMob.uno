using Fuse;
using Fuse.Platform;
using Fuse.Scripting;
using Fuse.Reactive;
using Uno;
using Uno.UX;
using Uno.Permissions;
using Uno.Threading;
using Uno.Compiler.ExportTargetInterop;





[Require("Gradle.Repository","mavenCentral()")]
[Require("Gradle.Dependency","compile('com.google.gms:google-services:3.0.0')")]
[Require("Gradle.Dependency","compile('com.google.firebase:firebase-ads:9.4.0')")]


[ForeignInclude(Language.Java, "com.google.android.gms.ads.AdRequest")]
[ForeignInclude(Language.Java, "com.google.android.gms.ads.AdView")]
[ForeignInclude(Language.Java, "com.google.android.gms.ads.AdSize")]
[ForeignInclude(Language.Java, "com.google.android.gms.ads.MobileAds")]

[ForeignInclude(Language.Java, "android.content.Intent")]
[ForeignInclude(Language.Java, "com.fuse.Activity")]

[UXGlobalModule]
public class AdMob : NativeModule
{
	public AdMob()
	{
		Lifecycle.Started += Started;
		Lifecycle.EnteringInteractive += OnEnteringInteractive;
		Lifecycle.ExitedInteractive += OnExitedInteractive;
	}

	
	extern(Android) Java.Object _callbackManager;

	[Foreign(Language.Java)]
	extern(Android) void Started(ApplicationState state)
	@{
		MobileAds.initialize(Activity.getRootActivity(), "ca-app-pub-3940256099942544~3347511713");
		AdRequest adRequest = new AdRequest.Builder()
				.addTestDevice("ABCDEF012345")
				.build();

		AdView mAdView = new AdView(Activity.getRootActivity());
		mAdView.setAdSize(AdSize.MEDIUM_RECTANGLE);
		mAdView.setAdUnitId("ca-app-pub-3940256099942544/6300978111");     
		mAdView.loadAd(adRequest);

		//LinearLayout layout = new LinearLayout(this);
		//layout.setOrientation(LinearLayout.VERTICAL);
		//layout.addView(mAdView);

		//setContentView(layout);	
	@}

	extern(!Android) void Started(ApplicationState state)
	{
	}

	[Foreign(Language.Java)]
	static extern(Android) void OnEnteringInteractive(ApplicationState state)
	@{

	@}

	static extern(!Android) void OnEnteringInteractive(ApplicationState state)
	{
	}

	[Foreign(Language.Java)]
	static extern(Android) void OnExitedInteractive(ApplicationState state)
	@{
		
	@}

	static extern(!Android) void OnExitedInteractive(ApplicationState state)
	{
	}
}
