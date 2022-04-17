#!/usr/bin/env python3

from scapy.all import (
    Ether,
    Packet,
    StrFixedLenField,
    bind_layers,
    srp1
)


class Message(Packet):
    name = "Message"
    fields_desc = [StrFixedLenField("content", "", length=16)]


if __name__ == '__main__':
    ETH_TYPE_MSG = 0x1234
    bind_layers(Ether, Message, type=ETH_TYPE_MSG)

    try:
        pkt = Ether(dst='00:04:00:00:00:00', type=ETH_TYPE_MSG)
        pkt /= Message(content='') / ' '

        resp = srp1(pkt, iface='eth0', timeout=1, verbose=False)
        if resp:
            msg = resp[Message]
            if msg:
                print(msg.content.decode('utf-8'))
            else:
                print("Can't find Message header in the packet")
        else:
            print("Didn't receive response")
    except Exception as error:
        print(error)
