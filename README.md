# Left 4 Lib
This addon contains some shared VScript code that is used by my addons:
- [Left 4 Bots](https://steamcommunity.com/sharedfiles/filedetails/?id=2279814689)
- [Left 4 Fun](https://steamcommunity.com/sharedfiles/filedetails/?id=1722866167)
- [Left 4 Grief](https://steamcommunity.com/sharedfiles/filedetails/?id=2250557219)

***This addon is mandatory if you have one of the addons listed above. They will not work without this!***

### Centralized User System
L4L also contains a centralized user system that is shared among all my addons.

The system automatically assigns a user level to the joining player. The other addons will use this level to give/restrict access to certain features to that player.

The L4U user levels are:
- Admin
- Friend
- User
- Griefer

When you first host a local game with this and one of my other addons (Left 4 Fun, Left 4 Bots, Left 4 Lib), you (the host) are automatically added as admin and you will be admin on all the addons.

You can add other admins by editing the file `ems/left4lib/cfg/admins.txt` or directly ingame with the following commands:
- Via chat: `!l4u add [player/character name] admin`
- Via console: `scripted_user_func l4u,add,[player/character name],admin`

Remove the admin with:
- Via chat: `!l4u remove [player/character name]`
- Via console: `scripted_user_func l4u,remove,[player/character name]`

At the same way you can assign a **Friend** or **Griefer** level to a player:
- Via chat: `!l4u add [player/character name] [friend/griefer]`
- Via console: `scripted_user_func l4u,add,[player/character name],[friend/griefer]`

And you can remove the assigned level the same way you remove admins.

The **Friend** and **Griefer** lists are saved into the files `ems/left4lib/cfg/friends.txt` and `ems/left4lib/cfg/griefers.txt`.

The players who do not belong to any of these lists are automatically given the normal **User** level.


## Addon settings
L4L also has its own settings. You can find more details [HERE](https://github.com/smilz0/Left4Lib/blob/main/root/scripts/vscripts/left4lib_settings.nut).

***Some of these settings (like hooks_chatcommand_trigger) affect all the addons that use this library.***

You can change the settings by editing the file `ems/left4lib/cfg/settings.txt`.


## Compatibility
This should be fully compatible with any Admin System/VSLib version and most addons in general.


## Are you a L4D2 modder?
You are free to use the features contained in this addon, if you want to. Technical details can be found in the form of comments inside the .nut files.

Only one thing i ask you: please, do not put the L4L files in your addon but consider referencing L4L as an external required addon like i do in L4F, L4B and L4G. Reason for this is that by duplicating this library you will create multiple versions of it making the addons using the library incompatible to each other.
