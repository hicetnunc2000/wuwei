
import smartpy as sp

class Client(sp.Contract):
    def __init__(self):
        self.init(
            value = 0
            )
            
    @sp.entry_point
    def request_key(self, params):
        #sp.verify(sp.sender == self.data.tz_peer)
        
        c = sp.contract(sp.TString, params.kt, entry_point="key_request").open_some()
        sp.transfer(params.key, sp.mutez(0), c)
    
    @sp.entry_point
    def return_value(self, params):
        #sp.verify(sp.sender == self.data.sol)
        self.data.value = params


class Wuwei(sp.Contract):
    def __init__(self, tz, link):
        self.init(
            tz_peer = tz,
            link_peer = link,
            prices = {
                'CNY' : 0,
                'BRL' : 0,
                'EUR' : 0,
                'CAN' : 0,
                'INR' : 0,
                'JPY' : 0,
                'KRW' : 0,
                'RUB' : 0,
                'CHF' : 0,
                'HKD' : 0,
                'SGD' : 0,
                'AED' : 0,
                'QAR' : 0
            },
            round = 0,
            times = 10000,
            pair = 'USDT'
            # auth list?
            )

    @sp.entry_point
    def prices_input(self, params):
        #sp.verify(sp.sender = self.data.tz_peer)
        self.data.prices = params.OBJ
        self.data.round += 1

        
    @sp.entry_point
    def key_request(self, params):
        # you need to specify:
        # a key
        # a contract for a callback
        # an entrypoint for the callback
        
        c = sp.contract(sp.TNat, sp.sender, entry_point="return_value").open_some()
        sp.transfer(self.data.prices[params], sp.mutez(0), c)
        
if "templates" not in __name__:
    @sp.add_test(name = "wuwei")
    def test():
        
        acc = sp.test_account(2)
        c1 = Wuwei(acc.address, '0x')
        
        scenario = sp.test_scenario()
        scenario.h1("Wuwei Deployment")
        scenario += c1
        scenario.h1("Round inputs")
        scenario += c1.prices_input(OBJ={
                'CNY' : 545,
                'BRL' : 3131,
                'EUR' : 242,
                'CAN' : 5453,
                'INR' : 42342,
                'JPY' : 13123,
                'KRW' : 4232,
                'RUB' : 52554,
                'CHF' : 242,
                'HKD' : 423433,
                'SGD' : 423,
                'AED' : 4333,
                'QAR' : 34
            })

        scenario.h1("Initialize Client")
        c2 = Client()
        scenario += c2
        scenario.h1("Request value from key")
        scenario += c2.request_key(kt=c1.address, key='BRL')
       