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
            assert query.accountId in balance, "Invalid accountId received in the update query";
            balance[query.accountId] = query.balance;
        }
        on eReadQuery do (query : (accountId : int))
        {
            assert query.accountId in balance, "Invalid accountId received in the read query";
            send server, eReadQueryResp, (accountId = query.accountId, balance = balance[query.accountId]);
        }
    }
}

fun ReadBankBalance(database : Database, accountId: int) : int {
    var currentBalance : int;
    send database, eReadQeury, (accountId = accountId,);
    receive { 
        case eReadQueryResp: (resp: (accountId: int, balance : int)) {
            currentBalance = resp.balance;
        }
    }
    return currentBalance;
}

fun UpdateBankBalance(database : Database, accId : int, bal : int)
{
    send database, eUpdateQuery, (accountId = accId, balance = bal);
}