# Passing data between scenes

## Which is better, passing data through viewmodel or passing data using datastore?

Both methods have their uses and it depends on the specific needs of your application.

Passing data through ViewModel: This is typically used when you want to pass data from the Interactor to the ViewController within the same scene. The Presenter prepares the data into a ViewModel, which the ViewController can then use to update the view.

Passing data using DataStore: This is used when you need to pass data from one scene to another. The DataStore holds the data that needs to be passed, and the Router accesses this data when performing the navigation.

In general, if you’re passing data within a scene (from Interactor to ViewController), you would use a ViewModel. If you’re passing data between scenes (from one Interactor to another), you would use a DataStore.

Remember, the best approach will depend on the specifics of your project and the architecture you’re using. It’s always a good idea to keep your code as decoupled and modular as possible. I hope this helps! Let me know if you have any other questions.
