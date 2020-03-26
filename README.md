# BudgetMeApp [![Build Status](https://travis-ci.org/kuriishu27/BudgetMeApp.svg?branch=master)](https://travis-ci.org/kuriishu27/BudgetMeApp)
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
- [ ] Transaction Feed
- [ ] Savings goals
- [ ] Login screen
- [ ] Budget View
- [ ] Spending Insights
- [ ] Card settings
- [ ] Analytics View
- [ ] SwiftUI version (other repo)

# Screenshots 


![Transaction Feed](https://user-images.githubusercontent.com/18484997/77705139-cea6f280-6fb6-11ea-80ae-16f1d583aa5d.png)
![Savings](https://user-images.githubusercontent.com/18484997/77705137-ce0e5c00-6fb6-11ea-8bab-b690122c8318.png)
