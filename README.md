A framework for allowing / denying a WeakAuras to request to specific API calls that have been previously blocked by default.

This is like unlocking Developer Mode in Android, it can allow you do to exactly what you want ... but it also allows you to pwn yourself if you dont read the code of the weakauras you import.

The following functions are availible:

`sudo.add(API_NAME, _G)`
 - API_NAME is any World of Warcraft API (see: [World_of_Warcraft_API](https://wowwiki-archive.fandom.com/wiki/World_of_Warcraft_API))
 - _G is the restricted `global` object made availible within weakauras custom code sandbox, more info can be found [here](https://github.com/WeakAuras/WeakAuras2/blob/main/WeakAuras/AuraEnvironment.lua), but in most cases this will simply be `_G`

This function will prompt the user, and if allowed will add the specified api to the `global` object within the weakauras sandbox.  It would be nice to be able to pick and choose which weakauras could get access to which api, but currently the `global` object is shared between all weakauras and thus it is not possible to determin which weakaura is calling `sudo.add` or restrict which weakaura has access to the enabled API within the `global` object.  You could instead pass localy scoped object rather than the `global` object to restrict access to just your weakaura, but that is up to the individual weakaura dev to decide.

`sudo.su(_G)`
 - _G is the restricted `global` object made availible within weakauras custom code sandbox, more info can be found [here](https://github.com/WeakAuras/WeakAuras2/blob/main/WeakAuras/AuraEnvironment.lua), but in most cases this will simply be `_G`

This function will prompt the user, and if allowed will replace the restricted `global` object with a direct reference to the real `_G` global object that was accessible to the sudo addon at load time. This is more of a sledge hammer approach, but is made availible all the same.