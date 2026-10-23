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