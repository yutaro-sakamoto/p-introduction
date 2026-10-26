test tcSingleClient [main=TestWithSingleClient]:
    assert eSpec_BankBalanceIsAlwaysCorrect, GuaranteeWithDrawProgress in
    (union Client, Bank, { TestWithSingleClient });

test tcMultipleClients [main=TestWithMultipleClients]:
    assert BankBalanceIsAlwaysCorrect, GuaranteedWithDrawProgress in
    (union Client, Bank, { TestWithMultipleClients });

test tcAbstractServer [main=TestWithSingleClient]:
    assert BankBalanceIsAlwaysCorrect, GuaranteedWithDrawProgress in
    (union Client, AbstractBank, { TestWithSingleClient });

test param (nClients in [2, 3, 4]) tcParameterizedMultipleClients [main=TestWithConfig]:
    assert BankBalanceIsAlwaysCorrect, GuaranteedWithDrawProgress in
    (union Client, Bank, { TestWithConfig });