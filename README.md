# nana 

Nana is developer/testing tool for C/C++ which supports design by
contract using a mix of code and GDB debugger support. It intended
to be used for:

* Safety critical or high reliability systems.
* Embedded systems where the GDB.

Some of its benefits are space and time efficency, e.g.the default
`assert(i>=10)` implementation on an i386 uses 52 bytes vs 10 bytes
for nana inline checks (or 1 byte if you are using GDB based assertion
checking). 
