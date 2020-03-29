//
//  Session.swift
//  BudgetMeApp
//
//  Created by Christian Leovido on 24/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import Foundation

/// Ideally a Session object would be replaced by @EnvironmentObject.
/// Singleton design pattern is not a great practice, but for this case, I leave it here to store the token and accountId selected.
/// The token is updated after logging in, but in this case I copy it just as a demo
final class Session {

    private init() {}

    private static var _shared = Session()

    static var shared: Session {
        return _shared
    }

    var accountId: String = ""

    var token: String {
        return "eyJhbGciOiJQUzI1NiIsInppcCI6IkdaSVAifQ.H4sIAAAAAAAAAH1TQZKbMBD8yhbn1ZZBgDG33PKBPGAYjWyVQaIk4WQrlb9HIAHG2crN3T3T08PIvzPlXNZmMComaDAfzoPtlb52oO8faIbsPXNTN1ecOyryy4mVEomVVVWw5owlq3NZ81rm8gIUiunXmLV51VSc11VdvWcKfCSK6pTPBCCaSfvvphdkfygRvIuLKDviHcNTg6zsODIQ0IQBsqvPF96I6hS8vbmTTh11XRJgHsZzzkp-BtagJHaueCHPxaXhTRE6wlrfEMm52IVUYdkQMRK8Cjs0FQMiHiB2ucypPkE3L4xmpHnlmJTdlqhMw0CtJRBvL4L_HF8EJUh7JRXZI98r5w9MAkLYELIlofwGouI94G2grXLHP63y9AaTvxmrXDgZU1qohxIT9LG4gx40pmgIVjA02lvTx0EzkzSjpbIDeGU0M5LJSQu3SW6bvoI4GifnzbCuSAOoZDyAFuCpFdRTqFvhUjaAvZOf046WJFkKAd3_pDgramMP4e0p7elql7DPjf-KqZUs3mBdYSAfnpaHFgNc1ISX5CN8Eq1SBGmJCPYipga4pp2itv5k3dTf2_UutFO7bcS7c8SbQW8wnPCpfCGYmW_5yqYua6Tq11Ax5YFaqiwhqdEfgDtK8ZM5eIQzOHY1e44Dl6IfuMXnmWHegnbhkF9Z7OIXXrsYTX14QfO7MFY8uR3Z1ebIrv2e5v8MQ_d4pUYhEzV1Dm34CNu7WlIALsTyTZ-JuSL78xdQSTA9QAUAAA.NT9IcdVSYBeaiJ1mjm1V4DIQOMt2Q1zuFeexjnGuZDFMkgSc1LOFEKKjcI7wEUF1Uxu-Tw_Nr35kjxIbq1WioZLJWURP5usUGGIqHkkccd0ATMvQ9yClKS0fH22DnHmW6cgG7hSnabx7J7zfEffahAhqBqEXaX4ZMyWecsdmP9ROR53jDU-aGX4ZcVfbIWG2JsKIecVo8URmCcD_NsW2A5jwCpE6H8lJL8dNNWev6zrmOa9kgii6Jh6GCMUeVQ4Rw41cREnJkaTIDLvMaE_Va050-N0b7oGvzTAOUumMAVDs6FJnV85CtsWEuD2RVShpTZCgQYvMQCTMgmaoTrCuDHQCy5LhUrTbZ4JadbvU2pUdIYA5P0W-bs08eH4Fq_-DMKJUX9oCYcGcvNN8l3BEDGEdwu1v-0IieJzjp-y9eB1m6hfgtJRz0QZ6qrSsi2GA1roGwZyOPbQ13btJQKY-EfU5KXyQvIuxbcpd-mSrSmCiVcuUK-OWAAbpmFcZX26yXtnGrg5hpXzIgGhe6z4V6yv7WC5I8pOnm7Mt9urbx9GSEzRz6N7UY26b5cN_8BQjRz_cugSpXAZk6mAwItqXCrwJUKUrcxL750gN0_9XmbnmaUEvbBaQ0ETIOjkv4GvOKjp5HeeT2EvCaNEZp1MTSJpRXjWQHdzTdz6qr202yWU"
    var refreshToken: String {
        return ""
    }

}
