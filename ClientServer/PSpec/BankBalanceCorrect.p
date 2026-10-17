spec BankBalanceIsAlwaysCorrect observes eWithDrawReq,  eWithDrawResp, eSpec_BankBalanceIsAlwaysCorrect_Init {
    var bankBalance: map[int, int];
    var pendingWithDraws: map[int, tWithDrawReq];
}