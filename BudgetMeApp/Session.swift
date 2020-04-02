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
        return "eyJhbGciOiJQUzI1NiIsInppcCI6IkdaSVAifQ.H4sIAAAAAAAAAH1Ty5KbMBD8lS3OO1vmacEtt_xAPmAkjWyVQaIk4WQrlX-PQGCMs5Ub3T3T6tGI35n2PusyHDVIGuyHD-h6bS4cze1D2CF7z_zE54ozpyJvT1ApQVDVdQHsLCpoctWUjcpVixSL6deYdXnN6jZvi6Z8zzSGRLCyYDOBQtjJhO-2l-R-aBm9i1ZWnEoO4sQEVLwUgBJZPEDx5tyWTNan6B3sjUzqqERd8qKsoWDEoWrzE7TUFtAqxU6i4axhKnbEsb4JQd6nrlJWspQNAlP5GapT_OJNWwE1Z8mUwFpV8wxe2JHmkVNSuC5RweBAnSOUby9C-BxfBC3JBK00uSPfax8OzAqkdDFkR1KHB0hKCCiuAz0qd_zT6UBvOIWrddrHlYE2Ut-1nLBPxRx7NGKNJtBJENYEZ_t00MysmjVKuwGDtgasAjUZ6R-Sf5y-gXS0mHywwzYiDahX4wGNxECdpJ5i3QaXsgHdjcKcdnSkyFEM6P8npbOSNvYY3542gS5uCfvc-K-4tpITV9xGGCjEpxWwExEu6oqX5CN-Em1SAusQCexFoAe8rDMlbfsEPvW3btsL7dRum_DunPDDoLcirvCpfCHAzrt8ZdcuZ5Xut1Ap5YFaqhwJ0mM4AH-U0pV5vMc1eLjYPceBW6MfuMXnmYHg0Pi4yK8sdvELr11MpiG-oPldWCef3I7sZnNkt_5A8z8Dwt9fqVGqlZq4Fy5ewuNdLSlQLMRyp8_EXJH9-QsIIVAuQAUAAA.gM04Plnpn3ytORZ6-FTw4eRFn_lps8K0oWu6hiDBSKUm6OrKciPqNYyX-Cau-PeAEJyKdUzsaUSLEqzuY85_3JpZ71RByjN9r3DxxYomE4VuNnYVkNOvhJxHRebEtBgcvkU6idrQQZ0Qb2Z0jjkTTzyNPToyMaWmZfNJDKrEz8X-nAS2nSnOLpQWhzMV4Fbk2akBVUXthB3PqmiO2OvLrY9JGGqEMCcMYz5vNTwvfRjAHQMm7Fsr3ADqVOeDgfiL0Lmrf6HCY_DeAA80UfW3pjUt5OZ-35YFdlV9QYeovpfKIabKmKx2s8KGRDm5M3JE9TkOcPtzW2HfGFlyoimsDDoBLMJn6AavOrGXuwQs5oSNo9bkA681-ULqiIZBCQuhgtSuo8VBBNJTCE1PPQG1vzqkHD2ltWYvM4sMt-rzu5m9NqUikShAe5sJYZOJuTMS6ZW0XNd6MtEOZuq8EQckKbhG-ut097vQ0dKwssf-0f28FjoyFsZnDm3AcsvQaKH9BXM6yqClQkLK-hKzb9lh2tb-Y1MFsPIncWmLoFm4tRxRCQqxsKP7wYxHnBqNXJ-XURsy2tRmpVOFrXnESI2bSAw-uNvEkLLF7DyWRsQiRaNl1MYr3Lvb-fampUkqrF7zHAMQfJ_V8U-JX_Sp7gArFI4T0As_QQQUM6py7XhQcz0"
    }

    var refreshToken: String {
        return "Zx1dMEpwRNfED9jrrexhAk3dRkLiDJ94qEs7nmBhyaFDBdGV0nUBUhgKs2eafStR"
    }

}
