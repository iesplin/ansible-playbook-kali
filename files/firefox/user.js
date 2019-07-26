// User preferences for Firefox

// Fix widget behaviour with dark theme
user_pref("widget.content.gtk-theme-override", "Kali-X");

// Disable New Tab Page
user_pref("browser.newtabpage.enabled", false);

// Disable search suggestions
user_pref("browser.search.suggest.enabled", false);

// Disable telemetry
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("browser.pingcentre.telemetry", false);
user_pref("devtools.onboarding.telemetry-logged", false);
user_pref("media.wmf.deblacklisting-for-telemetry-in-gpu-process", false);
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.bhrping.enabled", false);
user_pref("toolkit.telemetry.firstshutdownping.enabled", false);
user_pref("toolkit.telemetry.hybridcontent.enabled", false);
user_pref("toolkit.telemetry.newprofileping.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.updateping.enabled", false);
user_pref("toolkit.telemetry.shutdownpingsender.enabled", false);

// Disable prefetching
user_pref("network.dns.disablePrefetch", true);
user_pref("network.predictor.enable-prefetch", false);

// Prevent WebRTC leaking IP addresses
user_pref("media.peerconnection.ice.no_host", true);

// Don't submit invalid URIs to the default search engine
user_pref("keyword.enabled", false);

// Don't try to guess domain names for invalid domain names
user_pref("browser.fixup.alternate.enabled", false);
