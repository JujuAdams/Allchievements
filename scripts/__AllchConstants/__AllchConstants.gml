#macro ALLCH_VERSION  "1.1.0"
#macro ALLCH_DATE     "2026-06-26"

#macro ALLCH_RUNNING_FROM_IDE  (GM_build_type == "run")

#macro ALLCH_ON_WINDOWS      (os_type == os_windows)
#macro ALLCH_ON_MACOS        (os_type == os_macosx)
#macro ALLCH_ON_LINUX        (os_type == os_linux)
#macro ALLCH_ON_DESKTOP      (ALLCH_ON_WINDOWS || ALLCH_ON_MACOS || ALLCH_ON_LINUX)
#macro ALLCH_ON_IOS          (os_type == os_ios)
#macro ALLCH_ON_ANDROID      (os_type == os_android)
#macro ALLCH_ON_XBOX_SERIES  (os_type == os_xboxseriesxs)
#macro ALLCH_ON_PS5          (os_type == os_ps5)
#macro ALLCH_ON_SWITCH_X     ((os_type == os_switch) || (os_type == os_switch2))

#macro ALLCH_STEAM_AVAILABLE          (__AllchSystem().__steamAvailable)
#macro ALLCH_USING_STEAMWORKS         (ALLCH_ON_DESKTOP && extension_exists("Steamworks"))
#macro ALLCH_USING_GAMECENTER         (ALLCH_ON_IOS && extension_exists("GameCenter"))
#macro ALLCH_USING_PLAY_SERVICES      (ALLCH_ON_ANDROID && extension_exists("GooglePlayServices"))
#macro ALLCH_PLAY_SERVICES_AVAILABLE  (__AllchSystem().__playServicesAvailable)
#macro ALLCH_USING_GDK                (ALLCH_ON_XBOX_SERIES || ALLCH_USING_WINDOWS_GDK)
#macro ALLCH_USING_WINDOWS_GDK        (ALLCH_ON_WINDOWS && extension_exists("GDKExtension"))