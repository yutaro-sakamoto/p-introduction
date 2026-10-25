test tcSingleClient [main=TestWithSingleClient]:
    assert eSpec_BankBalanceIsAlwaysCorrect, GuaranteeWithDrawProgress in
    (union Client, Bank, { TestWithSingleClient });

test tcMultipleClients [main=TestWithMultipleClients]:
    assert BankBalanceIsAlwaysCorrect, GuaranteedWithDrawProgress in
    (union Client, Bank, { TestWithMultipleClients });

