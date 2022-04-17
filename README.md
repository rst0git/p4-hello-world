# Hello World in P4

This is a simple P4 program that responds with Hello World message.

1. In your shell, run:
```bash
make
```
This will compile `hello-world.p4` and start a Mininet instance with one
switches (`s1`) connected to one host (`h1`).

2. Run the small Python-based client program that will allow you to test the P4
program. You can run the program directly from the Mininet command prompt:

```
mininet> h1 python client.py
Hello World!
```