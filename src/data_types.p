event eRequest: bool;

machine Client {
    start state Init {
        on eRequest do (b: bool) { }
    }
}

machine Main {
    start state Init {
        entry {
            var i: int;
            var j: float;
            var k: string;
            var l: bool;
            var ev: event;
            var client: machine;

            ev = eRequest;
            client = new Client();
            i = 10; j = 10.0; k = "Failure!!";
            l = (i == (j to int));
            assert l, k;

            send client, ev, l;
        }
    }
}
