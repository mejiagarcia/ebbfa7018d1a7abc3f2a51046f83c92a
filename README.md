# GL iOS Developer test

# FAQ

## Architecture
I chose a classic MVVM implementation, in order to mainatin the app simple and organized.

## What is going on with UITableView implementation?
Maybe at the first look it look's like overengineering. What I did: Create a generic UITableView adapter, in order to keep my ViewController simple and build the table components directly from the ViewModel.

## There is no external dependencies?
No libraries were needed to create this test.

## Carlos, did you forgot something in the test?
Unfortanly the time wasn't enough to improve UI details.

## Something that you want to talk about?
Yes, time wasn't enough to create a proper Endpoint validation and creation, so it's directly hardocoded altohugh I know that is a bad practice.

## I see a lot of folders, why is that?
This is the project structure

root ->  Commons/Helpers Modules ->  HomeModule -> View, ViewModel, Service, Models, Constants

As you can see, I'm trying to keep the modules (or screens) as independent as possible.
