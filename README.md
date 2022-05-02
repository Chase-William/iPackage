### iPackage

The app you didn't know, you didn't need. Browse and save Nuget packages on the go!

### Main Views

#### `SearchView`

Search for packages registered with Nuget's package system. `iPackage` currently supports two primary search parameters, that being `Dependencies` and `Templates`.

Dependencies are libraries you can add to your projects.
Templates are existing projects you can extended with your own implementations.

Once you search and click on a package you will open the `DetailView`.

#### `DetailView`

The detail view allows you to view information about the project including icon, name, version, owner(s), author(s) and the readme.

If you like the package and would like to bookmark it or save it essentially for offline mode, you can click bookmark icon in the top right. Doing so will save the bookmark to *core data*.

To view all saved packages click on the bookmark icon in the tab navigation.

#### `SavedView`

This view displays all the saved packages present in *core data*. Since this data is saved locally and therefore won't update when the origin does, you can go to settings and toggle *Automatic Package Updates*. 

> Automatic Updates mean that whenever you load the list of packages, each one is ensured to be updated against the nuget package registry. Manual Updates as the name implies that you will either need to pull down to refresh the list to sync or enter each package's `DetailView` and click the sync button.

Also in settings you can see an option to toggle the readme's presentation mode. Depending on the size of the screen and the content provided, the readme may be quite small. Therefore, I provided an option for user's to instead just have a link shown that will take them to an in-app safari instance for viewing the project.

Clicking on one of the packages will open the same `DetailView` from earlier. Here you can view the same information as before and you can actually adjust a few things with settings.

### Dependencies

- <a href="https://github.com/Alamofire/Alamofire">`Alamofire`</a>
- <a href="https://github.com/globulus/swiftui-flow-layout">`SwiftUIFlowLayout`</a>