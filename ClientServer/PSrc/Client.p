enum tWithDrawRespStatus {
    WITHDRAW_SUCCESS,
    WITHDRAW_ERROR
}

event eWithDrawReq : tWithDrawReq;
event eWitthDrawResp : tWithDrawResp;

machine Client
{
    var server : BankServer
    var accountId : int;
    var nextReqId : int;
    var numOfWithdrawOps : int;
    var currentBalance : int;

    start state Init {
        entry (input : (serv : BankServer, accountId: int, balance: int))
        {
            server = input.serv;
            currentBalance = input.balance;
            nextReqId = accountId * 100 + 1;
            goto WithdrawMoney;
        }
    }

    state WithdrawMoney {
        entry {
            if(currentBalance <= 10) {
                goto NoMoneyToWithDraw;
            }

            send server, eWithDrawReq, (source = this, accountId = accountId, amount = WithdrawAmount(), rId = nextReqId);
            nextReqId = nextReqId + 1;
        }

        on eWithDrawResp do (resp : tWithDrawResp) {
            assert resp.balance >= 10, "Bank balance must be greater than 10!!";
            if(resp.status == WITHDRAW_SUCCESS)
            {
                print format ("Withdrawal with rId= {0} succeeded, new account balance = {1}", resp.rId, resp.balance);
                currentBalance = resp.balance;
            }
            else
            {
                assert currentBalance == resp.balance,
                    format ("Withdraw failed BUT the account balance changed! cleint thinks: {0}, bank balance: {1}", currentBalance, resp.balance);
                print format ("Withdrawal with rId = {0} failed, account balance = {1}", resp.rId, resp.balance);
            }

            if(currentBalance > 10)
            {
                print format ("Still have account balance = {0}, lets try and withdraw more", currentBalance);
                goto WithdrawMoney;
            }
        }
    }

    fun WithdrawAmount() : int {
        return choose(currentBalance) + 1;
    }

    state NoMoenyToWithDraw {
        entry {
            assert currentBalance == 10, "Hmm, I still have money that I can withdraw but I have reached NoMoneyToWithDraw state!";
            print format ("No Money to withdraw, waiting for more deposits!");
        }
    }
}