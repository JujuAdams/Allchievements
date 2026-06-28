var _string = $"Allchievements {ALLCH_VERSION}, {ALLCH_DATE}\n";
_string += $"Gamepad = {gamepad} (press gp_face1 to choose gamepad)\n";
_string += $"\n";
_string += $"Local changed = {AllchGetChanged()? "true" : "false"}\n";

_string += $"\n";
_string += $"[E] / [start]  = Export local data\n";
_string += $"[I] / [select] = Import local data\n";
_string += $"[C] / [face4]  = Unaward all allchs\n";
_string += $"\n";

_string += $"[1] / [up]    = Award ALLCH_ACH.SHINY_MACGUFFIN\n";
_string += $"[2] / [right] = Award ALLCH_ACH.SLAY_FIVE_RATS\n";
_string += $"[3] / [down]  = Award ALLCH_ACH.OBNOXIOUS_JUMPING_PUZZLE\n";
_string += $"[4] / [left]  = Award ALLCH_ACH.WACKY_NPC_INTERACTION\n";
_string += $"\n";
_string += $"ALLCH_ACH.SHINY_MACGUFFIN state          = {AllchGetValue(ALLCH_ACH.SHINY_MACGUFFIN         )} / {AllchGetTarget(ALLCH_ACH.SHINY_MACGUFFIN         )} = {AllchGetUnlocked(ALLCH_ACH.SHINY_MACGUFFIN         )? "true" : "false"}\n";
_string += $"ALLCH_ACH.SLAY_FIVE_RATS state           = {AllchGetValue(ALLCH_ACH.SLAY_FIVE_RATS          )} / {AllchGetTarget(ALLCH_ACH.SLAY_FIVE_RATS          )} = {AllchGetUnlocked(ALLCH_ACH.SLAY_FIVE_RATS          )? "true" : "false"}\n";
_string += $"ALLCH_ACH.OBNOXIOUS_JUMPING_PUZZLE state = {AllchGetValue(ALLCH_ACH.OBNOXIOUS_JUMPING_PUZZLE)} / {AllchGetTarget(ALLCH_ACH.OBNOXIOUS_JUMPING_PUZZLE)} = {AllchGetUnlocked(ALLCH_ACH.OBNOXIOUS_JUMPING_PUZZLE)? "true" : "false"}\n";
_string += $"ALLCH_ACH.WACKY_NPC_INTERACTION state    = {AllchGetValue(ALLCH_ACH.WACKY_NPC_INTERACTION   )} / {AllchGetTarget(ALLCH_ACH.WACKY_NPC_INTERACTION   )} = {AllchGetUnlocked(ALLCH_ACH.WACKY_NPC_INTERACTION   )? "true" : "false"}\n";

draw_set_font(fntConsolas);
draw_text(10, 10, _string);