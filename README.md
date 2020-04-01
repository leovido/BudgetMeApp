<img alt="Login" src="https://user-images.githubusercontent.com/18484997/78169655-a2bdbe00-7449-11ea-9dfb-60f3e708f36b.png" width=270 align=left>
<img alt="Transaction Feed" src="https://user-images.githubusercontent.com/18484997/77860702-723b1180-7208-11ea-907e-f0e8704bed20.png" width=270 align=left>
<img alt="Transaction Details" src="https://user-images.githubusercontent.com/18484997/77860695-6d765d80-7208-11ea-919d-56459150ce16.png" width=270 align=left>
<img alt="Savings" src="https://user-images.githubusercontent.com/18484997/77860828-3d7b8a00-7209-11ea-813a-18e7114bc892.png" width=270 align=left>
<img alt="Search results" src="https://user-images.githubusercontent.com/18484997/78168715-5756e000-7448-11ea-8a63-5a74bace85a5.png" width=270 align=center>


# BudgetMeApp [![Build Status](https://travis-ci.org/kuriishu27/BudgetMeApp.svg?branch=master)](https://travis-ci.org/kuriishu27/BudgetMeApp)  [![codecov](https://codecov.io/gh/kuriishu27/BudgetMeApp/branch/master/graph/badge.svg)](https://codecov.io/gh/kuriishu27/BudgetMeApp)


Personal finances app using Starling bank's API with RxSwift + MVVM architecture

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
- [ ] ViewModel testing with RxTest
- [ ] Accounts
- [x] Transaction Feed Details
- [ ] Savings goals
- [ ] Login screen
- [ ] Budget View
- [ ] Spending Insights
- [ ] Card settings
- [ ] Analytics View
- [ ] SwiftUI version (other repo)

