module Client = { Client };

module Bank = { BankServer, Database };

module AbstractBank = { AbstractBankServer -> BankServer }