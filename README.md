Baremetal D "Hello, World!" on Cortex-M3.
=====

*Repeats Michael V. Franklin work "D Runtime ARM Cortex-M study" for Cortex-M3
* https://github.com/JinShil/D_Runtime_ARM_Cortex-M_study/wiki/1.1---Hello,-World!
* http://wiki.dlang.org/Minimal_semihosted_ARM_Cortex-M_%22Hello_World%22*

I am used cheapest hardware:

* [Cheap STM32 Cortex-M3 board LeafLabs Maple Mini (replica?)](http://www.ebay.com/itm/141404280807) (need soldering!) - AU $5.52
* [ST-Link V2 JTAG SWD adaptor (replica)](http://www.aliexpress.com/snapshot/6796984210.html?orderId=68316685665367) - $3
* Breadboard (this is optional because LeafLabs Maple Mini pins allows connection to adaptor directly)
* and some wires from local store

![Hardware overview](overview.png)

LeafLabs Maple Mini has a USB connection port and bootloader installed, but it isn't used because it's need to test full build chain with JTAG connection.

Code
===

* start.d: code is slightly modified because some changes was occured in LDC libraries.
* stm32f103.ld: memory mapping slightly changed for support Maple's STM32F103RCBT6 MCU
