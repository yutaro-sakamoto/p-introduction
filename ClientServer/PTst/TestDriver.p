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