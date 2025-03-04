<img src="https://repository-images.githubusercontent.com/250388327/db7e9580-7524-11ea-8b79-b97d6394f2c1" width="80%" />

Personal finances app using Starling bank's API with RxSwift + MVVM architecture

# Requirements
- iOS 13+
- Xcode 14

# Screenshots
<div style="block: inline">
    <img alt="Login" src="https://user-images.githubusercontent.com/18484997/78169655-a2bdbe00-7449-11ea-9dfb-60f3e708f36b.png" width="20%">
    <img alt="Updated Transaction Feed" src="https://user-images.githubusercontent.com/18484997/78266111-3d2b0980-74fd-11ea-925d-9013a4856bc3.png" width="20%">
    <img alt="Updated Transaction Feed" src="https://user-images.githubusercontent.com/18484997/78266111-3d2b0980-74fd-11ea-925d-9013a4856bc3.png" width="20%" >
    <img alt="Transaction Details" src="https://user-images.githubusercontent.com/18484997/77860695-6d765d80-7208-11ea-919d-56459150ce16.png" width="20%">
</div>

# Highlights and benefits
- Reactive programming - Declarative programming paradigm concerned with data streams and the propagation of change.
- MVVM architecture - Better application of SOLID principles and encapsulation of components. Offering better testability and flexibility.

## Summary
This app currently shows all accounts and will eventually show the balance, overdraft, pending transactions.
Atm, it shows one demo account and transitions into a UITabViewController where you can switch between transactions and savings goals.

All network requests and errors are handled by the ViewModel through bindings.

You can create a new savings goal in the savings section.

Changes in the UI and UX will be made along with writing unit tests.

## Starling Bank's API
https://developer.starlingbank.com/docs


# Features

Swift Package Manager for managing dependencies
- RxSwift, RxCocoa - 
Using Reactive Programming for asynchronous network requests and bindings.
- Moya, RxMoya - 
Using Moya to encapsulate specific requests by category. e.g. AccountsService, TransactionFeedService..
- RxTest - Testing value changes over time

# Upcoming / Tasks
- [ ] Authentication 
- ✅ ViewModel testing with RxTest
- [ ] Accounts
- ✅ Transaction Feed Details
- [ ] Savings goals
- ✅ Login screen (view)
- ✅ Transaction View (design change)
- [ ] Filters
- [ ] Login screen (functionality) (in progress, 6-APR)
- [ ] Budget View
- [ ] Spending Insights
- [ ] Card settings
- [ ] Analytics View
- [ ] SwiftUI version 

# Contributing
Feel free to send me an email if you want to contribute to extending this app. Or you can just fork the repo and make your own changes and submit a PR. 
christian.leovido@gmail.com

I would appreciate any feedback as I'm constantly looking for more efficient ways of writing code and building software. 😄

# Screenshots



<img alt="Savings" src="https://user-images.githubusercontent.com/18484997/77860828-3d7b8a00-7209-11ea-813a-18e7114bc892.png" width=250 align=left>
<img alt="Transaction Feed" src="https://user-images.githubusercontent.com/18484997/77860702-723b1180-7208-11ea-907e-f0e8704bed20.png" width=250 align=left>
<img alt="Search results" src="https://user-images.githubusercontent.com/18484997/78168715-5756e000-7448-11ea-8a63-5a74bace85a5.png" width=250 align=center>
