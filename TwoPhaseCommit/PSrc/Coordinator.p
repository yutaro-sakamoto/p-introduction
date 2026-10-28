type tTrans = (key: string, val: int, transId: int);

type tWriteTransReq = (client: Client, trans: Trans);

type tWriteTransResp = (transId: int, status: tTransStatus);

type tReadTransReq = (client: Client, key: string);

type tReadTransResp = (key: string, val: int, status: tTransStatus);

enum tTransStatus {
    SUCCESS,
    ERROR,
    TIMEOUT
}

event eWriteTransReq : tWriteTransReq;
event eWriteTransResp : tWriteTransResp;