machine BankServer
{
    var database: Database;

    start state Init {
        entry (initialBalance : map[int, int]) {
            database = new Database((server = this, initialBalance = initialBalance));
            goto WaitForWithdrawRequests;
        }
    }

    state WaitForWithdrawRequests {
        on eWithDrawReq do (wReq : tWithDrawReq) {
            var currentBalance : int;
            var response : tWithDrawResp;

            currentBalance = ReadBankBalance(database, wReq.accountId);
            if(currentBalance - wReq.amount >= 10)
            {
                UpdateBankBalance(database, wRerq.accountId, currentBalance - wReq.amount);
                response = (status = WITHDRAW_SUCCESS
            }
            else
            {
                response = (status = WITHDRAW_ERROR, accountId = wReq.accountId, balance = currentBalance, rId = wReq.rId);
            }
            send wReq.source, eWithDrawResp, response;
        }
    }
}

machine Database
{
    var server: BankServer;
    var balance: map[int, int];
    start state Init {
        entry(input: (server : BankServer, initialBalnace: map[int, int])) {
            server = input.server;
            balance = input.initialBalance;
        }
        on eUpdateQuery do (query : (account : int))
        {
            assert query.accountId in balance, "Invalid accountId received in the read query";
            balance[query.accountId] = query.balance;
        }
    }
}