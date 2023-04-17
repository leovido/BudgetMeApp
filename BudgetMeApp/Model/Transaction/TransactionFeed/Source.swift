//
//  Source.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 23/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation

enum Source: String, Decodable, CaseIterable {
  case CASH_DEPOSIT, CASH_DEPOSIT_CHARGE, CASH_WITHDRAWAL, CASH_WITHDRAWAL_CHARGE, CHAPS, CHEQUE
  case CICS_CHEQUE, CURRENCY_CLOUD, DIRECT_CREDIT, DIRECT_DEBIT, DIRECT_DEBIT_DISPUTE, INTERNAL_TRANSFER, MASTER_CARD
  case MASTERCARD_MONEYSEND, MASTERCARD_CHARGEBACK, FASTER_PAYMENTS_IN, FASTER_PAYMENTS_OUT, FASTER_PAYMENTS_REVERSAL
  case STRIPE_FUNDING, INTEREST_PAYMENT, NOSTRO_DEPOSIT, OVERDRAFT, OVERDRAFT_INTEREST_WAIVED, FASTER_PAYMENTS_REFUND
  case STARLING_PAY_STRIPE, ON_US_PAY_ME, LOAN_PRINCIPAL_PAYMENT, LOAN_REPAYMENT, LOAN_OVERPAYMENT, LOAN_LATE_PAYMENT
  case SEPA_CREDIT_TRANSFER, SEPA_DIRECT_DEBIT, TARGET2_CUSTOMER_PAYMENT, FX_TRANSFER, ISS_PAYMENT, STARLING_PAYMENT
  case SUBSCRIPTION_CHARGE, OVERDRAFT_FEE
}

enum SourceSubType: String, Decodable, CaseIterable {
  case CONTACTLESS, MAGNETIC_STRIP, MANUAL_KEY_ENTRY, CHIP_AND_PIN, ONLINE, ATM, APPLE_PAY, ANDROID_PAY, FITBIT_PAY
  case GARMIN_PAY, SAMSUNG_PAY, OTHER_WALLET, NOT_APPLICABLE, UNKNOWN, DEPOSIT, OVERDRAFT, SETTLE_UP, NEARBY
  case TRANSFER_SAME_CURRENCY
}
