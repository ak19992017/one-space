# One Space

Your space for capturing ideas.

## Supported platform

✅ Android
✅ Web
✅ IOS

## Folder Structure for Clean Architecture

✅ Components to make our widgets more reusable and organized.
✅ Constants are the code that is immutable in your application.
✅ Core is responsible for the services which the app will use all along its lifecycle.There are two core services we usually set up: Dependency Injection & Navigation
✅ Interfaces is the place where you store the files that will help you to communicate with an API or some external resource
✅ Middlewares are responsible for providing an extension to an event or action from your application. This can be an HTTP request interceptor, a logger or something similar.
✅ Modules folder is the most important, as it contains all modules that implement our features and its business rules. It allows us to separate our application layer from the domain layer and the infrastructure layer.With this architecture, the code will be more organized, but we also need to modularize it to make it easy to add a new feature, modify the old ones and make the code more reusable. This approach supports testability, which is a good point for building a reliable project and improving code quality.
