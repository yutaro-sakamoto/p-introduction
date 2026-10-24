machine TestWithSingleClient
{
    start state Init {
        entry {
            SetupClientServerSystem(1);
        }
    }
}

machine TestWithMultipleClients
{
    start state Init {
        entry {
            SetupClientServerSystem(choose(3) + 2);
        }
    }
}

param nClients: int;

machine TestWithConfig {
    start state Init {
        entry {
            SetupClientServerSystem(nClients);
        }
    }
}

fun CreateRandomInitialAccounts(numAccounts : int) : map[int, int]
{
    var i: int;
    var bankBalance: map[int, int];
    while(i < numAccounts) {
        bankBalance[i] = choose(100) + 10;
        i = i + 1;
    }
    return bankBalance;
}

fun SetupClientServerSystem(numClients: int)
{
    var i: int;
    var server: BankServer;
    var accountIds: seq[int];
    var initAccBalance: map[int, int];

    initAccBalance = CreateRandomInitialAccounts(numClients);
    server = new BankServer(initAccBalance);

    announce eSpec_BankBalanceIsAlwaysCorrect_Init, initAccBalance;

    accountIds = key(initAccBalance);

    while(i < sizeof(accountIds)) {
        new Client((serv = server, accountId = accountIds[i], balance = initAccBalance[accountIds[i]]));
        i = i + 1;
    }
}