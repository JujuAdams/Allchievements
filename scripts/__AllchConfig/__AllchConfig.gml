/// Global enum used for achievement indexes within the project. You should edit this enum and the
/// achievement definition scripts below.
enum ALLCH_ACH
{
    SHINY_MACGUFFIN,
    SLAY_FIFTY_THOUSAND_RATS,
    OBNOXIOUS_JUMPING_PUZZLE,
    WACKY_NPC_INTERACTION,
}

/// Code to execute when Allchivements initializes on game boot. You should call `AllchCreate()`
/// in this function for each achivement you would like to implement.
function __AllchConfigOnBoot()
{
    AllchCreate(ALLCH_ACH.SHINY_MACGUFFIN,          { offline: "shinyMacGuffin",  steam: "shinyMacGuffin",  playStation: undefined, xbox: undefined });
    AllchCreate(ALLCH_ACH.SLAY_FIFTY_THOUSAND_RATS, { offline: "50000rats",       steam: "50000rats",       playStation: undefined, xbox: undefined });
    AllchCreate(ALLCH_ACH.OBNOXIOUS_JUMPING_PUZZLE, { offline: "obnoxiousPuzzle", steam: "obnoxiousPuzzle", playStation: undefined, xbox: undefined });
    AllchCreate(ALLCH_ACH.WACKY_NPC_INTERACTION,    { offline: "wackyNPC",        steam: "wackyNPC",        playStation: undefined, xbox: undefined, hidden: true });
}

/// Whether to use offline storage when running on Nintendo Switch and Switch 2. If this macro is
/// set to `false` then all achivements will be ignored when running on Switch.
#macro ALLCH_SWITCH_X_OFFLINE  false

/// Whether to report lots of information messages to the console. This can be helpful to diagnose
/// problems. You will likely want to set this macro to `false` for production builds.
#macro ALLCH_VERBOSE  false

/// Enables strict type checking when calling some functions. This is helpful for debugging edge
/// cases but ordinarily should be left turned off.
#macro ALLCH_STRICT  false

/// Whether warning messages should have callstacks. This will not disable callstacks on error
/// messages.
#macro ALLCH_WARNINGS_HAVE_CALLSTACKS  true

/// Whether to force use of local data storage. This will ignore any remote or per-platform
/// services.
#macro ALLCH_FORCE_OFFLINE  false