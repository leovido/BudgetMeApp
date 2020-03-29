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
        return "eyJhbGciOiJQUzI1NiIsInppcCI6IkdaSVAifQ.H4sIAAAAAAAAAH1Ty5KbMBD8lS3Oqy1sxPOWW34gHzAajWyVQaIk4WQrlX-PQGCMs5Ub3T3T6tGI35n2PusyGDWTNNgPH8D12lwEmNsH2iF7z_wk5opa0PnU5owrJMbL8syaGjmrTqoqKnVSLVAspl9j1p3KpiybvG34e6YhJIK3vJwJQLSTCd9tL8n90DJ6n1vJBRWCYd4g46JABhKaeIASVd0WjSzz6B3sjUzqKCouq7o5s6LAMnaIlglRFKzEmtd5q2osqtgRx_qGSN6vXZLLQlbAGnWqGc_jl6hazqiqZaMQSsXnGTzakeaRU1J2XaIyAwN1jkC-vQjhc3wRtCQTtNLkjnyvfTgwK5DSxZAdSR0eICkhAF4HelTu-KfTgd5gClfrtI8rY9pIfddygj4VC-jB4BoNwUmG1gRn-3TQzKyaNUq7AYK2hlnF1GSkf0j-cfoG0tE4-WCHbUQaQK_GAxgJgTpJPcW6DS5lA7gbhTnt6EiRoxjQ_09KZyVt7CG-PW0CXdwS9rnxX3FtJYdX2EYYKMSnFaDDCBd1xUvyET6JNimBdYgE9iKmB7isMyVt-2Ri6m_dthfaqd024d054YdBbzGu8Kl8IZidd_nKrl3OKt1voVLKA7VUOULSYzgAf5TSlXm4xzV4drF7jgO3Rj9wi88zw4ID4-Miv7LYxS-8djGZhviC5ndhnXxyO7KbzZHd-gPN_wxDf3-lRqlWahIeXbyEx7taUgAuxHKnz8Rckf35Cx28PdxABQAA.VhakMSiJuCppMMe2Q7rkSZG9ZZWBUNYYTO7y05Wa97-u9UUqXP_Fp4cJpiV98-VRPvueNfja_hKHP6hpGkyPFgR4zoM1pzQN_fSC0g1vdsIc0BaGuDPIqoKZyzipavEU98CxntXgaGx04P9ISKRcb5rb19QtdE6n17JsWgB-2cNjXuXklO5FgD1jU50TO7kgXFIwvjYUQLL3pL3I6oh8RvFJT6cyQJN8Y-8sS7hxvEQBQZs9w5TkvFcx8aZzPA-xILYWrcAZlz9CS_UR2UGKocZ6yNYRTb1M6t3xt-gG7wj5JxzTpmSTptfsuqqUeAK3a38a4ShvK-g1eqfcxl-7jn4GhSG_F3t2HPRNZNfdDdSyIrZnEnE6qRRkM_RWHEhBkgxvQ5FrUKhTdWgd6OBOb_saEKla1GmHDEZKBxBq5iZ4w074yXN_i6yFP-OfWPtR3cXSXOe7Jn5mkI6qxgqIlPj5iy_tPeXfAtf0mA8A0KEfyzAqV4V3btCZU7j-y2BNjI0pZ5KGjwO3_PWv3IVpJ5ezUavKHNY8gzArUsv0bUeDfPfPHo9sTNCwC_Z7Q15bFXWfieIyu5MVBBOYoex3D3kRdAQEgzQZC-Vu44-pWYw8_3JdguMQmDmxfrSb5uRalG3kI-O22K2_JkkAW-555S6EOsjcnVmHP1MX6Om2Gmc"
    }

    var refreshToken: String {
        return ""
    }

}
