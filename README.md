# sudo
A framework for allowing / denying a WeakAuras to request to specific API calls that have been previously blocked by default.

This is like unlocking Developer Mode in Android, it can allow you do to exactly what you want ... but it also allows you to pwn yourself if you dont read the code of the weakauras you import.

## The following functions are availible:

`sudo.add(API_NAME, _G)`
 - API_NAME (string) is any World of Warcraft API (see: [World_of_Warcraft_API](https://wowwiki-archive.fandom.com/wiki/World_of_Warcraft_API))
 - _G (table) is the restricted `global` object made availible within weakauras custom code sandbox, more info can be found [here](https://github.com/WeakAuras/WeakAuras2/blob/main/WeakAuras/AuraEnvironment.lua), but in most cases this will simply be `_G`

This function will prompt the user, and if allowed will add the specified api to the `global` object within the weakauras sandbox.  It would be nice to be able to pick and choose which weakauras could get access to which api, but currently the `global` object is shared between all weakauras and thus it is not possible to determin which weakaura is calling `sudo.add` or restrict which weakaura has access to the enabled API within the `global` object.  You could instead pass localy scoped object rather than the `global` object to restrict access to just your weakaura, but that is up to the individual weakaura dev to decide.

`sudo.su(_G)`
 - _G (table) is the restricted `global` object made availible within weakauras custom code sandbox, more info can be found [here](https://github.com/WeakAuras/WeakAuras2/blob/main/WeakAuras/AuraEnvironment.lua), but in most cases this will simply be `_G`

This function will prompt the user, and if allowed will replace the restricted `global` object with a direct reference to the real `_G` global object that was accessible to the sudo addon at load time. This is more of a sledge hammer approach, but is made availible all the same.

## Settings can be saved per Account or per Character by running the following commands:

Default `sudo.su` to always approved for entire account:

`/script sudoSavedAccount["Remove WeakAura Safety Features for the Blizzard API: 'ALL THE THINGS'?"] = true`

Default `sudo.su` to always denied for entire account:

`/script sudoSavedAccount["Remove WeakAura Safety Features for the Blizzard API: 'ALL THE THINGS'?"] = false`

Default `sudo.su` to always prompt for entire account:

`/script sudoSavedAccount["Remove WeakAura Safety Features for the Blizzard API: 'ALL THE THINGS'?"] = nil`

Default `sudo.add` of a specific API to approved for entire account:

`/script sudoSavedAccount["Remove WeakAura Safety Features for the Blizzard API: 'DeleteCursorItem'?"] = true`

Default `sudo.su` to always approved for specific character:

`/script sudoSavedChar["Remove WeakAura Safety Features for the Blizzard API: 'ALL THE THINGS'?"] = true`

Default `sudo.add` of a specific API to approved for a specific character:

`/script sudoSavedChar["Remove WeakAura Safety Features for the Blizzard API: 'DeleteCursorItem'?"] = true`

By default everything is set to prompt, Character settings take priority over Account settings.

## A note about wow addon security

All api commands that this addon exposes are published and approved by Blizzard.  Weakauras has taken it upon themselves to block some of this api to protect users from themselves.  Some users need to be protected from themselves, while others can be trusted to know what they are doing and/or take ownership for screwing up if they dont.  Every weakaura you install has the potential of doing nasty stuff, just like every addon you install has the potential of doing nasty stuff.  The protections imposed by the weakaura dev team, while a valient effort on their part are flimsy at best and a false sense of security at worst.  As this project clearly demonstrates, those security measure can be bypassed via another addon or in some cases by clever use of a weakaura itself (though I will not publish how).

If some weakaura told you that you need to download this addon, you should be extreemly scheptical of that weakaura and its author(s) unless you know EXACTLY why its needed.  That is not to say that the project that directed you here is nessiarly evil, just that it has a higher liklyhood of being evil ... here be dragons, beware.
